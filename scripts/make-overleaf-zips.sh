#!/bin/sh
# Gera, em dist/, dois projetos prontos para enviar ao Overleaf (New Project > Upload Project):
#   abntex2-ufv-template.zip  template vazio: abntex2-ufv.cls, .sty, template.tex, capitulos/,
#                             imagens/, referencias.bib (tudo na raiz do projeto)
#   abntex2-ufv-example.zip   documentação com o trabalho de exemplo completo: abntex2-ufv.tex,
#                             example/, abntex2-ufv.cls e .sty (tudo na raiz do projeto)
# Os nomes dos zips são fixos para que o link .../releases/latest/download/<nome> não mude.
# Uso (na raiz do repositório):  sh scripts/make-overleaf-zips.sh
set -eu
cd "$(dirname "$0")/.."
dist=dist
tmp="$dist/_tmp"
mkdir -p "$dist"
rm -rf "$tmp" "$dist/abntex2-ufv-template.zip" "$dist/abntex2-ufv-example.zip"

# copia os arquivos versionados de uma pasta para a raiz de um projeto, sem latexmkrc
# (o Overleaf usa o próprio latexmk e roda o biber sozinho) e sem os PDFs gerados
copiar() { # $1 = pasta de origem, $2 = pasta de destino
  mkdir -p "$2"
  git ls-files "$1" | while read -r f; do
    rel="${f#"$1"/}"
    case "$rel" in latexmkrc|*/latexmkrc|*.pdf) continue ;; esac
    case "$1" in doc) case "$rel" in template/*) continue ;; esac ;; esac
    mkdir -p "$2/$(dirname "$rel")"
    cp "$f" "$2/$rel"
  done
  cp tex/abntex2-ufv.cls tex/abntex2-ufv.sty "$2/"
}

copiar doc/template "$tmp/template"
copiar doc "$tmp/example"

( cd "$tmp/template" && zip -qr "../../abntex2-ufv-template.zip" . )
( cd "$tmp/example" && zip -qr "../../abntex2-ufv-example.zip" . )
rm -rf "$tmp"
echo "Gerados:"; ls -l "$dist"/abntex2-ufv-*.zip | awk '{print $5, $9}'
