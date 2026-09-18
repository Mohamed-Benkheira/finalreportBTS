---
name: bts-report
description: Generate complete BTS academic reports in LaTeX format using the bts-report.cls template. Use this skill whenever the user or another agent needs a structured BTS thesis report (memoire de fin de formation) generated from project information.
license: MIT
metadata:
  audience: students, agents generating academic reports
  workflow: report-generation
---

# BTS Report Generation Skill

Generate professional BTS (Brevet de Technicien Superieur) academic reports in
LaTeX following the standard INSFP Rahmania report structure.

## Prerequisites

- **LaTeX class**: `report-template/bts-report.cls` (already created)
- **Figure images**: Place in `report-template/figures/`
- **PDF compilation**: Requires `pdflatex` installed

## Workflow

### Step 1: Gather Project Information

Read the project information from one of these sources (in order of priority):

1. A JSON file (e.g., `report-input.json`, `project-info.json`, or `report-template/project-info.json`)
2. A natural language message describing the project:
   - Project name and subject
   - Host organization (entreprise d'accueil)
   - Team members (binome)
   - Supervisor and promoter names
   - Problem statement
   - Objectives
   - Technologies used
   - Actors / roles
   - Use cases
   - Database entities/tables
   - Testing approach
   - Future perspectives

### Step 2: Generate the Report

Create `report-template/rapport.tex` using the `bts-report` document class.

**Required structure:**

```
\documentclass{bts-report}
\theme{...} \hostorg{...} \supervisor{...} \students{...}
\promoter{...} \promotion{...}
\begin{document}
\maketitlepage
\frontmatter
  % Remerciements, Dedications, Abstracts (FR+EN), TOC, LOF, LOT
\mainmatter
  % Chapter I: Generalities on the Web
  % Chapter II: Preliminary Study
  % Chapter III: Analysis and Design
  % Chapter IV: Implementation and Validation
\backmatter
  % General Conclusion, Bibliography, Annexes
\end{document}
```

### Step 3: Use the Correct Commands

**Figures:**
```latex
% Placeholder (no image available yet):
\figureplaceholder[0.8]{Caption text}

% Real image:
\reportfigure[0.8]{figures/filename.png}{Caption text}
```

**Use case tables:**
```latex
\begin{usecasetable}{Use Case: Name}
\ucfield{Title}{Name}
\ucfield{Actors}{Actor1, Actor2}
\ucfield{Description}{...}
\ucfield{Pre-conditions}{...}
\ucfield{Post-conditions}{...}
\ucfield{Main Flow}{1. ...\\ 2. ...\\}
\ucfield{Alternative Flow}{...}
\end{usecasetable}
```

**Database tables:**
```latex
\begin{dbtable}{Table: name}
\dbcol{column}{TYPE}{No}{description}
\end{dbtable}
```

### Step 4: Compile and Verify

```bash
cd report-template
pdflatex -interaction=nonstopmode rapport.tex  # run 3 times
```

Fix any LaTeX errors, then report the result.

## Output Checklist

- [ ] Report in English (per user requirement)
- [ ] Title page with all metadata
- [ ] Remerciements, Dedications
- [ ] Abstracts (French + English)
- [ ] Table of Contents, List of Figures, List of Tables
- [ ] 4 chapters with Introduction/Conclusion in each
- [ ] Use case tables with full descriptions
- [ ] Database schema tables
- [ ] Figure placeholders for all diagrams/screenshots
- [ ] General Conclusion + Perspectives
- [ ] Bibliography
- [ ] Compiles to PDF without errors