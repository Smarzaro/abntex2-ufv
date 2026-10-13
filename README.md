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
`abntex2-ufv.sty`. Version 1.5 is a transition release: using the `.sty`
directly on top of `abntex2` still works but is deprecated, and the `.sty`
will be discontinued in version 2.0, so theses should be migrated to
`\documentclass{abntex2-ufv}`. A complete example thesis and an empty
template are included. License: LPPL
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
| `abntex2-ufv.sty` | a personalização (margens, fonte, capa, folha de rosto, folha de aprovação, resumo, listas, siglas, glossário, ilustrações, tabelas e quadros, ajustes do biblatex-abnt); carregada pela classe. O uso direto com `Sepackage` está obsoleto (será descontinuado na 2.0) |
| `modelo-tcc/` | **modelo vazio**: copie esta pasta e escreva o seu trabalho |
| `docs/` | **guia** com um trabalho de exemplo completo, dicas de metodologia científica e de uso da classe, e exemplos de referências, tabelas e quadros ([`guia-abntex2-ufv.pdf`](docs/guia-abntex2-ufv.pdf)) |

## Uso

Opções (todas opcionais): `twoside`, `openany`, `11pt`, `10pt`,
`fonte=arial` ou `fonte=cm`, `capacampus` e `nobiblatex`.

```latex
\documentclass[twoside, fonte=arial]{abntex2-ufv}
```

> **Versão 1.5 (transição).** O uso antigo, `\documentclass{abntex2}` +
> `\usepackage{abntex2-ufv}`, continua funcionando, mas emite um aviso e
> **o `.sty` será descontinuado na versão 2.0**. Trabalhos novos devem
> usar a classe, e os trabalhos em andamento devem ser migrados (veja
> [Migração](#migração-do-pacote-para-a-classe)).

Para começar um trabalho, use a pasta `modelo-tcc`:

```bash
cd modelo-tcc
latexmk
```

As imagens do trabalho ficam na pasta `imagens/` (a classe define
`\graphicspath{{imagens/}}`): basta `\includegraphics{arquivo}`, sem o
nome da pasta. Quem usa só o `.sty` deve declarar o `\graphicspath`
no próprio documento.

O `latexmkrc` grava o PDF na própria pasta e os arquivos auxiliares em
`build/` (ignorada pelo git), e procura o `abntex2-ufv.cls` na pasta pai.
Se copiar `modelo-tcc` para outro lugar, copie o `.cls` e o `.sty`
junto e apague a linha `ensure_path` do `latexmkrc`. No Overleaf,
coloque o `.cls` e o `.sty` ao lado do arquivo principal e use o
compilador pdfLaTeX (o `biber` roda automaticamente).

## Migração do pacote para a classe

Resumo (o passo a passo completo está na seção "Migração do pacote para
a classe" do Apêndice C do guia, [`guia-abntex2-ufv.pdf`](docs/guia-abntex2-ufv.pdf)):

1. Substitua os arquivos pelos da versão 1.5 (o nome agora é em
   minúsculas: apague o `abntex2-UFV.sty` antigo).
2. Troque `\documentclass[...]{abntex2}` por `\documentclass{abntex2-ufv}`.
   Remova as opções que já são padrão (`12pt`, `a4paper`, `oneside`,
   `openright`, `english`, `brazilian`) e leve as opções do pacote
   (`fonte=`, `capacampus`) para os colchetes da classe.
3. Apague `\usepackage{abntex2-UFV}` e os pacotes que a classe já carrega
   (`fontenc`, `indentfirst`, `graphicx`, `csquotes`, `microtype`,
   `booktabs`, `tabularx`, `multirow`).
4. Apague a configuração do `biblatex`, o `xurl` e os `\setlength` de
   `\bibparsep` e `\emergencystretch`; mantenha o `\addbibresource`.
5. Apague o filtro do aviso do `babel` (`silence`/`\WarningFilter`).
6. Mova as imagens para a pasta `imagens/`.
7. Compile e confira que o aviso "Uso obsoleto" não aparece mais.

Antes e depois:

```latex
% versão 1.3.1
\documentclass[12pt, openright, oneside, a4paper, english, brazilian]{abntex2}
\usepackage{abntex2-UFV}
% ... fontenc, indentfirst, graphicx, csquotes, microtype, booktabs, tabularx,
% multirow, biblatex, xurl, \setlength{...}

% versão 1.5 ou posterior
\documentclass{abntex2-ufv}
\addbibresource{referencias.bib}
```

## Download e Overleaf

Enquanto o pacote não estiver na CTAN, cada versão é publicada em
[Releases](https://github.com/Smarzaro/abntex2-ufv/releases) com três arquivos:

| Arquivo | Para quê |
|---|---|
| [`abntex2-ufv-modelo.zip`](https://github.com/Smarzaro/abntex2-ufv/releases/latest/download/abntex2-ufv-modelo.zip) | projeto vazio, pronto para começar o trabalho |
| [`abntex2-ufv-guia.zip`](https://github.com/Smarzaro/abntex2-ufv/releases/latest/download/abntex2-ufv-guia.zip) | guia com o trabalho de exemplo completo |
| `abntex2-ufv.zip` | pacote no formato da CTAN |

No **Overleaf**: *New Project* → *Upload Project* → escolha
`abntex2-ufv-modelo.zip` (ou o do guia). O projeto já traz o `.cls` e o `.sty`
na raiz; use o compilador pdfLaTeX (o `biber` roda automaticamente).
Os links `.../releases/latest/download/...` sempre apontam para a versão mais recente.

## Requisitos

pdfLaTeX, `biber` e os pacotes `abntex2`, `biblatex-abnt`, `acro`,
`tgtermes`/`tgheros`, `csquotes`, `booktabs`, `tabularx`, `multirow`,
`microtype` e `silence` (todos incluídos no MiKTeX e no TeX Live
completo). O guia usa ainda `tikz`, `pgfplots`, `listings`,
`tcolorbox`, `siunitx`, `longtable` e `colortbl`.

## Como citar

Use o botão **Cite this repository** do GitHub (arquivo
[`CITATION.cff`](CITATION.cff)).

## Autor

Rodrigo Smarzaro ([Universidade Federal de Viçosa](https://www.ufv.br))

Repositório e contato: <https://github.com/Smarzaro/abntex2-ufv>

## Licença

Distribuído sob a [LaTeX Project Public License (LPPL), versão 1.3c ou
posterior](https://www.latex-project.org/lppl.txt); veja o arquivo
[`LICENSE`](LICENSE). Veja <https://github.com/abntex/abntex2/> para a
classe abnTeX2.
