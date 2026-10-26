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
%% padrões do manual (12pt, A4, frente apenas, português do Brasil) e carrega só o
%% que a própria classe precisa. Os pacotes de uso do autor (graphicx, csquotes,
%% biblatex, tabelas etc.) são carregados no preâmbulo do documento (veja o template).
%% Toda a personalização (margens, fonte, capa, listas, siglas etc.) está em
%% abntex2-ufv.sty.
%%
\NeedsTeXFormat{LaTeX2e}[2022/06/01]
\ProvidesClass{abntex2-ufv}[2026/10/26 v1.7 Classe abntex2-ufv (TCC SI UFV-CRP)]

\newcommand{\ufvversion}{1.7}

% A classe abntex2 carrega o babel com o nome obsoleto "brazil"; o aviso é inofensivo
\RequirePackage{silence}
\WarningFilter{babel}{Name 'brazil' is deprecated}
% O abntex2 usa \settocpreprocessor (sumário em caixa alta), que o memoir de 2026 marca como
% obsoleto: o recurso continua funcionando (o aviso é só de depreciação) e a classe abntex2
% ainda não foi atualizada, então o aviso não depende de nada que o autor possa corrigir
\WarningFilter{memoir}{\settocpreprocessor is marked deprecated}
\RequirePackage{etoolbox}

% ---
% Opções (chaves do kernel, \DeclareKeys)
%   fonte=times|arial|cm   fonte do texto (padrão: times); veja abntex2-ufv.sty
%   capacampus             imprime campus e curso na capa
%   oneside|twoside        frente apenas (padrão) ou frente e verso
%   openright|openany      capítulos em página ímpar (padrão) ou em qualquer página
%   10pt|11pt|12pt         tamanho da letra (padrão e exigido pelo manual: 12pt)
% As demais opções são repassadas à classe abntex2 (e, por ela, ao memoir).
% O papel é sempre A4; o idioma principal é o português do Brasil, com inglês
% como idioma adicional para hifenização.
% A opção nobiblatex (versões 1.5 e 1.6) é obsoleta e ignorada: a classe não carrega
% mais o biblatex; carregue-o no preâmbulo do documento.
% ---
\newcommand{\ufv@fonte}{times}
\newif\ifufv@capacampus
\newcommand{\ufv@side}{oneside}
\newcommand{\ufv@open}{openright}
\newcommand{\ufv@pt}{12pt}

\DeclareKeys[ufv]{
  fonte.store        = \ufv@fonte,
  capacampus.if      = ufv@capacampus,
  oneside.code       = \renewcommand{\ufv@side}{oneside},
  twoside.code       = \renewcommand{\ufv@side}{twoside},
  openright.code     = \renewcommand{\ufv@open}{openright},
  openany.code       = \renewcommand{\ufv@open}{openany},
  10pt.code          = \renewcommand{\ufv@pt}{10pt},
  11pt.code          = \renewcommand{\ufv@pt}{11pt},
  12pt.code          = \renewcommand{\ufv@pt}{12pt},
  a4paper.code       = {},
  nobiblatex.code    = {\ClassWarningNoLine{abntex2-ufv}{%
    A opcao nobiblatex e obsoleta e foi ignorada: a classe nao carrega mais o biblatex.\MessageBreak
    Carregue-o no preambulo do documento (veja o template)}},
}
\DeclareUnknownKeyHandler[ufv]{\PassOptionsToClass{\CurrentOption}{abntex2}}
\ProcessKeyOptions[ufv]

% Idiomas: o português do Brasil (principal) e o inglês precisam estar entre as opções
% *globais* do documento, as mesmas que o usuário escreveria em \documentclass[...]. Assim
% o babel e também o hyperref (nomes do \autoref: Figura, Tabela, Apêndice) as recebem;
% repassá-las só ao babel deixaria o \autoref em inglês.
\ifx\@classoptionslist\relax
  \xdef\@classoptionslist{english,brazilian}%
\else
  \xdef\@classoptionslist{\@classoptionslist,english,brazilian}%
\fi
\PassOptionsToClass{\ufv@pt,a4paper,\ufv@side,\ufv@open}{abntex2}
\LoadClass{abntex2}

% ---
% Personalização UFV e o que a própria classe precisa (o resto fica no documento)
% ---
\def\ufv@viacls{}                   % avisa o .sty que ele foi carregado pela classe
\RequirePackage{abntex2-ufv}
\RequirePackage[T1]{fontenc}        % códigos de fonte de saída (acentos e hifenização)
\RequirePackage{indentfirst}        % indenta o primeiro parágrafo de cada seção
\setlength{\emergencystretch}{3em}  % evita linhas estouradas com comandos longos
\endinput
