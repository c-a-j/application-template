\ProvidesClass{resume}

\usepackage{lipsum}

\LoadClass[11pt,letterpaper]{article} % Font size and paper type

\usepackage[parfill]{parskip} % Remove paragraph indentation
\usepackage{array} % Required for boldface (\bf and \bfseries) tabular columns
\usepackage{ifthen} % Required for ifthenelse statements

\pagestyle{empty} % Suppress page numbers
\usepackage{changepage}

\usepackage{enumitem}
\setlist[itemize]{noitemsep, topsep=0pt, nosep, nolistsep}
\renewcommand\labelitemi{$\bullet$}
\renewcommand\labelitemii{$\circ$}
\renewcommand\labelitemiii{$\diamond$}
\parskip 0pt

\usepackage[left=0.75in,top=0.6in,right=0.75in,bottom=0.6in]{geometry} % Document margins
\newcommand{\tab}[1]{\hspace{.2667\textwidth}\rlap{#1}}
\newcommand{\itab}[1]{\hspace{0em}\rlap{#1}}


\input{../common/colors}
\input{../common/fonts}

% Primary font
% \setprimaryfont{Merriweather_Sans}{MerriweatherSans-VariableFont_wght}
\createfont{primaryfont}{Merriweather[opsz,wdth,wght]}
\createfont{primaryfontitalic}{Merriweather-Italic[opsz,wdth,wght]}
\setsansfont[Path=\@fontpath,RawFeature={+axis={wght=\@fontweightlight}},Renderer=Harfbuzz]{\@primaryfontfile}
\setmainfont[Color=primary, Path = \@fontpath,RawFeature={+axis={wght=\@fontweightlight}},Renderer=Harfbuzz]{\@primaryfontfile}


%--------------------------------------------------------------------------------
%	Header Formatting
%--------------------------------------------------------------------------------
\newcommand{\headerskip}{\vspace*{20pt}} % The space after the header

%--------------------------------------------------------------------------------
%	Section Formatting
%--------------------------------------------------------------------------------
\newcommand{\sectionlineskip}{\smallskip} % The space above the horizontal line for each section 
\newcommand{\sectionskip}{\vspace*{4pt}} % The space after the each section


% Defines the rSection environment for the large sections within the CV
\newenvironment{rSection}[1]{ % 1 input argument - section name
  \sectionskip
  \noindent\raggedright{\primaryfontmedium{12pt}\MakeUppercase{#1}} % Section title
  \sectionlineskip
  \hrule % Horizontal line
  \vspace*{5pt}
  \begin{list}{}{ % List for each individual item in the section
    \setlength{\leftmargin}{9pt} % Margin within the section
    % \setlength{\rightmargin}{8pt} % Margin within the section
  }
  \item[]
  \primaryfontextralight{9pt}
}{
  \end{list}
}

%----------------------------------------------------------------------------------------
%	SUMMARY SECTION FORMATTING
%----------------------------------------------------------------------------------------
\newcommand{\summarySection}[2]{
  \begin{rSection}{#1}
    \parbox[t]{0.95\textwidth}{\hyphenpenalty=10000 #2}
  \end{rSection}
  \sectionskip
}

%----------------------------------------------------------------------------------------
%	STRENGTH SECTION FORMATTING
%----------------------------------------------------------------------------------------

\newcommand{\strengthItem}[1]{
  \strengthItemFont
  \item {
      \parbox[t]{0.85\textwidth}{
        \hyphenpenalty=10000
        \hangindent=6pt
        \hangafter=1 #1}
    }
  }

\newenvironment{strengthList}[1]{
  \ifcase#1
    \def\indentSize{10pt} % case 0 (default)
    \def\strengthItemFont{\primaryfontextralight{9pt}} % case 0
  \or
    \def\indentSize{10pt} % case 1 (input = 1)
    \def\strengthItemFont{\primaryfontextralight{9pt}} % case 1
  \or
    \def\indentSize{10pt} % case 2 (input = 2)
    \def\strengthItemFont{\primaryfontextralight{9pt}} % case 2 - sub-items
  \or
    \def\indentSize{10pt} % case 3 (input = 3)
    \def\strengthItemFont{\primaryfontextralight{9pt}} % case 3 - sub-sub-items
  \fi

  \begin{itemize}[leftmargin=\indentSize]
  }{
  \end{itemize}
}

\newenvironment{strengthSection}[1]{
  \begin{rSection}{#1}
  \begin{strengthList}{0}
  }{
  \end{strengthList}
  \end{rSection}
  \sectionskip
}

%--------------------------------------------------------------------------------
%	Work Experience
%--------------------------------------------------------------------------------
\newcommand{
  \experienceItem}[1]{
    \primaryfontextralight{9pt}
    \item {
      \parbox[t]{0.78\textwidth}{
        \setlength{\baselineskip}{9pt}%
        \hyphenpenalty=10000
        \hangindent=6pt
        \hangafter=1 #1}
    }
  }

\newenvironment{experienceSection}[1]{
  \begin{rSection}{#1}
}{
  \end{rSection}
  \sectionskip
}

\newenvironment{positionDescription}[3]{
  \setlength{\baselineskip}{15pt}
  {
    {\primaryfontbold{9.5pt}#1}
    {\primaryfontlight{9.5pt}, #2}
    {\hfill \primaryfontextralight{8pt} #3}
    \vspace*{1pt}
  }
  \begin{itemize}[leftmargin=15pt]
}{
  \end{itemize}
}

\newenvironment{nestedDescription}{
  \begin{itemize}[leftmargin=10pt]
}{
  \end{itemize}
}

%--------------------------------------------------------------------------------
%	Education
%--------------------------------------------------------------------------------
\newcommand{\educationInstitution}[2]{%
  {\primaryfontmedium{10pt}#1}, #2%
  \begin{itemize}[leftmargin=18pt]%
}

\newcommand{\educationDegree}[3]{%
  \item #1\ifthenelse{\equal{#2}{}}{}{, {\primaryfontitaliclight{9pt}#2}} \hfill {\primaryfontextralight{8pt} #3}%
}

\newcommand{\closeEducationInstitution}{%
  \end{itemize}%
  \vspace*{2pt}%
}

% Legacy command for single degree per institution (backwards compatible)
\newcommand{\educationEntry}[5]{%
  \educationInstitution{#2}{#3}%
  \educationDegree{#1}{#4}{#5}%
  \closeEducationInstitution%
}

%--------------------------------------------------------------------------------
%   Fancy Box
%--------------------------------------------------------------------------------

\usepackage{tcolorbox}
\newtcbox{\myovalbox}{colback=lightgray,boxrule=0.5pt,arc=5pt,
  boxsep=0pt,left=3pt,right=3pt,top=3pt,bottom=3pt}