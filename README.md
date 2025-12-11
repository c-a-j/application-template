## Simple resume and cover letter template

### Dependencies

### System Requirements

- **LaTeX Distribution**: TeX Live (recommended) or MiKTeX
- **LaTeX Engine**: LuaLaTeX (required for fontspec and custom fonts)
- **Build Tool**: `make` (optional, but convenient)

### LaTeX Packages

The following LaTeX packages are required and should be included in your LaTeX distribution:

Core Packages:
- `article` - Base document class
- `fontspec` - Font selection for XeLaTeX/LuaLaTeX
- `geometry` - Page layout and margins
- `xcolor` - Color support (with `dvipsnames` option)
- `graphicx` - Graphics inclusion

Formatting Packages:
- `parskip` - Paragraph spacing
- `array` - Extended array and tabular environments
- `ifthen` - Conditional commands
- `changepage` - Page layout adjustments
- `enumitem` - Customize list environments
- `titlesec` - Section title formatting
- `textpos` - Absolute positioning (with `absolute` option)
- `fancyhdr` - Custom headers and footers
- `hyperref` - Hyperlinks (with `hidelinks` option)
- `tcolorbox` - Colored and framed boxes

Utility Packages:
- `lipsum` - Dummy text (for testing)

Note: Some of these may be unused remnants of previous versions.

## Fonts

The template currently requires the following variable fonts (TTF format) in the
`common/fonts/` directory:

- **Merriweather** - Used for resume
- **Montserrat** - Used for cover letter

Font files should be placed in `common/fonts/`. Download them manually or use
the `/common/fonts/getfont.sh` script to fetch them automatically from the Google
Fonts repository.

Example:
```bash
cd common/fonts
./getfont.sh merriweather montserrat
```

Note: If you download the fonts manually, they may have different file names
than those in the `resume.cls` and `cover.cls` files. Adjust as needed.

### Changing Fonts

Create a new font called `primaryfont`:
```latex
\createfont{primaryfont}{Merriweather[opsz,wdth,wght]}
```
This will create the following definitions that can be used throughout the document:
- primaryfontextralight
- primaryfontlight
- primaryfontmedium
- primaryfontbold
- primaryfontextrabold

Then set the main font to and main sans font:
```latex
\setmainfont[Color=primary, Path = \@fontpath,RawFeature={+axis={wght=\@fontweightlight}},Renderer=Harfbuzz]{\@primaryfontfile}
\setsansfont[Path=\@fontpath,RawFeature={+axis={wght=\@fontweightlight}},Renderer=Harfbuzz]{\@primaryfontfile}
```

Adjust or add weights as desired in `common/fonts.tex`.

## Cover letter signature

If you want to include a signature in the cover letter, add a `signature.png`
file to the `common/` directory. It will be displayed at the bottom of the cover
letter. Delete the dummy signature file if you don't want to include one.

## Compilation

1. Ensure LuaLaTeX is available: `lualatex --version`
1. Install any missing LaTeX packages
1. Download and place the required fonts in `common/fonts/`
1. Run `make` to compile both documents
   - `make cover` to compile only the cover letter
   - `make resume` to compile only the resume
   - `make clean` to get remove all binaries and pdf files

## Suggested Workflow

First, obviously, update the template with your information in your main branch.

When you want to apply to a new job, you should:
1. Create a new branch for the specific job application
1. Add the job description to the `job-desc.txt` file
   - If you get an interview, you can use this file to review the job
   description and requirements because the postings will often be taken down
   quickly.
1. Modify the information files in the `common/` directory
   - `myinfo.tex` - personal information
   - `companyinfo.tex` - company and position information
1. Make position/company specific changes to the resume and cover letter
components, if needed.  They are broken down for convenience. For example, the
body of the cover letter may not change often, but the intro and conclusion may
need to be updated for each job.
1. Compile and submit. If you submit another application to this company, just
create another branch from this branch so you don't have to start from scratch.

### Introducing Template Changes to Existing Branches

For example, you've applied to company XYZ in the past. Since then, the fonts
have changed in resume.cls and cover.cls in the main branch. You're about to
apply to XYZ again, but you want to use the new fonts. To avoid starting from
scratch or overwriting your application specific information by merging the main
branch, you can checkout individual files or cherry pick a commmit.

Checkout individual files:
```bash
git checkout XYZ_app1
git checkout -b XYZ_app2
git checkout main resume/resume.cls cover/cover.cls
```

Cherry pick a commit that only includes template changes:
```bash
git checkout XYZ_app1
git checkout -b XYZ_app2
git cherry-pick $commit_hash
```

Note: You could also merge off the main branch and checkout the company/position
specific files from the first application. Either way works.
