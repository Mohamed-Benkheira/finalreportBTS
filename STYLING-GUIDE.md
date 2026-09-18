# BTS Report Styling & Editing Guide

This guide explains **everything** you can change in the BTS report system: colors, spacing,
sizes, page layout, sections, tables, and figures. Read it yourself, or paste it to an AI
together with your request (e.g. "make the theme green and add a use case table for login").

> **Two files control everything:**
>
> - `report-template/bts-report.cls` — the _design_ (colors, spacing, sizes, custom tables,
>   figure commands). Changes here affect every report.
> - `report-template/rapport-template.tex` — the _content_ (metadata, chapters, sections,
>   actual tables/figures/text). This is what you/my agent edits most often.

---

## 1. Files at a glance

| File                                   | Purpose                           | Edit when...                                       |
| -------------------------------------- | --------------------------------- | -------------------------------------------------- |
| `report-template/bts-report.cls`       | The design template (all styling) | changing colors / spacing / sizes / table commands |
| `report-template/rapport-template.tex` | The report content itself         | writing chapters, adding sections, tables, figures |
| `report-template/bts-report.cls` (top) | Class loads document class        | changing font size, paper size                     |
| `report-template/figures/`             | Put your real images here         | adding screenshots / diagrams / logos              |
| `figures/README.md`                    | Image naming rules                | nothing (reference)                                |

---

## 2. How to compile (after every edit)

```bash
cd report-template
pdflatex -interaction=nonstopmode rapport-template.tex
pdflatex -interaction=nonstopmode rapport-template.tex
pdflatex -interaction=nonstopmode rapport-template.tex   # 3rd pass fixes TOC/page numbers
```

You need **3 passes** so the table of contents, list of figures, list of tables, and
cross-references resolve. The result is `report-template/rapport-template.pdf`.

If errors appear, read the last `!` lines in `rapport-template.log`. Most common fix:
a missing `\end{...}` or a stray `%`.

---

## 3. Colors

**Where:** `bts-report.cls`, section `COLOR DEFINITIONS` (around line 62).

```latex
\definecolor{chaptercolor}{RGB}{0,0,0}      % big chapter titles
\definecolor{sectioncolor}{RGB}{32,32,32}      % section / subsection titles
\definecolor{linkcolor}{RGB}{9,74,138}        % hyperlinks in TOC & text
\definecolor{headercolor}{RGB}{100,100,100}    % page header text (top of page)
\definecolor{tableheader}{RGB}{0,0,0}       % table header row fill (only row that is colored)
```

### Change an existing color

```latex
\definecolor{chaptercolor}{RGB}{0,102,51}      % deep green
```

### Add a brand-new color (then use it anywhere)

```latex
\definecolor{accent}{RGB}{255,87,51}           % new orange accent
% use later: \textcolor{accent}{Some text}  or  \rowcolor{accent}
```

### RGB values

`RGB` takes 3 numbers `0-255`. Quick references:

- Red `255,0,0` · Green `0,255,0` · Blue `0,0,255` · White `255,255,255`
- Black `0,0,0` · Dark blue `0,51,102` · Medium blue `0,76,153` · Light gray `200,200,200`
- Google `255,240`… use a color picker tool to get exact RGB values.

---

## 4. Spacing

**Where:** `bts-report.cls`, section `SPACING` (around line 55).

```latex
\singlespacing                 % line height throughout the document (current default)
\setlength{\parindent}{1em}    % first-line indent of paragraphs (small)
\setlength{\parskip}{6pt}      % blank space between paragraphs
```

### Change line spacing

| Command           | Effect                     |
| ----------------- | -------------------------- |
| `\singlespacing`  | 1.0 line spacing (default) |
| `\onehalfspacing` | 1.5 line spacing           |
| `\doublespacing`  | 2.0 line spacing           |

Only one can be active. Swap the line.

### Space between paragraphs

```latex
\setlength{\parskip}{10pt}     % bigger gap between paragraphs
\setlength{\parindent}{1em}    % re-enable indented first line
```

### Extra blank space inside the report

Use `\vspace{0.5cm}` between items, or `\\[0.3cm]` inside a line.

### List spacing

