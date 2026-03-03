# Agent guide: applications repository

This document describes repository structure and generic tailoring rules. Keep
all candidate-specific details in `me.md`. Job description will be located in
`job-desc`. If there's no job description contents, ask for it.

## Repository purpose

- Resume: LaTeX resume (LuaLaTeX), single-page format.
- Cover letter: LaTeX cover letter (LuaLaTeX), uses shared metadata.
- Build: `just` builds both outputs at repo root.

## Build and outputs

- Agents should not build and verify. The user will manually perform.

## Shared files (`common/`)

- `common/header.tex`: shared name/contact header. **never modify**
- `common/myinfo.tex`: candidate personal/contact fields. **never modify**
- `common/companyinfo.tex`: per-application role/company fields.
- `common/settings.tex`: greeting/closing defaults. **never modify**
- `common/colors.tex`: color definitions. **never modify**
- `common/fonts.tex`: font config for resume/cover classes. **never modify**
- `common/fonts/getfont.sh`: helper for downloading fonts. **never modify**

## Resume layout

- `resume/main.tex` inputs common files and resume components. **never modify**
- `resume/resume.cls` defines resume-specific section/item macros and styling. **never modify**
- Default components:
  - `resume/components/summary.tex`
  - `resume/components/strengths.tex`
  - `resume/components/experience.tex`
  - `resume/components/education.tex`
- Optional components:
  - `resume/components/other_experience.tex`
- Optional components can be included by adding `\input{...}` lines to `resume/main.tex`.

## Cover letter layout

- `cover/main.tex` inputs shared files and cover components. **never modify**
- `cover/cover.cls` defines cover-letter-specific macros and layout. **never modify**
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

## Application checklist

- [ ] `common/companyinfo.tex` updated
- [ ] `common/settings.tex` reviewed (recipient/greeting)
- [ ] Resume components tailored to job keywords
- [ ] Cover components tailored to role/company
- [ ] Candidate facts validated against `me.md`
