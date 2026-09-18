%% bts-report.cls
%% Custom LaTeX class for BTS (Brevet de Technicien Superieur) academic reports
%% Based on the standard BTS report structure from INSFP Rahmania
%%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{bts-report}[2025/01/01 BTS Report Class]

\LoadClass[a4paper,12pt,openany]{book}

%% ============================================================
%% PACKAGES
%% ============================================================
\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}
\RequirePackage[english]{babel}
\RequirePackage{geometry}
\RequirePackage{graphicx}
\RequirePackage{fancyhdr}
\RequirePackage{titlesec}
\RequirePackage{titletoc}
\RequirePackage{tocloft}
\RequirePackage{enumitem}
\RequirePackage{booktabs}
\RequirePackage{longtable}
\RequirePackage{array}
\RequirePackage{multirow}
\RequirePackage{tabularx}
\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{newtxtext}
\RequirePackage{newtxmath}
\RequirePackage{fontspec}
\newfontfamily\arabicfont[Script=Arabic]{Amiri}
\newcommand{\arabtext}[1]{{\arabicfont #1}}
\RequirePackage[table]{xcolor}
\RequirePackage{hyperref}
\RequirePackage{caption}
\RequirePackage{float}
\RequirePackage{environ}
\RequirePackage{setspace}
\RequirePackage{parskip}
\RequirePackage{pdflscape}
\RequirePackage{tikz}
\usetikzlibrary{positioning,calc,fit,arrows.meta,shapes.geometric,shapes.multipart,backgrounds,decorations.pathreplacing}
\RequirePackage{ragged2e}
\RequirePackage{pgfgantt}
\RequirePackage{bidi}
% --- Breakable \texttt for long identifiers in tables and prose ------------
% Gives \texttt{assignment_status_history} etc. break opportunities inside
% p/X columns and running text instead of producing overfull \hbox warnings.
% (seqsplit must receive plain text; setting \ttfamily outside the call.)
\RequirePackage{seqsplit}
\renewcommand{\texttt}[1]{{\ttfamily\seqsplit{#1}}}
% --- Allow line breaks after escaped underscores in plain-text identifiers --
% Covers $assignment\_status\_history$ written as plain text in table cells.
\let\origunderscore\_
\renewcommand{\_}{\allowbreak\origunderscore}
% --- URLs may break anywhere (bibliography entries).
\RequirePackage{xurl}
% Extra glue when a justified line would otherwise overflow; prevents
% small overfull \hbox warnings in running text without changing layout
% noticeably.
\setlength{\emergencystretch}{1.5em}

%% ============================================================
%% PAGE GEOMETRY
%% ============================================================
\geometry{
  top=2.5cm,
  bottom=2.5cm,
  left=2.5cm,
  right=2.5cm,
  headheight=13pt
}

%% ============================================================
%% SPACING
%% ============================================================
\onehalfspacing
\setlength{\parindent}{1em}
\setlength{\parskip}{6pt}

%% ============================================================
%% COLOR DEFINITIONS
%% ============================================================
\definecolor{chaptercolor}{RGB}{0,0,0}      % big chapter titles
\definecolor{sectioncolor}{RGB}{32,32,32}      % section / subsection titles
\definecolor{linkcolor}{RGB}{9,74,138}        % hyperlinks in TOC & text
\definecolor{headercolor}{RGB}{100,100,100}    % page header text (top of page)
\definecolor{tableheader}{RGB}{0,0,0}       % table header row fill
\definecolor{tablealt}{RGB}{192,192,192}       % alternating table row fill

%% ============================================================
%% HYPERREF SETUP
%% ============================================================
\hypersetup{
  colorlinks=true,
  linkcolor=linkcolor,
  citecolor=linkcolor,
  urlcolor=linkcolor,
  pdftitle={BTS Report},
  pdfauthor={},
}

%% ============================================================
%% CHAPTER / SECTION FORMATTING
%% ============================================================
%% Numbered chapter heading: "CHAPTER I" centered, title centered below (big + bold)
%% Every chapter gets its own full page, vertically + horizontally centered;
%% content starts on the next page.
\renewcommand{\@makechapterhead}[1]{%
  \null\vfill
  {\centering
   {\Large\bfseries\color{chaptercolor} CHAPTER \Roman{chapter}\par}%
   \vspace{0.5cm}%
   {\Huge\bfseries\color{chaptercolor} #1\par}%
  }%
  \vfill\null
  \clearpage
}
%% Unnumbered chapter heading (front matter, conclusion, ...): centered
\renewcommand{\@makeschapterhead}[1]{%
  \vspace*{20\p@}%
  {\centering\normalfont\huge\bfseries\color{chaptercolor} #1\par}%
  \vskip 16\p@
}

\titleformat{\section}
  {\normalfont\Large\bfseries\color{sectioncolor}}
  {\thesection}
  {15pt}
  {}

\titlespacing{\section}{2em}{*4}{*2.3}
\titlespacing{name=\section, numberless}{0.75em}{*4}{*2.3}

\titleformat{\subsection}
  {\normalfont\large\bfseries\color{sectioncolor}}
  {\thesubsection}
  {12pt}
  {}

\titleformat{\subsubsection}
  {\normalfont\normalsize\bfseries}
  {\thesubsubsection}
  {10pt}
  {}

%% ============================================================
%% HEADER / FOOTER
%% ============================================================
\pagestyle{fancy}
\fancyhf{}

\newcommand{\bts@chaptitle}{}

%% Store chapter number and title
\renewcommand{\chaptermark}[1]{%
  \markboth{CHAPTER \Roman{chapter}}{#1}%
  \gdef\bts@chaptitle{#1}%
}

%% Same header on every page: "CHAPTER I" left, chapter title right
\fancyhead[L]{\small\color{headercolor}\leftmark}
\fancyhead[R]{\small\color{headercolor}\bts@chaptitle}

\fancyfoot[C]{\thepage}

\renewcommand{\headrulewidth}{0.4pt}
\renewcommand{\footrulewidth}{0pt}

%% Chapter opening pages should also have the header
\fancypagestyle{plain}{
  \fancyhf{}
  \fancyhead[L]{\small\color{headercolor}\leftmark}
  \fancyhead[R]{\small\color{headercolor}\bts@chaptitle}
  \fancyfoot[C]{\thepage}
  \renewcommand{\headrulewidth}{0.4pt}
}

%% ============================================================
%% COVER PAGE COMMANDS
%% ============================================================
\newcommand{\bts@republic}{ALGERIAN DEMOCRATIC AND POPULAR REPUBLIC}
\newcommand{\bts@ministry}{Ministry of Vocational Education and Training}
\newcommand{\bts@institute}{National Specialized Institute of Vocational Training}
\newcommand{\bts@location}{Rahmania - Sidi Abdellah}
\newcommand{\bts@diploma}{For the Obtaining of the Higher Technician Diploma}
\newcommand{\bts@field}{Web and Mobile Developer}

\newcommand{\bts@theme}{}
\newcommand{\theme}[1]{\renewcommand{\bts@theme}{#1}}

\newcommand{\bts@hostorg}{}
\newcommand{\hostorg}[1]{\renewcommand{\bts@hostorg}{#1}}

\newcommand{\bts@supervisor}{}
\newcommand{\supervisor}[1]{\renewcommand{\bts@supervisor}{#1}}

\newcommand{\bts@promoter}{}
\newcommand{\promoter}[1]{\renewcommand{\bts@promoter}{#1}}

\newcommand{\bts@students}{}
\newcommand{\students}[1]{\renewcommand{\bts@students}{#1}}

\newcommand{\bts@promotion}{}
\newcommand{\promotion}[1]{\renewcommand{\bts@promotion}{#1}}

%% ============================================================
%% TITLE PAGE
%% ============================================================
\newcommand{\maketitlepage}{
  \begin{titlepage}
    \centering
    \vspace*{-1cm}

    %% ============================================================
    %% INSTITUTION HEADER WITH LOGOS
    %% ============================================================
    \noindent
    \begin{minipage}[c]{0.20\textwidth}
        \centering
        \includegraphics[width=0.85\linewidth]{figures/djezzy-logo.png}
    \end{minipage}%
    \hfill
    \begin{minipage}[c]{0.56\textwidth}
        \centering

        {\large\bfseries \bts@republic\par}
        \vspace{0.3cm}

        {\large \bts@ministry\par}
        \vspace{0.15cm}

        {\large \bts@institute\par}
        \vspace{0.15cm}

        {\large \bts@location\par}

    \end{minipage}%
    \hfill
    \begin{minipage}[c]{0.20\textwidth}
        \centering
        \includegraphics[width=0.85\linewidth]{figures/second-logo.png}
    \end{minipage}

    \vspace{1.5cm}

%% Diploma type
    {\large\textbf{Final Training Thesis}}
    \vspace{0.3cm}
    \par {\large \bts@diploma}
    \par {\large \bts@field}
    \vspace{1.5cm}

    %% Theme
    {\large\textbf{Theme:}}
    \vspace{0.5cm}
    \par {\large \bts@theme}
    \vspace{1cm}

    %% Host organization
    {\large Host Organization:}
    \vspace{0.3cm}
    \par {\large \bts@hostorg}
    \vspace{2cm}

    %% Info table
    \begin{minipage}{0.45\textwidth}
      \begin{flushleft}
        \textbf{Supervisor:} \\[0.3cm]
        \bts@supervisor
        \vspace{0.6cm}

        \textbf{Promoter:} \\[0.3cm]
        \bts@promoter
      \end{flushleft}
    \end{minipage}%
    \hfill
    \begin{minipage}{0.45\textwidth}
      \begin{flushright}
        \textbf{Presented by:} \\[0.3cm]
        \bts@students
      \end{flushright}
    \end{minipage}
    \vspace{1cm}

    %% Promotion
    {\large Promotion: \bts@promotion}

  \end{titlepage}
}

%% ============================================================
%% FRONT MATTER (Roman numerals)
%% ============================================================
\renewcommand{\frontmatter}{
  \clearpage
  \@mainmatterfalse
  \pagenumbering{roman}
  \pagestyle{plain}
  \setcounter{page}{1}
}

%% ============================================================
%% MAIN MATTER (Arabic numerals)
%% ============================================================
\renewcommand{\mainmatter}{
  \clearpage
  \@mainmattertrue
  \pagenumbering{arabic}
  \pagestyle{fancy}
  \setcounter{page}{1}
}

%% ============================================================
%% BACK MATTER
%% ============================================================
\renewcommand{\backmatter}{
  \clearpage
  \@mainmatterfalse
  \pagestyle{fancy}
}

%% ============================================================
%% USE CASE TABLE
%% ============================================================
\NewEnviron{usecasetable}[1]{%
  \begin{table}[H]
    \centering
    \caption{#1}
    \vspace{0.2cm}
    % \begin{tabularx}{\textwidth}{|>{\bfseries}p{3.5cm}|X|}
    \begin{tabularx}{\textwidth}{|
      >{\bfseries\arraybackslash}p{3.5cm}|
      >{\arraybackslash}X|}
      \hline
      \rowcolor{tableheader}
      \textcolor{white}{\textbf{Field}} & \textcolor{white}{\textbf{Description}} \\
      \hline
      \BODY
      \hline
    \end{tabularx}
  \end{table}
}

\newcommand{\ucfield}[2]{%
  #1 & \parbox[t]{\hsize}{\RaggedRight #2} \\
  \hline
}

%% ============================================================
%% CLASS DESCRIPTION TABLE (3 columns: Class | Attributes | Methods)
%% ============================================================
\NewEnviron{classtable}[1]{%
  \begin{table}[H]
    \centering
    \caption{#1}
    \vspace{0.2cm}
    \begin{tabularx}{\textwidth}{|>{\bfseries}p{2.5cm}|X|X|}
      \hline
      \rowcolor{tableheader}
      \textcolor{white}{\textbf{Class}} & \textcolor{white}{\textbf{Attributes}} & \textcolor{white}{\textbf{Methods}} \\
      \hline
      \BODY
      \hline
    \end{tabularx}
  \end{table}
}

\newcommand{\clasfield}[3]{%
  #1 & #2 & #3 \\
  \hline
}

%% ============================================================
%% DATABASE TABLE SCHEMA
%% ============================================================
\NewEnviron{dbtable}[1]{%
  \begin{table}[H]
    \centering
    \caption{#1}
    \vspace{0.2cm}
    \begin{tabularx}{\textwidth}{|>{\bfseries}p{3.5cm}|p{3cm}|p{2cm}|X|}
      \hline
      \rowcolor{tableheader}
      \textcolor{white}{\textbf{Column}} & \textcolor{white}{\textbf{Type}} & \textcolor{white}{\textbf{Nullable}} & \textcolor{white}{\textbf{Description}} \\
      \hline
      \BODY
      \hline
    \end{tabularx}
  \end{table}
}

\newcommand{\dbcol}[4]{%
  #1 & #2 & #3 & #4 \\
  \hline
}

%% ============================================================
%% TEST RESULTS TABLE
%% ============================================================
\NewEnviron{teststable}[1]{%
  \begin{table}[H]
    \centering
    \caption{#1}
    \vspace{0.2cm}
    \begin{tabularx}{\textwidth}{|>{\bfseries}p{4cm}|p{2cm}|p{2cm}|X|}
      \hline
      \rowcolor{tableheader}
      \textcolor{white}{\textbf{Test Category}} & \textcolor{white}{\textbf{Total}} & \textcolor{white}{\textbf{Passed}} & \textcolor{white}{\textbf{Status}} \\
      \hline
      \BODY
      \hline
    \end{tabularx}
  \end{table}
}

\newcommand{\testrow}[4]{%
  #1 & #2 & #3 & #4 \\
  \hline
}
\NewEnviron{abbrevtable}{%
  \begin{table}[H]
    \centering
    \begin{tabularx}{\textwidth}{|>{\bfseries}p{3cm}|X|}
      \hline
      \rowcolor{tableheader}
      \textcolor{white}{\textbf{Abbreviation}} & \textcolor{white}{\textbf{Signification}} \\
      \hline
      \BODY
      \hline
    \end{tabularx}
  \end{table}
}

%% ============================================================
%% FIGURE WITH CAPTION (wrapper for consistency)
%% ============================================================
\newcommand{\reportfigure}[3][0.8]{%
  \begin{figure}[H]
    \centering
    \ifx\relax#2\relax
      %% No image file provided - draw placeholder
      \begin{tikzpicture}
        \draw[gray, dashed, thick] (0,0) rectangle (10,6);
        \node[gray, align=center] at (5,3) {\large\textbf{[Figure Placeholder]}\\[0.2cm]\small #3};
      \end{tikzpicture}
    \else
      \includegraphics[width=#1\textwidth]{#2}
    \fi
    \caption{#3}
    \label{fig:\thefigure}
  \end{figure}
}

%% ============================================================
%% FIGURE PLACEHOLDER (for images not yet available)
%% ============================================================
\newcommand{\figureplaceholder}[2][0.7]{%
  \begin{figure}[H]
    \centering
    \begin{tikzpicture}
      \draw[gray, dashed, thick] (0,0) rectangle (10,6);
      \node[gray, align=center] at (5,3) {\large\textbf{[Figure: #2]}\\[0.2cm]\small Replace with actual image};
    \end{tikzpicture}
    \caption{#2}
    \label{fig:\thefigure}
  \end{figure}
}

%% ============================================================
%% LIST OF ABBREVIATIONS
%% ============================================================
\newcommand{\abbreviations}[1]{%
  \chapter*{List of Abbreviations}
  \addcontentsline{toc}{chapter}{List of Abbreviations}
  #1
}

%% ============================================================
%% ABSTRACT ENVIRONMENTS
%% ============================================================
\newenvironment{abstractfr}{%
  \chapter*{Resume}
  \addcontentsline{toc}{chapter}{Resume}
}{%
}

\newenvironment{abstracten}{%
  \chapter*{Abstract}
  \addcontentsline{toc}{chapter}{Abstract}
}{%
}

\newenvironment{abstractar}{%
  \chapter*{\arabtext{المُلخَص}}
  \addcontentsline{toc}{chapter}{\arabtext{المُلخَص}}
  \begin{RTL}\arabicfont
}{%
  \end{RTL}
}

%% ============================================================
%% REMERCIEMENTS / DEDICATION
%% ============================================================
\newenvironment{remerciements}{%
  \chapter*{Remerciements}
  \addcontentsline{toc}{chapter}{Remerciements}
}{%
}

\newenvironment{dedicace}{%
  \chapter*{Dedicace}
  \addcontentsline{toc}{chapter}{Dedicace}
}{%
}

%% ============================================================
%% BIBLIOGRAPHY SETUP
%% ============================================================
\newcommand{\bibliographysection}{
  \chapter*{References Bibliographiques}
  \addcontentsline{toc}{chapter}{References Bibliographiques}
}

%% ============================================================
%% ANNEXES
%% ============================================================
\newcommand{\annexessection}{
  \appendix
  \chapter*{Annexes}
  \addcontentsline{toc}{chapter}{Annexes}
}

%% ============================================================
%% TABLE OF CONTENTS CUSTOMIZATION
%% ============================================================
\renewcommand{\contentsname}{Contents}
\renewcommand{\listfigurename}{List of Figures}
\renewcommand{\listtablename}{List of Tables}
%% babel re-applies caption names at \begin{document}; defer overrides
\AtBeginDocument{%
  \renewcommand{\figurename}{Fig.}%
  \renewcommand{\tablename}{Tab.}%
}

%% ============================================================
%% COMPACT LIST STYLE
%% ============================================================
\setlist[itemize]{noitemsep, topsep=0pt, leftmargin=1.5em}
\setlist[enumerate]{noitemsep, topsep=0pt, leftmargin=1.5em}

\endinput