At the bottom of `bts-report.cls`:

```latex
\setlist[itemize]{noitemsep, topsep=0pt, leftmargin=1.5em}
\setlist[enumerate]{noitemsep, topsep=0pt, leftmargin=1.5em}
```

- `noitemsep` — remove space between items
- `topsep=0pt` — remove space above/below the list
- `leftmargin=1.5em` — indentation of bullet/number

---

## 5. Fonts & text sizes

### Global document font size

At the **top of `bts-report.cls`** (line ~8):

```latex
\LoadClass[a4paper,10.5pt,openany]{book}
```

Change `10.5pt` to `11pt` or `12pt`.

### Chapter / section / subsection title sizes

`bts-report.cls`, around line 84. **Every numbered chapter gets its own full page**:
centered `CHAPTER I` (`\Large\bfseries`) with the title centered below (`\Huge\bfseries`),
both vertically and horizontally centered, then `\clearpage` so the chapter's content starts on the next page:

```latex
\renewcommand{\@makechapterhead}[1]{%
  \null\vfill
  {\centering
   {\Large\bfseries\color{chaptercolor} CHAPTER \Roman{chapter}\par}%
   \vspace{0.5cm}%
   {\Huge\bfseries\color{chaptercolor} #1\par}%
  }%
  \vfill\null
  \clearpage              % <- title alone on the page; content starts on the next page
}
```

- To let content start on the same page as the title, remove the `\clearpage` line.
- To stop vertical centering (place title at the top instead), replace `\null\vfill` … `\vfill\null` with `\vspace*{24\p@}`.

Unnumbered (`\chapter*`) headings — Remerciements, Dedicace, Resume, Abstract, Contents,
List of Figures, List of Tables, General Conclusion, References, Annexes — are **centered**
and stay on the same page as their content:

```latex
\renewcommand{\@makeschapterhead}[1]{%
  \vspace*{20\p@}%
  {\centering\normalfont\huge\bfseries\color{chaptercolor} #1\par}%
  \vskip 16\p@
}
```

Symbols from smallest to largest: `\scriptsize` `\footnotesize` `\small` `\normalsize`
`\large` `\Large` `\LARGE` `\huge` `\Huge`.

To make the numbered chapter heading bigger and bolder, edit inside
`\@makechapterhead`: replace `\small` with e.g. `\normalsize` and add `\bfseries`:

```latex
{\normalsize\bfseries\color{chaptercolor}%
 \noindent Chapter~\thechapter\hfill
 ...
```

### Section style

```latex
\titleformat{\section}
  {\normalfont\Large\bfseries\color{sectioncolor}}   % <- section titles
  {\thesection}{15pt}{}
```

Section **left indents** (currently: numbered sections 2em, unnumbered `\section*`
like Introduction/Conclusion 0.75em):

```latex
\titlespacing{\section}{2em}{*4}{*2.3}
\titlespacing{name=\section, numberless}{0.75em}{*4}{*2.3}
```

`\titlespacing` (unstarred) = the paragraph right after a heading keeps its first-line
indent; `\titlespacing*` would remove that indent.

### Text size inside a paragraph

```latex
{\small smaller text normal text} {\large bigger text}
```

LaTeX sizes are **relative**: once you change the document base (e.g. `11pt`), all sizes scale.

### Font family (typeface)

To switch fonts, add near the class options and reload (compiles slower the first time):

```latex
\usepackage{XCharter}         % clean serif
\usepackage{helvet}
\renewcommand{\familydefault}{\sfdefault}   % make everything sans-serif
```

Common: `XCharter`, `libertine`, `helvet`, `palatino` (via `mathpazo`). Requires
`tlmgr install <package>` if the font is missing.

---

## 6. Page size & margins

`bts-report.cls`, section `PAGE GEOMETRY` (line ~44):

```latex
\geometry{
  top=2cm,
  bottom=2cm,
  left=2cm,
  right=2cm,
  headheight=13pt
}
```

- `top` / `bottom` — white space above/below text
- `left` / `right` — side margins (larger left = space for binding)
- `headheight` — room for the running header

---

## 7. Page header & footer

`bts-report.cls`, section `HEADER / FOOTER` (line ~123):

