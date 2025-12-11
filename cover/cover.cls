\ProvidesClass{cover-letter}

\usepackage{lipsum}

\NeedsTeXFormat{LaTeX2e}
\DeclareOption{print}{\def\@cv@print{}}
\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{article}
}
\ProcessOptions\relax
\LoadClass{article}

% Package Imports
\usepackage[hmargin=2.54cm, vmargin=2.54cm]{geometry}
\usepackage[hidelinks]{hyperref}
\usepackage[dvipsnames]{xcolor}
\usepackage{titlesec}
\usepackage[absolute]{textpos}
\usepackage{fontspec} 
\usepackage{graphicx}

\input{../common/colors}
\input{../common/fonts}

% Primary font
% \setprimaryfont{Merriweather_Sans}{MerriweatherSans-VariableFont_wght}
\createfont{primaryfont}{Montserrat[wght]}
\setmainfont[Color=primary, Path = \@fontpath,RawFeature={+axis={wght=\@fontweightlight}},Renderer=Harfbuzz]{\@primaryfontfile}

% secondary font
% \setsecondaryfont{EB_Garamond}{EBGaramond-VariableFont_wght}
\createfont{secondaryfont}{Montserrat[wght]}

%--------------------------------------------------------------------------------
%	Header Formatting
%--------------------------------------------------------------------------------
\newcommand{\headerskip}{\vspace*{20pt}} % The space after the header


%--------------------------------------------------------------------------------
% Cover Letter Commands
%--------------------------------------------------------------------------------
\newcommand{\companyname}[1]{\raggedright\secondaryfontbold{12pt}#1 \\ \normalfont}

\newcommand{\companyaddress}[1]{\raggedright\primaryfontmedium{11pt}#1 \\\mbox{}\\\mbox{}\\ \normalfont}

\newcommand{\currentdate}[1]{\raggedleft\primaryfontmedium{11pt}#1 \\ \normalfont}

\newcommand{\lettercontent}[1]{\raggedright\primaryfontmedium{11pt}#1 \\\mbox{}\\ \normalfont}

\newcommand{\closing}{
  \raggedright\primaryfontmedium{11pt}\closer, \\
  \IfFileExists{../common/signature.png}{%
    \vspace{.1cm}%
    \begin{minipage}[t]{4cm}
      \includegraphics[width=4cm]{../common/signature} \\
      \raggedright\primaryfontmedium{11pt} \myfirstname\space\mylastname
    \end{minipage}%
  }{%
    \raggedright\primaryfontmedium{11pt} \myfirstname\space\mylastname
  }%
}

