%%
%% abntex2-ufv.cls
%%
%% Classe para Trabalhos de Conclusão de Curso (TCC) de Sistemas de Informação da
%% Universidade Federal de Viçosa (Campus Rio Paranaíba), baseada na classe abnTeX2
%% (https://github.com/abntex/abntex2) e no "Manual de Normalização de Trabalhos
%% Acadêmicos" da Biblioteca Central da UFV (edição 2026-2; ABNT NBR 14724/2025,
%% NBR 6023/2025 e NBR 10520/2023).
%%
%% This work may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either version 1.3
%% of this license or (at your option) any later version.
%% The latest version of this license is in
%%   http://www.latex-project.org/lppl.txt
%% and version 1.3 or later is part of all distributions of LaTeX
%% version 2005/12/01 or later.
%%
%% This work has the LPPL maintenance status `maintained'.
%%
%% The Current Maintainer of this work is Rodrigo Smarzaro (smarzaro@ufv.br)
%%
%% Esta classe é uma camada fina sobre abntex2 + abntex2-ufv.sty: ela define os
%% padrões do manual (12pt, A4, frente apenas, português do Brasil), carrega os
%% pacotes que todo TCC usa e configura o biblatex-abnt. Toda a personalização
%% (margens, fonte, capa, listas, siglas etc.) está em abntex2-ufv.sty.
%%
\NeedsTeXFormat{LaTeX2e}[1994/06/01]
\ProvidesClass{abntex2-ufv}[2026/10/13 v1.6 Classe abntex2-ufv (TCC SI UFV-CRP)]

% A classe abntex2 carrega o babel com o nome obsoleto "brazil"; o aviso é inofensivo
\RequirePackage{silence}
\WarningFilter{babel}{Name 'brazil' is deprecated}
\RequirePackage{etoolbox}

% ---
% Opções
%   fonte=times|arial|cm   fonte do texto (padrão: times); veja abntex2-ufv.sty
%   capacampus             imprime campus e curso na capa
%   nobiblatex             não carrega o biblatex (para quem usa outro sistema)
%   oneside|twoside        frente apenas (padrão) ou frente e verso
%   openright|openany      capítulos em página ímpar (padrão) ou em qualquer página
%   10pt|11pt|12pt         tamanho da letra (padrão e exigido pelo manual: 12pt)
% As demais opções são repassadas à classe abntex2 (e, por ela, ao memoir).
% O papel é sempre A4; o idioma principal é o português do Brasil, com inglês
% como idioma adicional para hifenização.
% ---
\newif\ifufv@biblatex \ufv@biblatextrue
\newcommand{\ufv@side}{oneside}
\newcommand{\ufv@open}{openright}
\newcommand{\ufv@pt}{12pt}

\DeclareOption{nobiblatex}{\ufv@biblatexfalse}
\DeclareOption{capacampus}{\PassOptionsToPackage{capacampus}{abntex2-ufv}}
\DeclareOption{oneside}{\renewcommand{\ufv@side}{oneside}}
\DeclareOption{twoside}{\renewcommand{\ufv@side}{twoside}}
\DeclareOption{openright}{\renewcommand{\ufv@open}{openright}}
\DeclareOption{openany}{\renewcommand{\ufv@open}{openany}}
\DeclareOption{10pt}{\renewcommand{\ufv@pt}{10pt}}
\DeclareOption{11pt}{\renewcommand{\ufv@pt}{11pt}}
\DeclareOption{12pt}{\renewcommand{\ufv@pt}{12pt}}
\DeclareOption{a4paper}{}
\DeclareOption*{%
  \in@{=}{\CurrentOption}%
  \ifin@
    \PassOptionsToPackage{\CurrentOption}{abntex2-ufv}% fonte=...
  \else
    \PassOptionsToClass{\CurrentOption}{abntex2}%
  \fi}
\ProcessOptions\relax

\PassOptionsToPackage{english,brazilian}{babel}
\PassOptionsToClass{\ufv@pt,a4paper,\ufv@side,\ufv@open}{abntex2}
\LoadClass{abntex2}

% ---
% Personalização UFV e pacotes que todo TCC usa
% ---
\def\ufv@viacls{}                   % avisa o .sty que ele foi carregado pela classe
\RequirePackage{abntex2-ufv}
\RequirePackage[T1]{fontenc}        % códigos de fonte de saída
\RequirePackage{indentfirst}        % indenta o primeiro parágrafo de cada seção
\RequirePackage{graphicx}           % inclusão de figuras
\graphicspath{{imagens/}}           % as imagens do trabalho ficam na pasta imagens/
\RequirePackage{csquotes}           % aspas (\enquote) e citações no padrão do idioma
\RequirePackage[final]{microtype}   % melhorias de justificação
\RequirePackage{booktabs}           % \toprule, \midrule e \bottomrule
\RequirePackage{tabularx}           % colunas X de largura automática
\RequirePackage{multirow}           % células mescladas em linhas

% ---
% Referências: biblatex com o estilo abnt (ajustes UFV em abntex2-ufv.sty).
% Declare a base com \addbibresource{referencias.bib} no preâmbulo.
% ---
\ifufv@biblatex
  \RequirePackage[backend=biber,
                  style=abnt,
                  uniquename=init,
                  giveninits,
                  repeatfields,
                  justify,
                  noslsn]{biblatex}
  \RequirePackage{xurl}             % quebra de linha em URLs longas
  \urlstyle{same}
  \setlength{\bibparsep}{10pt}
\fi
\setlength{\emergencystretch}{3em}  % evita linhas estouradas com comandos longos
\endinput