```latex
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

\fancyfoot[C]{\thepage}                              % page number centered bottom
\renewcommand{\headrulewidth}{0.4pt}                 % header divider line width
\renewcommand{\footrulewidth}{0pt}                   % footer divider line (0 = none)

%% Chapter opening pages should also have the header
\fancypagestyle{plain}{
  \fancyhf{}
  \fancyhead[L]{\small\color{headercolor}\leftmark}
  \fancyhead[R]{\small\color{headercolor}\bts@chaptitle}
  \fancyfoot[C]{\thepage}
  \renewcommand{\headrulewidth}{0.4pt}
}
```

- The header shows `CHAPTER I` (left) and the chapter title (right) on **every** page of that chapter; `\bts@chaptitle` is re-captured automatically at each `\chapter{...}`.
- To remove headers: delete the `\fancyhead[L]`/`\fancyhead[R]` lines above.
- To enlarge header text: replace `\small` with `\normalsize`.
- To add your report title in the footer:
    ```latex
    \fancyfoot[L]{\tiny\color{headercolor}BTS Report}
    ```
- Note: do NOT rely on `\rightmark`/`\sectionmark` here — use `\bts@chaptitle` directly (marks stay empty when `titlesec` is loaded).

---

## 8. Title (cover) page layout & texts

**Cover texts:** `bts-report.cls`, section `COVER PAGE COMMANDS` (line ~128):

```latex
\newcommand{\bts@republic}{REPUBLIQUE ALGERIENNE DEMOCRATIQUE ET POPULAIRE}
\newcommand{\bts@ministry}{Ministere de la Formation et de l'enseignement Professionnels}
\newcommand{\bts@institute}{Institut National Specialise de formation professionnelle}
\newcommand{\bts@location}{Rahmania - Sidi Abdellah}
\newcommand{\bts@diploma}{Pour L'obtention Du Diplome De Technicien Superieur}
\newcommand{\bts@field}{Developpeur Web et Mobile}
```

Change the wording / add accent marks here.

**Cover layout:** `\maketitlepage` (line ~156). The `\vspace{...}` lines control gaps between
blocks; the two `\begin{minipage}{0.45\textwidth}` blocks are the two-column
"Encadrant / Presente par" part. To add a field, copy a `\par {\large ...}` line.

**Report metadata (fill per report):** these go in `rapport-template.tex`, NOT the class:

```latex
\theme{...} \hostorg{...} \supervisor{...} \students{...} \promoter{...} \promotion{2024/2025}
```

---

## 9. Front matter (before the 4 chapters)

Order in `rapport-template.tex` inside `\frontmatter` — these use roman numerals:

```latex
\frontmatter
  \begin{remerciements} ... \end{remerciements}   % thank-you page
  \begin{dedicace} ... \end{dedicace}             % one per student
  \begin{abstractfr} ... \end{abstractfr}         % French abstract + mots-cles
  \begin{abstracten} ... \end{abstracten}         % English abstract + keywords
  \tableofcontents                                % TOC
  \listoffigures                                  % list of figures
  \listoftables                                   % list of tables
\mainmatter
```

- To add an **Arabic abstract** after the English one, add in `rapport-template.tex`:
    ```latex
    \chapter*{الملخص}
    \addcontentsline{toc}{chapter}{ملخص}
    Arabic text here...
    ```
    (needs a right-to-left package if the Arabic font engine is installed — ask setup first)
- The list-of headings are set in the class:
    ```latex
    \renewcommand{\contentsname}{Table of Matieres}
    \renewcommand{\listfigurename}{Liste des figures}
    \renewcommand{\listtablename}{Liste des tableaux}
    ```

---

## 10. Chapters & sections (editing the report)

Structure of one chapter in `rapport-template.tex`:

```latex
\chapter{Generalities on the Web and Web Technologies}   % auto-numbered
\section*{Introduction}      % * = no number, does not appear in TOC
...text...
\section{Definition of the Web}    % numbered, appears in TOC
\subsection{...}
\subsubsection{...}
\section*{Conclusion}
```

