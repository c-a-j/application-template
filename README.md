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
   - `make show` open resume and cover. 
   - `make noshow` close resume and cover. 

**Note**: I use [Okular](https://okular.kde.org/) for viewing PDFs. It's great
for this purpose because it will hot reload after compiling the latex. Adjust
the `make show` directive if you use something else.

## Suggested Workflow

Keep template-level improvements on `main/master`, then archive each application. This
avoids maintaining long-lived branches per company.

For each job application:
1. (Optional) Start from a prior application archive:
   - Extract everything: `./archive.sh -x <archive-name>`
   - Extract only specific sections: `./archive.sh -xrl <archive-name>` (resume + cover letter)
2. Add or update the job posting in `job-desc`.
3. Update shared info files:
   - `common/info/personal.tex` - personal information
   - `common/info/company.tex` - company and role information
4. Tailor resume and cover components as needed:
   - `resume/components/*`
   - `cover/components/*`
5. Compile and submit (`make`).
6. Archive the final application state:
   - `./archive.sh -c <archive-name>`

### Reusing Previous Applications

Use extraction flags to pull only what you want from an archive:

```bash
# Extract all sections (default with -x)
./archive.sh -x acme_2026

# Extract only resume + cover letter components
./archive.sh -xrl acme_2026

# Extract only shared info
./archive.sh -xi acme_2026

# Extract only job description
./archive.sh -xj acme_2026
```

This lets you reuse targeted parts without branching for every application.
