# Changes

## 1.7.1 (2026-10-26)

- Fix: `ilustracao` (and `tabela`) with the optional width argument, e.g.
  `\begin{ilustracao}[\linewidth]`, now typesets its content in a `minipage` of that width
  (the argument is the width of the illustration, no longer only a minimum width of the
  title and footer). Before, a `listings` listing inside it was typeset at the natural width
  of its longest line: `breaklines` was ignored, the box overflowed the margin (Overfull
  `\hbox`) and the caption was shifted. Without the argument nothing changes (natural width),
  and content wider than the given width still produces an Overfull `\hbox`. Documents
  that wrapped each listing in `minipage{\linewidth}` keep working and can drop it.
- Fix: the `listings` patch for an indented `\end{lstlisting}` was never applied (the
  `\ifboolexpr`/`test{\ifdefined...}` guard was always false), so the warning "O listings
  mudou" appeared in every run. The guard now works; the patch is applied (the blank line
  with `keepspaces=true` still exists in listings 1.11b) and the warning is gone.
- No more `Token not allowed in a PDF string: removing \uppercase` (hyperref) in the
  first chapter of appendices and annexes: `\uppercase` is disabled in PDF bookmarks only.
- The class filters the harmless `memoir` deprecation warning for `\settocpreprocessor`
  (used by `abntex2`, still working).
- Documentation and template: the monospaced font is `FiraMono` with `lining` figures
  (`\usepackage[scaled=0.88,lining]{FiraMono}`); comparison with other fonts, advice on long
  `\texttt` terms (`\path`; `beramono` with `scaled=0.81` listed as an alternative) and migration note in the guide (Appendices C and D).
- Tests: `t7` to `t11` (listings, narrow figure, wide table that must keep warning,
  monospaced font, appendices), also compiled with LuaLaTeX by `scripts/run-tests.sh`,
  which now fails on class/hyperref/font warnings and on unexpected Overfull `\hbox`.

## 1.7 (2026-10-17)

- **Breaking for documents that relied on the class loading packages (1.5 and 1.6):** the
  class now loads only what it needs itself (`fontenc`, `indentfirst`, `acro`, `silence`,
  `etoolbox`). `graphicx`, `csquotes`, `microtype`, `booktabs`, `tabularx`, `multirow`,
  `biblatex` and `xurl` are no longer loaded by the class; load them in the document
  preamble, as the template does. This also lets TeXstudio and LaTeX Workshop recognize their
  commands. The `\graphicspath{{imagens/}}` declaration moved to the template.
- The class option `nobiblatex` is obsolete and ignored with a warning.
- Class options are now declared with the kernel `\DeclareKeys` (requires LaTeX 2022-06 or
  newer).
- The class now sets, as defaults that the document can override: link colors
  (`\hypersetup`), PDF title/author/subject from `\titulo`, `\autor` and the preamble note,
  `\frenchspacing` and `\urlstyle{same}` (when `biblatex` is loaded).
- Removed the old `\setlength{\bibparsep}{10pt}`: in a list the space between items is
  `\itemsep + \parsep`, so it made the gap between references larger than one blank line;
  the biblatex default (0pt) with biblatex-abnt's `\bibitemsep` (one baseline) is correct.
- The `listings` fix for an indented `\end{lstlisting}` is applied only if the internal
  macros it patches exist, with a warning otherwise.
- New macro `\ufvversion`; `scripts/check-version.sh` checks it.
- Template: cleaner preamble in numbered sections (packages, acronyms, thesis data),
  magic comments for TeXstudio/VS Code (`pdflatex`, `biber`); no code-listing block (see the
  resources guide).
- Documentation: migration section (Appendix C) updated for 1.7.

## 1.6.1 (2026-10-14)

- Fix: `\autoref` printed English names ("Figure", "Table", "Appendix") unless
  `brazilian` was given in `\documentclass[...]`. The class now propagates the languages
  (Brazilian Portuguese as main language, English as additional) to the global options of
  the document, so hyperref and babel receive them. A regression check was added to the
  tests.
- The template (`doc/template/template.tex`) is now a single file with the whole text
  inside; the tip on splitting the text into files with `\input` is kept as a comment.

## 1.6 (2026-10-13)

- Repository and package layout reorganized for CTAN: `tex/` (class and package),
  `doc/` (documentation with the complete example thesis, and `doc/template/`, the empty
  template).
- Documentation is now `doc/abntex2-ufv.pdf` (was `guia-abntex2-ufv.pdf`); the example
  files are in `doc/example/` with the prefix `example-`; the template is
  `doc/template/template.tex` (was `modelo-tcc/modelo-tcc.tex`).
- Downloadable Overleaf projects renamed to `abntex2-ufv-template.zip` and
  `abntex2-ufv-example.zip`.
- Text files use LF line endings.

## 1.5 (2026-10-13)

- New class `abntex2-ufv.cls`: sets the defaults of the UFV manual (12pt, A4, one-sided,
  Brazilian Portuguese), loads the packages every thesis needs, and configures
  biblatex-abnt. Options: `twoside`, `openany`, `10pt`/`11pt`, `fonte=arial|cm`,
  `capacampus`, `nobiblatex`.
- Images go in the `imagens/` folder (`\graphicspath`).
- Loading `abntex2-ufv.sty` directly with `\usepackage` is deprecated and issues a
  warning; **it will be discontinued in version 2.0**. Migration steps are in the
  documentation (Appendix C).
- Empty template and example thesis updated to the UFV manual 2026-2 (NBR 14724/2025,
  6023/2025, 10520/2023).

## 1.3.1 and earlier

- Versions 1.0 to 1.3.1 provided only `abntex2-UFV.sty` for the abnTeX2 class, with the
  template `UFV-modelo-TCC.tex`.
