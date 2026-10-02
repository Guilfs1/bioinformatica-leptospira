# Estudo de caso — *Leptospira interrogans*

Análise proteômica e predição de epítopos do proteoma de referência de
*Leptospira interrogans* sorovar Lai (cepa 56601), usando **FastProtein** e
**EpiBuilder**.

Disciplina de Bioinformática — IFSC Câmpus Gaspar
Integrante: Guilherme Guzzo

## Organismo

| | |
|---|---|
| Espécie | *Leptospira interrogans* serovar Lai (strain 56601) |
| Proteoma UniProt | [UP000001408](https://www.uniprot.org/proteomes/UP000001408) |
| Taxon ID | 189518 |
| Proteínas | 3.676 |
| Cromossomos | 2 (AE010300, AE010301) |
| Gram | negativa → EpiBuilder com `--loc gram_neg` |

## Conteúdo

| Arquivo / diretório | Descrição |
|---|---|
| `relatorio.pdf` | Relatório do estudo de caso |
| `input.fasta` | Proteoma completo baixado do UniProt |
| `top50.fasta` | 50 primeiras proteínas de membrana preditas pelo FastProtein |
| `results_fastprotein/` | Saída completa do FastProtein |
| `results_epibuilder/` | Saída completa do EpiBuilder |
| `run_analysis.ps1` | Pipeline de execução (PowerShell + Docker Desktop) |
| `run_analysis.sh` | Mesmo pipeline em bash, para Linux/WSL |

## Reprodução

Requer Docker Desktop (Windows) ou Docker Engine (Linux).

```powershell
# Windows, PowerShell
powershell -ExecutionPolicy Bypass -File run_analysis.ps1
```

```bash
# Linux ou WSL
bash run_analysis.sh
```

O script baixa as imagens, obtém o proteoma do UniProt, executa o FastProtein
sobre o proteoma completo, recorta as 50 primeiras proteínas de membrana e
executa o EpiBuilder sobre esse recorte, registrando todos os logs em `logs/`.

## Softwares

- **FastProtein** — Moreira RS, Benetti Filho V, Maia GA, Soratto TAT, Kawagoe EK,
  Russi BC, Miletti LC, Wagner G. *FastProtein — an automated software for in silico
  proteomic analysis.* PeerJ 12:e18309 (2024). https://doi.org/10.7717/peerj.18309
- **EpiBuilder** — https://github.com/labioinfoufsc/EpiBuilder

## Referência do genoma

Ren S.-X. *et al.* *Unique physiological and pathogenic features of Leptospira
interrogans revealed by whole-genome sequencing.* Nature 422:888–893 (2003).
PMID 12712204 — https://doi.org/10.1038/nature01597
