# abntex2-ufv

[![License: LPPL 1.3c](https://img.shields.io/badge/license-LPPL%201.3c-blue.svg)](LICENSE)

**Summary (English):** abntex2-ufv is a LaTeX class, built on top of the
abnTeX2 class, for undergraduate final theses (TCC) of the Information
Systems program at the Federal University of Viçosa (UFV), Rio Paranaíba
campus, Brazil. It implements the formatting rules of the UFV
normalization manual (2026-2 edition; ABNT NBR 14724/2025, NBR 6023/2025
and NBR 10520/2023): page layout, fonts, section headings, cover, title
and approval pages, abstract, lists of figures/tables/charts/code, acronym
list (via `acro`), glossary, figure/table/chart captions with source and
notes, and biblatex-abnt tweaks. The class is a thin layer: it sets the
defaults (12pt, A4, one-sided, Brazilian Portuguese), loads the packages
every thesis needs, and loads the customization package
`abntex2-ufv.sty`, which can also be used alone on top of `abntex2`. A
complete example thesis and an empty template are included. License: LPPL
1.3c or later. Author: Rodrigo Smarzaro. Documentation (Portuguese): see
`docs/guia-abntex2-ufv.pdf`.

---

Classe LaTeX para os Trabalhos de Conclusão de Curso (TCC) do curso de
Sistemas de Informação da Universidade Federal de Viçosa (Campus Rio
Paranaíba), baseada na classe abnTeX2 e no *Manual de Normalização de
Trabalhos Acadêmicos* da UFV (edição 2026-2; ABNT NBR 14724/2025, NBR
6023/2025 e NBR 10520/2023).

```latex
\documentclass{abntex2-ufv}
```

Os padrões já seguem o manual: 12pt, A4, impressão só no anverso e
português do Brasil. A classe carrega os pacotes que todo TCC usa
(`fontenc`, `indentfirst`, `graphicx`, `csquotes`, `microtype`,
`booktabs`, `tabularx`, `multirow`, `acro` e o `biblatex` com o estilo
`abnt`).

## Conteúdo

| Arquivo/pasta | Descrição |
|---|---|
| `abntex2-ufv.cls` | a classe: padrões do manual e pacotes de uso comum |
| `abntex2-ufv.sty` | a personalização (margens, fonte, capa, folha de rosto, folha de aprovação, resumo, listas, siglas, glossário, ilustrações, tabelas e quadros, ajustes do biblatex-abnt); carregada pela classe |
| `modelo-tcc/` | **modelo vazio**: copie esta pasta e escreva o seu trabalho |
| `docs/` | **guia** com um trabalho de exemplo completo, dicas de metodologia científica e de uso da classe, e exemplos de referências, tabelas e quadros ([`guia-abntex2-ufv.pdf`](docs/guia-abntex2-ufv.pdf)) |

## Uso

Opções (todas opcionais): `twoside`, `openany`, `11pt`, `10pt`,
`fonte=arial` ou `fonte=cm`, `capacampus` e `nobiblatex`.

```latex
\documentclass[twoside, fonte=arial]{abntex2-ufv}
```

Quem prefere partir da classe `abntex2` pode carregar só a
personalização (nesse caso os demais pacotes e o `biblatex` ficam por
sua conta):

```latex
\documentclass{abntex2}
\usepackage{abntex2-ufv}
```

Para começar um trabalho, use a pasta `modelo-tcc`:

```bash
cd modelo-tcc
latexmk
```

O `latexmkrc` grava o PDF na própria pasta e os arquivos auxiliares em
`build/` (ignorada pelo git), e procura o `abntex2-ufv.cls` na pasta pai.
Se copiar `modelo-tcc` para outro lugar, copie o `.cls` e o `.sty`
junto e apague a linha `ensure_path` do `latexmkrc`. No Overleaf,
coloque o `.cls` e o `.sty` ao lado do arquivo principal e use o
compilador pdfLaTeX (o `biber` roda automaticamente).

## Requisitos

pdfLaTeX, `biber` e os pacotes `abntex2`, `biblatex-abnt`, `acro`,
`tgtermes`/`tgheros`, `csquotes`, `booktabs`, `tabularx`, `multirow`,
`microtype` e `silence` (todos incluídos no MiKTeX e no TeX Live
completo). O guia usa ainda `tikz`, `pgfplots`, `listings`,
`tcolorbox`, `siunitx`, `longtable` e `colortbl`.

## Autor

Rodrigo Smarzaro ([Universidade Federal de Viçosa](https://www.ufv.br))

Repositório e contato: <https://github.com/Smarzaro/abntex2-ufv>

## Licença

Distribuído sob a [LaTeX Project Public License (LPPL), versão 1.3c ou
posterior](https://www.latex-project.org/lppl.txt); veja o arquivo
[`LICENSE`](LICENSE). Veja <https://github.com/abntex/abntex2/> para a
classe abnTeX2.
