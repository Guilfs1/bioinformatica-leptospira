# RELATÓRIO DE ESTUDO DE CASO: ANÁLISE PROTEÔMICA E EPÍTOPOS DA BACTÉRIA *Leptospira interrogans*

**IDENTIFICAÇÃO DA EQUIPE**

* **Integrantes:** Guilherme Guzzo
* **Data:** __/09/2026

---

## 1. CARACTERIZAÇÃO DO ORGANISMO PATOGÊNICO

* **Descrição morfológica:** Espiroqueta. Bactéria helicoidal, fina e flexível, com
  aproximadamente 0,1–0,15 µm de diâmetro por 6–20 µm de comprimento. Suas extremidades
  são encurvadas em gancho e lembram um sinal de interrogação — origem do epíteto
  específico *interrogans*. A motilidade é dada por dois flagelos periplasmáticos
  (endoflagelos), um em cada polo, internos ao envelope celular, que produzem o
  deslocamento em saca-rolhas característico do gênero; observam-se movimentos
  translacionais e não translacionais.

* **Classificação de Gram:** **Gram-negativa.** Possui envelope diderme, com membrana
  externa contendo lipopolissacarídeo (LPS) e proteínas de superfície. Na prática, cora
  mal pelo método de Gram: o diâmetro de ~0,1 µm está próximo do limite de resolução da
  microscopia óptica convencional e a composição da membrana externa retém pouco corante.
  Por isso a visualização é feita por microscopia de campo escuro, impregnação por prata
  (método de Levaditi) ou imunofluorescência. Vale registrar uma particularidade dos
  espiroquetas: a camada de peptidoglicano associa-se à membrana citoplasmática, e não ao
  espaço periplasmático como nas gram-negativas clássicas.

* **Patologia:** **Leptospirose.** Zoonose de distribuição mundial, com cerca de 1 milhão
  de casos e aproximadamente 60 mil óbitos por ano segundo o CDC. A transmissão ocorre
  por contato com água ou solo contaminados pela urina de animais infectados — roedores
  são o principal reservatório e eliminam a bactéria de forma assintomática, além de
  bovinos, suínos, equinos, ovinos, caprinos, cães e gatos. A entrada se dá por pele
  lesada ou por mucosas. O período de incubação vai de 2 a 30 dias. O curso é bifásico:
  a fase anictérica, responsável por cerca de 90% dos casos, cursa com febre, calafrios,
  cefaleia intensa, mialgia (marcadamente em panturrilhas), náusea, vômito e diarreia; a
  forma grave, conhecida como **doença de Weil**, evolui com icterícia, insuficiência
  renal aguda, fenômenos hemorrágicos, meningite e síndrome de hemorragia pulmonar, com
  letalidade elevada. O tratamento de escolha é doxiciclina ou penicilina. No Brasil é
  agravo de notificação compulsória, com surtos classicamente associados a enchentes.

* **Curiosidade:** *L. interrogans* não utiliza glicose como fonte principal de carbono e
  não realiza glicólise funcional. Seu carbono e sua energia vêm da **β-oxidação de
  ácidos graxos de cadeia longa insaturados**, e é justamente por isso que o meio de
  cultura EMJH precisa ser suplementado com Tween e soro — uma bactéria patogênica que,
  bioquimicamente, "come gordura" em vez de açúcar. É aeróbia obrigatória e depende de
  fosforilação oxidativa. Dois outros pontos chamam atenção: os mais de 300 sorovares da
  espécie são definidos pelas diferenças no antígeno O do LPS, e a chaperona HtpG é fator
  de virulência essencial — mutantes *htpG* são completamente avirulentos, com 100% de
  sobrevivência em hamsters mesmo sob doses altas do inóculo.

* **Cepa analisada:** **56601**, sorovar Lai, sorogrupo Icterohaemorrhagiae. Cepa
  altamente virulenta isolada na China e a primeira *Leptospira* a ter o genoma completo
  sequenciado (Ren *et al.*, 2003). Taxon ID NCBI: 189518.

