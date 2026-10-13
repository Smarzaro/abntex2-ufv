#!/bin/sh
# Gera dist/abntex2-ufv.zip no formato de submissão à CTAN: uma pasta abntex2-ufv/ com
# a classe, o pacote, o README, o guia (docs/) e o modelo (modelo-tcc/).
# A disposição interna é a mesma do repositório, então o guia e o modelo continuam
# compilando (eles procuram o .cls e o .sty na pasta pai).
# Uso (na raiz do repositório):  scripts/make-ctan-zip.sh
# Os PDFs incluídos são os que estão na árvore de trabalho; compile antes (latexmk em
# docs/ e em modelo-tcc/) para que estejam atualizados.
set -eu
cd "$(dirname "$0")/.."
pkg=abntex2-ufv
dist=dist
rm -rf "$dist"
mkdir -p "$dist/$pkg"

# arquivos da raiz
for f in abntex2-ufv.cls abntex2-ufv.sty README.md LICENSE; do
  [ -f "$f" ] && cp "$f" "$dist/$pkg/"
done

# guia e modelo: apenas arquivos versionados no git (sem auxiliares nem build/)
git ls-files docs modelo-tcc | while read -r f; do
  mkdir -p "$dist/$pkg/$(dirname "$f")"
  cp "$f" "$dist/$pkg/$f"
done

# o PDF do guia precisa existir
[ -f "$dist/$pkg/docs/guia-abntex2-ufv.pdf" ] || { echo "faltou docs/guia-abntex2-ufv.pdf" >&2; exit 1; }

( cd "$dist" && zip -qr "$pkg.zip" "$pkg" )
echo "Gerado $dist/$pkg.zip"
( cd "$dist" && unzip -l "$pkg.zip" | tail -n 1 )
