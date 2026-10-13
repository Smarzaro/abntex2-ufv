#!/bin/sh
# Gera, em dist/, dois projetos prontos para enviar ao Overleaf (New Project > Upload Project):
#   abntex2-ufv-modelo.zip   modelo vazio: abntex2-ufv.cls, .sty, modelo-tcc.tex, capitulos/,
#                            imagens/, referencias.bib (tudo na raiz do projeto)
#   abntex2-ufv-guia.zip     guia com o trabalho de exemplo completo (também na raiz)
# Os nomes dos zips são fixos para que o link .../releases/latest/download/<nome> não mude.
# Uso (na raiz do repositório):  sh scripts/make-overleaf-zips.sh
set -eu
cd "$(dirname "$0")/.."
dist=dist
tmp="$dist/_tmp"
mkdir -p "$dist"
rm -rf "$tmp" "$dist/abntex2-ufv-modelo.zip" "$dist/abntex2-ufv-guia.zip"

# copia os arquivos versionados de uma pasta para a raiz de um projeto, sem latexmkrc
# (o Overleaf usa o próprio latexmk e roda o biber sozinho) e sem os PDFs gerados
copiar() { # $1 = pasta de origem, $2 = pasta de destino
  mkdir -p "$2"
  git ls-files "$1" | while read -r f; do
    rel="${f#"$1"/}"
    case "$rel" in latexmkrc|*.pdf) continue ;; esac
    mkdir -p "$2/$(dirname "$rel")"
    cp "$f" "$2/$rel"
  done
}

for projeto in modelo guia; do
  if [ "$projeto" = modelo ]; then origem=modelo-tcc; else origem=docs; fi
  destino="$tmp/$projeto"
  copiar "$origem" "$destino"
  for f in abntex2-ufv.cls abntex2-ufv.sty LICENSE; do
    [ -f "$f" ] && cp "$f" "$destino/"
  done
  ( cd "$destino" && zip -qr "../../abntex2-ufv-$projeto.zip" . )
done
rm -rf "$tmp"
echo "Gerados:"; ls -l "$dist"/abntex2-ufv-*.zip | awk '{print $5, $9}'