* **Imagem em microscópio da bactéria:**
  Micrografia eletrônica de varredura (MEV) de duas células de *Leptospira interrogans*
  (cepa RGA) aderidas a um filtro de 0,2 µm. A cepa RGA foi isolada em 1915 do sangue de
  um soldado belga.
  *Fonte: CDC Public Health Image Library, imagem ID 1220 — domínio público.
  Crédito: CDC/Rob Weyant, PhD, MS; foto de Janice Haney Carr.*

---

## 2. DADOS DO PROTEOMA (UNIPROT)

* **ID do Proteoma de Referência:** UP000001408
* **Espécie/Linhagem:** *Leptospira interrogans* serogroup Icterohaemorrhagiae serovar Lai
  (strain 56601) — Taxon ID 189518
* **Total de proteínas no proteoma:** **3.676** (387 revisadas em Swiss-Prot e 3.289 não
  revisadas em TrEMBL)
* **Total de cromossomos:** **2**, ambos circulares
  * Cromossomo I — GenomeAccession **AE010300** — 3.384 proteínas (~4,3 Mb)
  * Cromossomo II — GenomeAccession **AE010301** — 292 proteínas (~350 kb)
* **Classificação:** Reference proteome. Completude BUSCO de 100% (239/239 genes
  completos, linhagem Spirochaetia).
* **Lista de publicações associadas:**
  1. Ren S.-X., Fu G., Jiang X.-G., Zeng R., Miao Y.-G., Xu H., Zhang Y.-X., Xiong H.,
     Lu G., Lu L.-F., Jiang H.-Q., Jia J., Tu Y.-F., Jiang J.-X., Gu W.-Y., Zhang Y.-Q.,
     Cai Z., Sheng H.-H., Yin H.-F., Zhang Y., Zhu G.-F., Wan M., Huang H.-L., Qian Z.,
     Wang S.-Y., Ma W., Yao Z.-J., Shen Y., Qiang B.-Q., Xia Q.-C., Guo X.-K., Danchin A.,
     Saint Girons I., Somerville R.L., Wen Y.-M., Shi M.-H., Chen Z., Xu J.-G., Zhao G.-P.
     **"Unique physiological and pathogenic features of *Leptospira interrogans* revealed
     by whole-genome sequencing."** *Nature*, 2003; 422:888–893.
     PubMed: 12712204 — DOI: 10.1038/nature01597

  *Observação: o registro do proteoma UP000001408 no UniProt lista uma única publicação
  associada, o artigo do genoma completo acima.*

---

## 3. AMBIENTE DE EXECUÇÃO (HARDWARE)

* **CPU (Processador):** _[a preencher com a saída de coletar_hardware.ps1]_
* **Memória RAM:** _[a preencher]_
* **Armazenamento:** _[a preencher]_
* **Sistema Operacional:** _[a preencher — Windows + WSL2 (Ubuntu), Docker Desktop]_

---

## 4. RESULTADOS: FASTPROTEIN

* **Tempo total de processamento:** _[pendente de execução]_
* **Total de proteínas processadas:** _[pendente]_
* **Total de proteínas ignoradas:** _[pendente]_
* **Proteínas com domínio transmembranar:** _[pendente]_
* **Proteínas com evidências de membrana:** _[pendente]_

### 4.1. Gráficos Gerados

_[gráfico de localização subcelular — pendente]_

_[gráfico de dispersão pI x massa molecular — pendente]_

---

## 5. RESULTADOS: EPIBUILDER

* **Nº de proteínas (das 50) com epítopos preditos:** _[pendente]_

### 5.1. Tabela dos 5 Primeiros Epítopos Preditos

_[pendente]_

### 5.2. Topologia do Epítopo #1

_[pendente]_

---

## 6. REPOSITÓRIO

Qual o repositório git: _[a definir]_

* [ ] relatorio.pdf
* [ ] input.fasta
* [ ] top50.fasta
* [ ] results_fastprotein/
* [ ] results_epibuilder/