- **Add a new numbered chapter:** write `\chapter{Your Title}` and LaTeX numbers it automatically.
- **Add a section:** `\section{Your Title}`.
- **Unnumbered** versions: add `*` → `\section*{...}` (these do NOT go in the TOC).
- To also show an unnumbered section in the TOC:
    ```latex
    \section*{Title}
    \addcontentsline{toc}{section}{Title}
    ```
- Keep the mandatory 4-chapter skeleton: **I Generalities, II Preliminary Study,
  III Analysis & Design, IV Implementation & Validation**, then General Conclusion,
  Reference list (`\bibliographysection`), Annexes (`\annexessection`).

---

## 11. Tables

### A) Use case description table (Chapter III)

```latex
\begin{usecasetable}{Use Case: Authentication}
\ucfield{Title}{Authentication}
\ucfield{Actors}{Administrator, Participant}
\ucfield{Description}{The user enters login credentials to access the system.}
\ucfield{Pre-conditions}{The user must have valid credentials.}
\ucfield{Post-conditions}{The user is redirected to the dashboard.}
\ucfield{Main Flow}{
  1. User accesses login page.\\
  2. System displays login form.\\
  3. User enters credentials.\\
  4. System verifies credentials.\\
  5. User is redirected.\\
}
\ucfield{Alternative Flow}{Invalid credentials: error message displayed.}
\end{usecasetable}
```

Add more rows with extra `\ucfield{Field}{Value}` lines, or make your own fields.

### B) Class description table

Use `\classtable` for a clean description table (header row colored,
body rows plain white, normal-size font). Pattern:

```latex
\begin{classtable}{Description of application classes}
  Class       & Attributes                    & Methods            \\
  User        & id, name, email               & login(), logout()  \\
  Training    & id, title, duration           & create(), update() \\
\end{classtable}
```

### C) Database table schema

```latex
\begin{dbtable}{Table: users}
\dbcol{id}{INTEGER}{No}{Primary key}
\dbcol{email}{VARCHAR(255)}{No}{Unique email}
\dbcol{role\_id}{INTEGER}{No}{Foreign key to roles}
\end{dbtable}
```

### D) Abbreviation table (front matter)

```latex
\abbreviations{%
  \begin{abbrevtable}
    HHTP & HyperText Transfer Protocol \\ \hline
    UML  & Unified Modeling Language  \\ \hline
  \end{abbrevtable}
}
```

### E) Plain table (test results, comparisons, etc.)

```latex
\begin{table}[H]
  \centering
  \caption{Test results summary}
  \begin{tabularx}{\textwidth}{|>{\bfseries}p{4cm}|p{2cm}|p{2cm}|X|}
    \hline
    \rowcolor{tableheader}
    \textcolor{white}{\textbf{Category}} & \textcolor{white}{\textbf{Total}} & \textcolor{white}{\textbf{Passed}} & \textcolor{white}{\textbf{Status}} \\
    \hline
    Unit Tests & 15 & 15 & Passed \\
    \hline
  \end{tabularx}
\end{table}
```

All predefined tables (`usecasetable`, `classtable`, `dbtable`, `abbrevtable`) are
**simple and clean**: only the header row is filled (`tableheader`), body rows stay
white, and the font is normal size. The old gray alternating rows are removed.

### Column rules (to change table look)

Each column starts with `>{\format}` then a type:

- `p{4cm}` — fixed width, wraps text
- `X` — flexible width, fills remaining space
- `l`, `c`, `r` — left / center / right without wrapping
- `>{\bfseries}` — bold font for that column (default table font is normal size).

Example — right-align the numbers column:

```latex
\begin{tabularx}{\textwidth}{|p{4cm}|>{\bfseries}c|>{\bfseries}c|X|}
```

Change column count by adding/removing `|...|` parts and matching the header row.

### How to add a NEW custom table type (advanced)

Copy an existing block in `bts-report.cls` (e.g. the `dbtable` around line 298) and rename:

```latex
\NewEnviron{datatable}[1]{%
  \begin{table}[H]
    \centering
    \caption{#1}
    \begin{tabularx}{\textwidth}{|>{\bfseries}p{3.5cm}|X|}
      \hline
      \rowcolor{tableheader}
      \textcolor{white}{\textbf{Item}} & \textcolor{white}{\textbf{Info}} \\
      \hline
      \BODY
      \hline
    \end{tabularx}
  \end{table}
}
\newcommand{\datafield}[2]{#1 & #2 \\ \hline}
```

