# Changes

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
