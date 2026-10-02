#!/usr/bin/env bash
# Gera relatorio.pdf a partir de relatorio.md
set -e
cd "$(dirname "$0")"
pandoc relatorio.md \
  -o relatorio.pdf \
  --pdf-engine=xelatex \
  --from=markdown+pipe_tables+raw_tex \
  -V geometry:a4paper \
  -V geometry:margin=2.2cm \
  -V mainfont="DejaVu Serif" \
  -V sansfont="DejaVu Sans" \
  -V monofont="DejaVu Sans Mono" \
  -V fontsize=11pt \
  -V linkcolor=blue \
  -V urlcolor=blue \
  -V lang=pt-BR \
  --highlight-style=tango \
  --toc --toc-depth=2 \
  -V toc-title="Sumário"
echo "gerado: relatorio.pdf"
