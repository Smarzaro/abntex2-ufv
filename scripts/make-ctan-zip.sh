#!/bin/sh
# Gera dist/abntex2-ufv.zip no formato de submissão à CTAN: uma pasta abntex2-ufv/ com
# README.md, CHANGES.md, tex/ (abntex2-ufv.cls e .sty) e doc/ (documentação com o
# trabalho de exemplo e o template). A disposição é a mesma do repositório.
#
# Ficam de fora (só do repositório): .github/, scripts/, tests/, CITATION.cff, LICENSE,
# doc/latexmkrc e arquivos gerados (apenas o PDF da documentação, doc/abntex2-ufv.pdf,
# é incluído). Só entram arquivos versionados no git.
#
# O zip deve ser gerado em Linux (o workflow "release" faz isso), onde os arquivos de
# texto têm só LF e o zip os marca como texto, como a CTAN pede.
# Uso (na raiz do repositório):  sh scripts/make-ctan-zip.sh
# Compile antes (latexmk em doc/) para que o PDF esteja atualizado.
set -eu
cd "$(dirname "$0")/.."
pkg=abntex2-ufv
dist=dist
out="$dist/$pkg"
rm -rf "$out" "$dist/$pkg.zip"
mkdir -p "$out"

git ls-files README.md CHANGES.md tex doc | while read -r f; do
  case "$f" in doc/latexmkrc) continue ;; esac
  mkdir -p "$out/$(dirname "$f")"
  cp "$f" "$out/$f"
done

[ -f "$out/doc/abntex2-ufv.pdf" ] || { echo "faltou doc/abntex2-ufv.pdf (compile a documentação)" >&2; exit 1; }
[ -f "$out/README.md" ] && [ -f "$out/tex/abntex2-ufv.cls" ] || { echo "arquivos obrigatórios ausentes" >&2; exit 1; }

# a CTAN pede só LF nos arquivos de texto: aviso se houver CR
if grep -rlI "$(printf '\r')" "$out" >/dev/null 2>&1; then
  echo "AVISO: há arquivos de texto com CRLF; gere o zip em Linux (workflow release)." >&2
fi

( cd "$dist" && zip -qr "$pkg.zip" "$pkg" )
echo "Gerado $dist/$pkg.zip"
( cd "$dist" && unzip -l "$pkg.zip" | tail -n 1 )
