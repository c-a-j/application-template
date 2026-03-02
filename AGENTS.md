# Agent guide: applications repository

This document describes repository structure and generic tailoring rules. Keep all candidate-specific details in `me.md`.

## Repository purpose

- Resume: LaTeX resume (LuaLaTeX), single-page format.
- Cover letter: LaTeX cover letter (LuaLaTeX), uses shared metadata.
- Build: `make` builds both outputs at repo root.

## Build and outputs

- `make` / `make all`: build resume and cover letter.
- `make resume`: build `resume.pdf`.
- `make cover`: build `cover.pdf`.
- `make clean`, `make resume-clean`, `make cover-clean`: remove build artifacts.
- Build sources: `resume/main.tex`, `cover/main.tex`.

## Shared files (`common/`)

- `common/header.tex`: shared name/contact header.
- `common/myinfo.tex`: candidate personal/contact fields.
- `common/companyinfo.tex`: per-application role/company fields.
- `common/settings.tex`: greeting/closing defaults.
- `common/colors.tex`: color definitions.
- `common/fonts.tex`: font config for resume/cover classes.
- `common/fonts/getfont.sh`: helper for downloading fonts.

## Resume layout

- `resume/main.tex` inputs common files and resume components.
- `resume/resume.cls` defines resume-specific section/item macros and styling.
- Default components:
  - `resume/components/summary.tex`
  - `resume/components/strengths.tex`
  - `resume/components/experience.tex`
  - `resume/components/education.tex`
- Optional components:
  - `resume/components/other_experience.tex`
- Optional components can be included by adding `\input{...}` lines to `resume/main.tex`.

## Cover letter layout

- `cover/main.tex` inputs shared files and cover components.
- `cover/cover.cls` defines cover-letter-specific macros and layout.
- Components:
  - `cover/components/intro.tex`
  - `cover/components/body.tex`
  - `cover/components/conclusion.tex`
  - `cover/components/closing.tex`

## Candidate source of truth

- All candidate-specific details are stored in `me.md`.
- Tailoring must stay within facts listed in `me.md`.
- Do not invent employers, dates, titles, technologies, certifications, education, or achievements.

## Generic workflow for a job posting

1. Read the job description and identify role, company, required skills, preferred skills, and tone.
2. Load `me.md` and use it as the only source of candidate facts.
3. Update `common/companyinfo.tex` for the target application.
4. Tailor resume component wording/order to align with job requirements while preserving factual accuracy.
5. Tailor cover letter component wording to the role/company while preserving factual accuracy.
6. Build with `make` and review `resume.pdf` and `cover.pdf`.

## Application checklist

- [ ] `common/info/company.tex` updated
- [ ] `common/settings.tex` reviewed (recipient/greeting)
- [ ] Resume components tailored to job keywords
- [ ] Cover components tailored to role/company
- [ ] Candidate facts validated against `me.md`
- [ ] `make` run successfully
