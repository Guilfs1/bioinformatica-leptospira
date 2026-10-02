#!/usr/bin/env bash
# =============================================================================
#  Estudo de caso - Leptospira interrogans (sorovar Lai, cepa 56601)
#  Proteoma de referencia UniProt: UP000001408
#  Pipeline: FastProtein -> top50 proteinas de membrana -> EpiBuilder
#
#  Rodar dentro do WSL (Ubuntu) com Docker Desktop + integracao WSL2 ativa.
#  Uso:  bash run_analysis.sh
# =============================================================================
set -uo pipefail

PROTEOME="UP000001408"
WORKDIR="$(pwd)"
LOGDIR="${WORKDIR}/logs"
mkdir -p "${LOGDIR}"

hr() { printf '%s\n' "-----------------------------------------------------------"; }

hr
echo "Diretorio de trabalho : ${WORKDIR}"
echo "Proteoma              : ${PROTEOME}"
echo "Inicio                : $(date -Is)"
hr

# --- 0. Registro do hardware (vai para a secao 3 do relatorio) ---------------
{
  echo "### DATA DA COLETA: $(date -Is)"
  echo
  echo "### CPU"
  lscpu 2>/dev/null | grep -Ei 'model name|^cpu\(s\)|core|thread|mhz' || true
  echo
  echo "### MEMORIA RAM"
  free -h 2>/dev/null || true
  echo
  echo "### ARMAZENAMENTO (visao do WSL)"
  df -hT / 2>/dev/null || true
  lsblk -o NAME,ROTA,SIZE,TYPE,MODEL 2>/dev/null || true
  echo "(ROTA=0 indica SSD/NVMe; ROTA=1 indica HD mecanico)"
  echo
  echo "### SISTEMA OPERACIONAL"
  uname -a
  cat /etc/os-release 2>/dev/null | head -3
  echo
  echo "### DOCKER"
  docker version --format '{{.Server.Version}}' 2>/dev/null || docker --version
} > "${LOGDIR}/hardware.txt" 2>&1
echo "[ok] Hardware registrado em logs/hardware.txt"

# --- 1. Baixa as imagens Docker ---------------------------------------------
echo "[1/5] Baixando imagens Docker (primeira vez demora alguns minutos)..."
docker pull bioinfoufsc/fastprotein:clean-latest   2>&1 | tee "${LOGDIR}/pull_fastprotein.log"
docker pull bioinfoufsc/epibuilder-core           2>&1 | tee "${LOGDIR}/pull_epibuilder.log"

# --- 2. Baixa o proteoma completo do UniProt --------------------------------
echo "[2/5] Baixando o proteoma ${PROTEOME} do UniProt..."
curl -s "https://rest.uniprot.org/uniprotkb/stream?format=fasta&query=proteome:${PROTEOME}" -o input.fasta
N_IN=$(grep -c '^>' input.fasta || echo 0)
echo "[ok] input.fasta gravado - ${N_IN} sequencias"
if [ "${N_IN}" -lt 3000 ]; then
  echo "[ERRO] Esperado ~3676 proteinas. Download incompleto - repita este passo." >&2
  exit 1
fi

# --- 3. FastProtein sobre o proteoma completo -------------------------------
echo "[3/5] Executando FastProtein (pode levar de 5 a 20 minutos)..."
FP_START=$(date +%s)
docker run --rm -v "${WORKDIR}":/data bioinfoufsc/fastprotein:clean-latest \
  fastprotein -i /data/input.fasta -o /data/results_fastprotein \
  2>&1 | tee "${LOGDIR}/fastprotein.log"
FP_END=$(date +%s)
echo "[ok] FastProtein concluido em $(( FP_END - FP_START )) segundos (wall clock)"

if [ ! -f results_fastprotein/raw/membranes.fasta ]; then
  echo "[ERRO] results_fastprotein/raw/membranes.fasta nao foi gerado." >&2
  find results_fastprotein -maxdepth 2 -type f | head -40 >&2
  exit 1
fi

# --- 4. Separa as 50 primeiras proteinas de membrana ------------------------
echo "[4/5] Extraindo as 50 primeiras proteinas de membrana..."
awk '/^>/{c++} c<=50' results_fastprotein/raw/membranes.fasta > top50.fasta
N_TOP=$(grep -c '^>' top50.fasta || echo 0)
echo "[ok] top50.fasta gravado - ${N_TOP} sequencias"

# --- 5. EpiBuilder sobre as 50 proteinas ------------------------------------
#  ATENCAO: Leptospira interrogans e GRAM-NEGATIVA -> --loc gram_neg
echo "[5/5] Executando EpiBuilder (--loc gram_neg)..."
EB_START=$(date +%s)
docker run --rm \
  -v "${WORKDIR}":/data/ \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v epibuilder-data:/tmp/epibuilder \
  -e EPIBUILDER_VOLUME=epibuilder-data \
  bioinfoufsc/epibuilder-core epibuilder \
  --input_file /data/top50.fasta \
  --loc gram_neg \
  --output /data/results_epibuilder \
  2>&1 | tee "${LOGDIR}/epibuilder.log"
EB_END=$(date +%s)
echo "[ok] EpiBuilder concluido em $(( EB_END - EB_START )) segundos (wall clock)"

# --- 6. Inventario dos resultados + pacote para envio -----------------------
{
  echo "### TEMPOS (wall clock, medidos pelo script)"
  echo "FastProtein : $(( FP_END - FP_START ))s"
  echo "EpiBuilder  : $(( EB_END - EB_START ))s"
  echo
  echo "### CONTAGENS"
  echo "input.fasta  : ${N_IN} sequencias"
  echo "top50.fasta  : ${N_TOP} sequencias"
  echo
  echo "### ARQUIVOS GERADOS - results_fastprotein"
  find results_fastprotein -type f -printf '%10s  %p\n' 2>/dev/null | sort -k2
  echo
  echo "### ARQUIVOS GERADOS - results_epibuilder"
  find results_epibuilder -type f -printf '%10s  %p\n' 2>/dev/null | sort -k2
} > "${LOGDIR}/manifest.txt" 2>&1
echo "[ok] Inventario em logs/manifest.txt"

rm -f resultados_para_claude.zip
zip -qr resultados_para_claude.zip \
  logs results_fastprotein results_epibuilder top50.fasta \
  -x 'results_epibuilder/work/*' '*/.nextflow/*' 2>/dev/null
echo
hr
echo "CONCLUIDO em $(date -Is)"
echo "Envie o arquivo: ${WORKDIR}/resultados_para_claude.zip"
hr
