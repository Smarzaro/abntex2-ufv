#!/bin/sh
# Confere se a versão é a mesma em todos os arquivos que a registram:
#   tex/abntex2-ufv.cls  tex/abntex2-ufv.sty  README.md  CHANGES.md  CITATION.cff  doc/abntex2-ufv.tex
# Se o script receber um argumento (por exemplo, o nome da tag, como 1.6), confere também
# se a versão coincide com ele.
# Uso (na raiz do repositório):  sh scripts/check-version.sh [versao]
set -u
cd "$(dirname "$0")/.."
cls=$(sed -n 's#^\\ProvidesClass{[^}]*}\[[0-9/]* v\([0-9][0-9.]*\) .*#\1#p' tex/abntex2-ufv.cls | head -1)
sty=$(sed -n 's#^\\ProvidesPackage{[^}]*}\[[0-9/]* v\([0-9][0-9.]*\) .*#\1#p' tex/abntex2-ufv.sty | head -1)
readme=$(sed -n 's#^\*\*Version \([0-9][0-9.]*\)\*\* .*#\1#p' README.md | head -1)
changes=$(sed -n 's|^## \([0-9][0-9.]*\) .*|\1|p' CHANGES.md | head -1)
cff=$(sed -n 's#^version: "\([0-9][0-9.]*\)".*#\1#p' CITATION.cff | head -1)
doc=$(sed -n 's#^%% Versão \([0-9][0-9.]*\) .*#\1#p' doc/abntex2-ufv.tex | head -1)
ref="${1:-$cls}"
erro=0
for par in "cls=$cls" "sty=$sty" "README=$readme" "CHANGES=$changes" "CITATION=$cff" "doc=$doc"; do
  nome="${par%%=*}"; v="${par#*=}"
  if [ "$v" = "$ref" ]; then echo "ok   $nome: $v"; else echo "ERRO $nome: '$v' (esperado '$ref')"; erro=1; fi
done
exit $erro
