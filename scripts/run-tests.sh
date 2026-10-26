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
# limite de tempo por documento (evita travar o CI em caso de laço), se o timeout existir
if command -v timeout >/dev/null 2>&1; then limite="timeout 300"; else limite=""; fi
for t in t*.tex; do
  nome="${t%.tex}"
  # t7 em diante (listagens, ilustrações, fonte, apêndices) também compilam com LuaLaTeX e
  # não podem ter avisos da classe, do hyperref, de fontes nem Overfull (t9 deve ter Overfull)
  case "$nome" in
    t7-*|t8-*|t9-*|t10-*|t11-*) motores="-pdf -lualatex"; estrito=1 ;;
    *) motores="-pdf"; estrito=0 ;;
  esac
  for motor in $motores; do
    echo "== $nome ($motor)"
    saida="build/${motor#-}"
    if ! $limite latexmk $motor -interaction=nonstopmode -outdir="$saida" "$t" < /dev/null > "build-$nome.out" 2>&1; then
      echo "FALHA: erro de compilação em $t ($motor)"; tail -n 25 "build-$nome.out"; falhas=$((falhas+1))
      rm -f "build-$nome.out"; continue
    fi
    rm -f "build-$nome.out"
    log="$saida/$nome.log"
    if grep -E "^!|There were undefined references|Citation .* undefined|Please \(re\)run" "$log"; then
      echo "FALHA: problemas no log de $t ($motor)"; falhas=$((falhas+1)); continue
    fi
    if [ "$estrito" = 1 ]; then
      if grep -E "^Package (abntex2-ufv|hyperref) Warning|^Class (abntex2-ufv|memoir) Warning|^LaTeX Font Warning|Font shape .* undefined" "$log"; then
        echo "FALHA: avisos no log de $t ($motor)"; falhas=$((falhas+1)); continue
      fi
      if [ "$nome" = "t9-tabela-larga" ]; then
        if ! grep -q "^Overfull .hbox" "$log"; then
          echo "FALHA: $t deveria gerar Overfull \hbox (conteúdo mais largo que a página)"; falhas=$((falhas+1)); continue
        fi
      elif grep -E "^Overfull .hbox" "$log"; then
        echo "FALHA: Overfull \hbox no log de $t ($motor)"; falhas=$((falhas+1)); continue
      fi
    fi
    echo "ok"
  done
done
echo "Falhas: $falhas"
exit $((falhas > 0))
