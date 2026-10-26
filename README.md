# abntex2-ufv
[![build](https://github.com/Smarzaro/abntex2-ufv/actions/workflows/build.yml/badge.svg?branch=master)](https://github.com/Smarzaro/abntex2-ufv/actions/workflows/build.yml)
[![release](https://img.shields.io/github/v/release/Smarzaro/abntex2-ufv)](https://github.com/Smarzaro/abntex2-ufv/releases/latest)
[![License: LPPL 1.3c](https://img.shields.io/badge/license-LPPL%201.3c-blue.svg)](https://www.latex-project.org/lppl.txt)
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.23345952.svg)](https://doi.org/10.5281/zenodo.23345952)
[![CTAN](https://img.shields.io/ctan/v/abntex2-ufv)](https://ctan.org/pkg/abntex2-ufv)


**Version 1.7.1** (2026-10-26)

**Summary (English):** abntex2-ufv is a LaTeX class, built on top of the
abnTeX2 class, for undergraduate final theses (TCC) of the Information
Systems program at the Federal University of Viçosa (UFV), Rio Paranaíba
campus, Brazil. It implements the formatting rules of the UFV
normalization manual (2026-2 edition; ABNT NBR 14724/2025, NBR 6023/2025
and NBR 10520/2023): page layout, fonts, section headings, cover, title
and approval pages, abstract, lists of figures/tables/charts/code, acronym
list (via `acro`), glossary, figure/table/chart captions with source and
notes, and biblatex-abnt tweaks. The class is a thin layer: it sets the
defaults (12pt, A4, one-sided, Brazilian Portuguese), loads only what it
needs itself (the author's own packages, such as graphicx and biblatex, are
loaded in the document preamble, as in the template), and loads the
customization package `abntex2-ufv.sty`. It requires LaTeX 2022-06 or newer
(`\DeclareKeys`). Versions 1.5 and later are transition releases: using
the `.sty` directly on top of `abntex2` still works but is deprecated, and
the `.sty` will be discontinued in version 2.0, so theses should be migrated
to `\documentclass{abntex2-ufv}`. The documentation (in Portuguese)
contains a complete example thesis, and an empty template is included.

This material is subject to the LaTeX Project Public License 1.3c.
Author: Rodrigo Smarzaro. Documentation: `doc/abntex2-ufv.pdf`.

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
português do Brasil. A classe cuida do layout e carrega só o que ela mesma
precisa (`fontenc`, `indentfirst`, `acro`); os pacotes de uso do autor
(`graphicx`, `csquotes`, `microtype`, `biblatex` com o estilo `abnt` e os de
tabelas) ficam no preâmbulo do documento, como no template, onde o editor os
reconhece e você controla as opções.

## Conteúdo

| Arquivo/pasta | Descrição |
|---|---|
| `tex/abntex2-ufv.cls` | a classe: padrões do manual e pacotes de uso comum |
| `tex/abntex2-ufv.sty` | a personalização (margens, fonte, capa, folha de rosto, folha de aprovação, resumo, listas, siglas, glossário, ilustrações, tabelas e quadros, ajustes do biblatex-abnt); carregada pela classe. O uso direto com `\usepackage` está obsoleto (será descontinuado na 2.0) |
| `doc/abntex2-ufv.pdf` | **documentação** com um trabalho de exemplo completo, dicas de metodologia científica e de uso da classe, e exemplos de referências, tabelas e quadros (fontes: `doc/abntex2-ufv.tex` e `doc/example/`) |
| `doc/template/` | **template (modelo vazio)**: copie esta pasta e escreva o seu trabalho |
| `CHANGES.md` | histórico de versões |

## Uso

Opções (todas opcionais): `twoside`, `openany`, `11pt`, `10pt`,
`fonte=arial` ou `fonte=cm` e `capacampus`.

```latex
\documentclass[twoside, fonte=arial]{abntex2-ufv}
```

> **Versões 1.5 e seguintes (transição).** O uso antigo,
> `\documentclass{abntex2}` + `\usepackage{abntex2-ufv}`, continua
> funcionando, mas emite um aviso e **o `.sty` será descontinuado na versão
> 2.0**. Trabalhos novos devem usar a classe, e os trabalhos em andamento
> devem ser migrados (veja [Migração](#migração-do-pacote-para-a-classe)).

Para começar um trabalho, use a pasta `doc/template`:

```bash
cd doc/template
latexmk
```

As imagens do trabalho ficam na pasta `imagens/` (o template já declara
`\graphicspath{{imagens/}}`): basta `\includegraphics{arquivo}`, sem o
nome da pasta.

O `latexmkrc` grava o PDF na própria pasta e os arquivos auxiliares em
`build/` (ignorada pelo git), e procura o `abntex2-ufv.cls` em `../../tex`.
Se o pacote estiver instalado, ou se copiar o template para outro lugar
junto com o `.cls` e o `.sty`, apague a linha `ensure_path` do `latexmkrc`.

## Migração do pacote para a classe

Resumo (o passo a passo completo está na seção "Migração do pacote para
a classe" do Apêndice C da documentação, [`abntex2-ufv.pdf`](doc/abntex2-ufv.pdf)):

1. Substitua os arquivos pelos da versão 1.5 ou posterior (o nome agora é em
   minúsculas: apague o `abntex2-UFV.sty` antigo).
2. Troque `\documentclass[...]{abntex2}` por `\documentclass{abntex2-ufv}`.
   Remova as opções que já são padrão (`12pt`, `a4paper`, `oneside`,
   `openright`, `english`, `brazilian`) e leve as opções do pacote
   (`fonte=`, `capacampus`) para os colchetes da classe.
3. Apague `\usepackage{abntex2-UFV}`, `fontenc` e `indentfirst` (a classe os
   carrega). Mantenha os demais pacotes no preâmbulo.
4. Mantenha o `biblatex` e o `xurl` no preâmbulo; apague `\urlstyle{same}`,
   `\setlength{\bibparsep}{10pt}` (deixava as referências mais afastadas que uma
   linha em branco) e `\setlength{\emergencystretch}` (a classe define o resto).
5. Apague o filtro do aviso do `babel` (`silence`/`\WarningFilter`).
6. Mova as imagens para a pasta `imagens/` e declare
   `\graphicspath{{imagens/}}` no preâmbulo.
7. Apague o `\hypersetup` e o `\frenchspacing` do modelo antigo (a classe já os
   define).
8. Compile e confira que o aviso "Uso obsoleto" não aparece mais.

> **Da 1.5/1.6 para a 1.7:** a classe deixou de carregar `graphicx`, `csquotes`,
> `microtype`, `booktabs`, `tabularx`, `multirow` e `biblatex`. Acrescente-os ao
> preâmbulo (veja o `doc/template/template.tex`). A opção `nobiblatex` foi
> removida (é ignorada com um aviso).

Antes e depois:

```latex
% versão 1.3.1
\documentclass[12pt, openright, oneside, a4paper, english, brazilian]{abntex2}
\usepackage{abntex2-UFV}
% ... fontenc, indentfirst, graphicx, csquotes, microtype, booktabs, tabularx,
% multirow, biblatex, xurl, \setlength{...}

% versão 1.7 ou posterior
\documentclass{abntex2-ufv}
\usepackage{graphicx}
\graphicspath{{imagens/}}
\usepackage{csquotes}
\usepackage[final]{microtype}
\usepackage[backend=biber, style=abnt, uniquename=init, giveninits,
            repeatfields, justify, noslsn]{biblatex}
\usepackage{xurl}
\addbibresource{referencias.bib}
```

## Download e Overleaf

Cada versão é publicada em [Releases](https://github.com/Smarzaro/abntex2-ufv/releases) com três arquivos:

| Arquivo | Para quê |
|---|---|
| [`abntex2-ufv-template.zip`](https://github.com/Smarzaro/abntex2-ufv/releases/latest/download/abntex2-ufv-template.zip) | projeto vazio (template), pronto para começar o trabalho |
| [`abntex2-ufv-example.zip`](https://github.com/Smarzaro/abntex2-ufv/releases/latest/download/abntex2-ufv-example.zip) | documentação com o trabalho de exemplo completo |
| `abntex2-ufv.zip` | pacote no formato da CTAN |

No **Overleaf**: *New Project* → *Upload Project* → escolha
`abntex2-ufv-template.zip` (ou o do exemplo). O projeto já traz o `.cls` e o `.sty`
na raiz; use o compilador pdfLaTeX (o `biber` roda automaticamente).
Os links `.../releases/latest/download/...` sempre apontam para a versão mais recente.
As versões 1.5 e anteriores usam os nomes antigos (`abntex2-ufv-modelo.zip` e
`abntex2-ufv-guia.zip`).

## Requisitos

LaTeX de junho de 2022 ou mais recente (TeX Live ou MiKTeX 2022+), pdfLaTeX,
`biber` e os pacotes `abntex2`, `biblatex-abnt`, `acro`, `tgtermes`/`tgheros`,
`silence` e `etoolbox` (usados pela classe); o template usa também `csquotes`,
`microtype`, `graphicx`, `biblatex` e `xurl`. Todos estão incluídos no MiKTeX e
no TeX Live completo. A documentação usa ainda `booktabs`, `tabularx`,
`multirow`, `tikz`, `pgfplots`, `listings`, `tcolorbox`, `siunitx`, `longtable`
e `colortbl`.

## Como citar

Use o botão **Cite this repository** do GitHub (arquivo
[`CITATION.cff`](CITATION.cff)) ou o DOI do Zenodo, que reúne todas as versões:
[10.5281/zenodo.23345952](https://doi.org/10.5281/zenodo.23345952).

## Autor

- Rodrigo Smarzaro ([Universidade Federal de Viçosa](https://www.ufv.br))

## Licença

Distribuído sob a [LaTeX Project Public License (LPPL), versão 1.3c ou
posterior](https://www.latex-project.org/lppl.txt); veja o arquivo
[`LICENSE`](LICENSE) no repositório. Veja <https://github.com/abntex/abntex2/>
para a classe abnTeX2.
