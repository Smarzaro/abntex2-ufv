#!/bin/sh
# Compila os documentos de teste em tests/ e falha se algum tiver erro, referência
# indefinida ou citação indefinida. Uso (na raiz do repositório):  scripts/run-tests.sh
# O abntex2-ufv.cls e o .sty são procurados em tex/ (na raiz do repositório).
set -u
raiz="$(cd "$(dirname "$0")/.." && pwd)"
case "$(uname -s)" in
  MINGW*|MSYS*|CYGWIN*) sep=';'; raiz="$(cd "$raiz" && pwd -W)" ;; # caminho no formato do Windows
  *) sep=':' ;;
esac
export TEXINPUTS="${raiz}/tex//${sep}"
cd "$raiz/tests" || exit 1
rm -rf build   # evita resíduos de execuções anteriores
falhas=0
for t in t*.tex; do
  nome="${t%.tex}"
  echo "== $nome"
  if ! latexmk -pdf -interaction=nonstopmode -outdir=build "$t" > "build-$nome.out" 2>&1; then
    echo "FALHA: erro de compilação em $t"; tail -n 25 "build-$nome.out"; falhas=$((falhas+1))
    rm -f "build-$nome.out"; continue
  fi
  rm -f "build-$nome.out"
  if grep -E "^!|There were undefined references|Citation .* undefined|Please \(re\)run" "build/$nome.log"; then
    echo "FALHA: problemas no log de $t"; falhas=$((falhas+1))
  else
    echo "ok"
  fi
done
echo "Falhas: $falhas"
exit $((falhas > 0))