Then in the report: `\begin{datatable}{Title} \datafield{A}{B} \end{datatable}`.

---

## 12. Figures

Two commands, both defined in `bts-report.cls`:

### A) Real image (file must exist in `report-template/figures/`)

```latex
\reportfigure[0.8]{figures/ui-dashboard.png}{Admin dashboard interface}
```

- `[0.8]` optional width = 80% of the text width (default 0.8). Use `[0.5]` to 0.5.
- Second argument: relative path to the image, e.g. `figures/ui-dashboard.png`.
- Third argument: caption (shows under the image + appears in the List of Figures).

**Supported formats (pdflatex):** `.png`, `.jpg`, `.pdf`. Put new images in
`report-template/figures/`.

### B) Placeholder (no image yet) — recommended so the report still compiles

```latex
\figureplaceholder[0.7]{Organizational chart}
```

- `[0.7]` optional width; caption is the argument. Draws a dashed gray box labeled
  `[Figure: ...]` and adds the caption + List of Figures entry.

### C) Change the placeholder box size / look

In `bts-report.cls` (`\figureplaceholder`, line ~360):

```latex
\draw[gray, dashed, thick] (0,0) rectangle (10,6);   % box width,height
\node[gray, align=center] at (5,3) {...};            % centered label
```

To make the box wider/taller: `(12,7)`. Change `gray` to `tableheader` for a blue box.

---

## 13. General Conclusion / Bibliography / Annexes

At the end of `rapport-template.tex`:

```latex
\chapter*{General Conclusion and Perspectives}
\addcontentsline{toc}{chapter}{General Conclusion and Perspectives}
...text...

\bibliographysection       % "References Bibliographiques" heading + TOC entry
\begin{enumerate}
  \item Author. (Year). Title. Publisher.
  ...
\end{enumerate}

\annexessection            % "Annexes" heading + TOC entry
Additional materials...
```

---

## 14. Checklist: from idea to PDF

1. Edit `rapport-template.tex` (content) and/or `bts-report.cls` (style).
2. Put any real images into `report-template/figures/`.
3. Run pdflatex **3 times** (section 2).
4. Skim `rapport-template.pdf` (TOC pages, tables, figures).
5. Fix any red `!` errors from `rapport-template.log`.

## 15. Cheat sheet (quick answers)

| I want to…                    | Edit                                                                                      |
| ----------------------------- | ----------------------------------------------------------------------------------------- |
| Change theme color            | `\definecolor{chaptercolor}{...}` + `sectioncolor` + `linkcolor` + `tableheader` (cls §3) |
| More space between paragraphs | `\setlength{\parskip}{10pt}` (cls §4)                                                     |
| Double spacing                | `\doublespacing` replacing `\singlespacing` (cls §4)                                     |
| Bigger chapter titles         | bigger `\small` → `\normalsize` in `\@makechapterhead` (cls §5)                          |
| Smaller base font             | `10.5pt` → `11pt` or `12pt` in `\LoadClass` (cls §5)                                       |
| Section heading left indent   | `\titlespacing{\section}{2em}{...}` — edit the `2em`/`0.75em` (cls §5)                     |
| Wider left margin             | `left=4cm` in `\geometry` (cls §6)                                                        |
| Remove the header line        | `\renewcommand{\headrulewidth}{0pt}` (cls §7)                                             |
| Add an extra use case         | one `\begin{usecasetable}...\end{usecasetable}` block (§11A)                              |
| Add a DB table                | one `\begin{dbtable}...\end{dbtable}` block (§11C)                                        |
| Show a real screenshot        | `\reportfigure[0.8]{figures/name.png}{Caption}` (§12A)                                    |

**Golden rule:** _content_ in `rapport-template.tex`, _design_ in `bts-report.cls`.
If you only add/remove sections, tables, figures, or text → touch the `.tex`.
If you change color, spacing, font, margins, or the header/footer → touch the `.cls`.

