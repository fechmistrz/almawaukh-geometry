\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{LegrandOrangeBook}[2022/01/26 The Legrand Orange Book Class v3.0]
\LoadClass[9pt, twoside]{extbook} % Load the base class
\RequirePackage{etoolbox} % Required for conditional logic and easily changing commands

% https://tex.stackexchange.com/questions/44694/fontenc-vs-inputenc
% - inputenc allows the user to input accented characters directly from the keyboard;
% - fontenc is oriented to output, that is, what fonts to use for printing characters.
% The two packages are not connected, though it is best to call fontenc first and then inputenc.

\RequirePackage{mlmodern}
\RequirePackage[T1]{fontenc} % Output font encoding for international characters
\RequirePackage[utf8]{inputenc} % Required for inputting international characters
\RequirePackage{polski}


%%%%%%%%%% %%%%%%%%%%% %%%%%%%%%%
%%%%%%%%%% PAGE LAYOUT %%%%%%%%%%
%%%%%%%%%% %%%%%%%%%%% %%%%%%%%%%

\RequirePackage[
    paperwidth=6.125in,
    paperheight=9.25in,
    left=0.8125in,
    right=0.6875in,
    top=1.075in,
    bottom=0.885in,
    twoside,
    % showframe,
    headsep=0.15in,
]{geometry}

\RequirePackage{fancyhdr}

\fancypagestyle{plain}{
    \fancyhf{}
    \fancyfoot[C]{}
    \renewcommand{\headrulewidth}{0pt}
    \renewcommand{\footrulewidth}{0pt}
}
\pagestyle{fancy}
\fancyhead{}
\fancyfoot{}
% 341      Rozdział 7. Kalifat algebry | 7.2 Pierścień adeli              342 |
\fancyhead[LE]{\thepage}
\fancyhead[RE]{\nouppercase{\leftmark}}
\fancyhead[LO]{\nouppercase{\rightmark}}
\fancyhead[RO]{\thepage}
\renewcommand{\headrulewidth}{0.4pt}
\renewcommand{\footrulewidth}{0.0pt}

\RequirePackage{emptypage} % prevents page numbers and headings from appearing on empty pages.

%%%%%%%%%% %%%%%%%%%% %%%%%%%%%%
%%%%%%%%%% TYPOGRAPHY %%%%%%%%%%
%%%%%%%%%% %%%%%%%%%% %%%%%%%%%%

\RequirePackage{amsmath, amsfonts, amssymb, amsthm} % For math equations, theorems, symbols, etc
\renewcommand{\qedsymbol}{$\blacksquare$} % Redefine the QED symbol to be a filled square vs. the default unfilled square
\RequirePackage[final]{microtype}
% \RequirePackage{paralist}
\RequirePackage[explicit, newparttoc]{titlesec}
% explicit:   specify section names explicitly in \titleformat with #1
% newparttoc: required for writing the part toc entry number in a standard way (overriding default LaTeX behavior) so the titletoc package can style it
\RequirePackage[toc]{appendix} % for the appendices chapters

%%%%%%%%%% %%%%%% %%%%%%%%%%
%%%%%%%%%% COLORS %%%%%%%%%%
%%%%%%%%%% %%%%%% %%%%%%%%%%

\RequirePackage[usenames, svgnames, table]{xcolor} % Required for defining and using custom colors
\definecolor{verySpecialColor}{RGB}{205,133,63} % Define the color used for highlighting throughout the book
\colorlet{darkblue}{yellow}
\colorlet{diagramfiller}{yellow}
\colorlet{first_colour}{yellow}
\colorlet{hotpink}{yellow}
\colorlet{mediumvioletred}{yellow}

%%%%%%%%%% %%%%%% %%%%%%%%%%
%%%%%%%%%% IMAGES %%%%%%%%%%
%%%%%%%%%% %%%%%% %%%%%%%%%%

\RequirePackage{graphicx} % Required for including pictures
\graphicspath{{img/}} % Specifies the directory where pictures are stored
\RequirePackage{float} % for \begin{figure}[H]
\RequirePackage{subcaption} % \subcaption for minipage inside figure, knot-theory textbook specific?

%%%%%%%%%%
%%%%%%%%%% NO IDEA WHAT
%%%%%%%%%%

\newcommand{\outputpartpage}[2]{
    \begin{tikzpicture}[remember picture, overlay]
        \node[anchor=center, rectangle, fill=verySpecialColor!20, inner sep=0pt, minimum height=\paperheight, minimum width=\paperwidth] at (current page.center) {}; % Background color
        \node[anchor=north west, inner sep=0pt, xshift=\Gm@lmargin, yshift=-\Gm@tmargin] at (current page.north west) {\fontsize{220pt}{220pt}\selectfont\bfseries\textcolor{verySpecialColor!40}{#1}}; % Part number
        \node[anchor=north east, inner sep=0pt, xshift=-\Gm@rmargin, yshift=-\Gm@tmargin] at (current page.north east) {\fontsize{30pt}{30pt}\selectfont\bfseries\textcolor{verySpecialColor!50!black}{\strut #2}}; % Part title
        \node[anchor=south east, inner sep=0pt, xshift=-\Gm@rmargin, yshift=\Gm@bmargin] at (current page.south east) { % Mini table of contents
            \parbox[t][][t]{8.5cm}{ \printcontents[part]{l}{0}{\setcounter{tocdepth}{1}} }
        };
    \end{tikzpicture}
}

\titleformat{\part}[block]{\startcontents[part]\outputpartpage{\thepart}{#1}}{}{0em}{}[]

\newcommand{\thechapterimage}{}
\newcommand{\chapterimage}[1]{\renewcommand{\thechapterimage}{#1}}
\newcommand{\thechapterspaceabove}{}
\newcommand{\chapterspaceabove}[1]{\renewcommand{\thechapterspaceabove}{#1}}
\newcommand{\thechapterspacebelow}{}
\newcommand{\chapterspacebelow}[1]{\renewcommand{\thechapterspacebelow}{#1}}

\newcommand{\outputchaptertitle}[2]{
    \begin{tikzpicture}[remember picture,overlay]
        \expandafter\ifstrequal\expandafter{\thechapterimage}{}{}{
            \node[anchor=north west, inner sep=0pt] at (current page.north west) {\includegraphics[width=\paperwidth]{\thechapterimage}};
        }
        \draw[anchor=west] (current page.north west) node [
            anchor=north west,
            xshift=\Gm@lmargin,
            yshift=-110pt,
            line width=2pt,
            rounded corners=10pt,
            draw=verySpecialColor,
            fill=black!5,
            fill opacity=0.6,
            text opacity=1,
            inner ysep=12.5pt,
            inner xsep=20pt,
            align=flush left,
            text width=1.2\linewidth,
            font=\huge\bfseries,
        ] {\parbox{0.85\linewidth}{\strut\raggedright\expandafter\ifstrequal\expandafter{#1}{}{}{#1. }#2\vspace{-3pt}}};
    \end{tikzpicture}
}

\titleformat{\chapter}[block]{\outputchaptertitle{\thechapter}{#1}}{}{0cm}{}[]
\titleformat{name=\chapter, numberless}[block]{\outputchaptertitle{}{#1}}{}{0cm}{}[]
\titlespacing*{\chapter}{0pt}{0pt}{150pt}

\titleformat{\section}[block]{\bfseries\Large}{{\textcolor{verySpecialColor}{\thesection}\hspace{1em}}#1}{0cm}{}[]
\titleformat{name=\section, numberless}[block]{\bfseries\Large}{#1}{0cm}{}[]
\titlespacing*{\section}{0pt}{12pt}{6pt}

\titleformat{\subsection}[block]{\bfseries\large}{{\textcolor{verySpecialColor}{\thesubsection}\hspace{1em}}#1}{0cm}{}[]
\titleformat{name=\subsection, numberless}[block]{\bfseries\large}{#1}{0cm}{}[]
\titlespacing*{\subsection}{0pt}{12pt}{4pt}

\titleformat{\subsubsection}[block]{\bfseries}{\llap{{\thesubsubsection}\hspace{1em}}#1}{0cm}{}[]
\titleformat{name=\subsubsection, numberless}[block]{\bfseries}{#1}{0cm}{}[]
\titlespacing*{\subsubsection}{0pt}{8pt}{4pt}

\titleformat{\paragraph}[runin]{\bfseries}{}{0cm}{#1}[]
\titlespacing*{\paragraph}{0pt}{0pt}{6pt} % Spacing around section titles, the order is: left, before and after

%%%%%%%%%% %%%%%%%%%%%%%%%%% %%%%%%%%%%
%%%%%%%%%% TABLE OF CONTENTS %%%%%%%%%%
%%%%%%%%%% %%%%%%%%%%%%%%%%% %%%%%%%%%%

\RequirePackage{titletoc} % Required for manipulating the table of contents
\setcounter{tocdepth}{2} % Display down to subsections in the table of contents
\contentsmargin{0cm} % Removes the default right margin

\newcommand{\tocentrypartnumbered}[1]{\setlength\fboxsep{0pt}\contentslabel[\colorbox{verySpecialColor!20}{\strut\parbox[c][.7cm]{1.1cm}{\color{verySpecialColor!70}\Large\bfseries\centering\thecontentslabel}}\hspace{4pt}\colorbox{verySpecialColor!40}{\strut\parbox[c][.7cm]{\linewidth-1.25cm}{\centering\Large #1}}]{1.25cm}}
\newcommand{\tocentrypartunnumbered}[1]{\setlength\fboxsep{0pt}\contentslabel[\colorbox{verySpecialColor!40}{\strut\parbox[c][.7cm]{\linewidth}{\centering\Large #1}}]{1.25cm}}

\titlecontents{part}[1.25cm]{\addvspace{20pt}\Large\bfseries\hypersetup{linkcolor=black}}{\tocentrypartnumbered}{\tocentrypartunnumbered}{}[]
\titlecontents{chapter}[1.25cm]{\addvspace{12pt}\large\bfseries\hypersetup{linkcolor=verySpecialColor}}{\color{verySpecialColor}\contentslabel[\Large\thecontentslabel]{1.25cm}}{}{\color{verySpecialColor!60}\normalsize\;\titlerule*[6pt]{.}\;\color{verySpecialColor}\thecontentspage}[]
\titlecontents{section}[1.25cm]{\addvspace{3pt}\bfseries}{\contentslabel[\thecontentslabel]{1.25cm}}{}{~{\normalfont\titlerule*[6pt]{.}}~\thecontentspage}[]
\titlecontents{subsection}[1.25cm]{\addvspace{1pt}\small}{\contentslabel[\thecontentslabel]{1.25cm}}{}{~\titlerule*[6pt]{.}~\thecontentspage}[]
\titlecontents{subsubsection}[1.75cm]{\small}{\contentslabel[\thecontentslabel]{1.75cm}}{}{~\titlerule*[6pt]{.}~\thecontentspage}[]
\titlecontents{figure}[0cm]{\addvspace{2pt}\small}{\thecontentslabel\hspace*{1em}}{}{~\titlerule*[6pt]{.}~\thecontentspage}[]
\titlecontents{table}[0cm]{\addvspace{2pt}\small}{\thecontentslabel\hspace*{1em}}{}{~\titlerule*[6pt]{.}~\thecontentspage}[]
\titlecontents{lchapter}[0cm]{\addvspace{12pt}\large\bfseries\hypersetup{linkcolor=verySpecialColor}}{\color{verySpecialColor}\contentslabel[\Large\thecontentslabel]{1.25cm}}{\color{verySpecialColor}}{~\color{verySpecialColor!60}\normalsize\titlerule*[6pt]{.}~\color{verySpecialColor}\thecontentspage}
\titlecontents{lsection}[0cm]{\small}{\contentslabel[\thecontentslabel]{1.25cm}}{}{~{\normalfont\titlerule*[6pt]{.}}~\thecontentspage}
\titlecontents{lsubsection}[0cm]{\footnotesize}{\contentslabel[\thecontentslabel]{1.25cm}\hspace{0.5cm}}{}{~{\normalfont\titlerule*[6pt]{.}}~\thecontentspage}

%%%%%%%%%%
%%%%%%%%%% INDEX
%%%%%%%%%%
\RequirePackage{makeidx}
\patchcmd{\theindex}{\MakeUppercase\indexname}{\normalsize\bfseries\indexname}{}{}
% https://tex.stackexchange.com/questions/22012/hyperref-and-imakeidx-do-not-work-together
\RequirePackage{imakeidx}

%%%%%%%%%%
%%%%%%%%%% TABLES
%%%%%%%%%%

\RequirePackage{array}
\RequirePackage{booktabs}
\RequirePackage{longtable}

\newcolumntype{R}[1]{>{\raggedleft\arraybackslash}p{#1}} % Define a new right-aligned paragraph column type
\newcolumntype{L}[1]{>{\raggedright\arraybackslash}p{#1}} % Define a new left-aligned (no justification) paragraph column type
\newcolumntype{C}[1]{>{\centering\arraybackslash}p{#1}} % Define a new centered paragraph column type

\let\oldtabular\tabular % alternate rowcolors for all tables
\let\endoldtabular\endtabular
\renewenvironment{tabular}
{\rowcolors{2}{white}{hotpink}\oldtabular}
{\endoldtabular}
\let\oldlongtable\longtable % alternate rowcolors for all long-tables
\let\endoldlongtable\endlongtable
\renewenvironment{longtable}
{\rowcolors{2}{white}{hotpink}\oldlongtable}
{\endoldlongtable}

%%%%%%%%%%
%%%%%%%%%% THEOREM STYLES
%%%%%%%%%%

\newtheoremstyle{OCREnum}{6pt}{6pt}{\normalfont}{}{}{}{0.25em}{\bfseries\color{verySpecialColor}\thmname{#1}~\thmnumber{\@ifnotempty{#1}{}\@upn{#2}}\thmnote{\the\thm@notefont\bfseries\color{black}---~#3.\hspace{0.25em}}}
\newtheoremstyle{OCREnumbox}{0pt}{0pt}{\normalfont}{}{}{}{0.25em}{\bfseries\color{verySpecialColor!80!black}\thmname{#1}~\thmnumber{\@ifnotempty{#1}{}\@upn{#2}}\thmnote{\the\thm@notefont\bfseries\color{black}---~#3.\hspace{0.25em}}}
\newtheoremstyle{blacknumex}{6pt}{6pt}{\normalfont}{}{}{}{0.25em}{\bfseries{\raisebox{1.25pt}{\tiny\ensuremath{\blacksquare}}}~\thmname{#1}~\thmnumber{\@ifnotempty{#1}{}\@upn{#2}}\thmnote{\the\thm@notefont\bfseries---~#3.\hspace{0.25em}}}
\newtheoremstyle{blacknumbox}{0pt}{0pt}{\normalfont}{}{}{}{0.25em}{\bfseries\thmname{#1}~\thmnumber{\@ifnotempty{#1}{}\@upn{#2}}\thmnote{\the\thm@notefont\bfseries---~#3.\hspace{0.25em}}}

\newcounter{counter}
\numberwithin{counter}{section}

\theoremstyle{OCREnum}
% NOTHING?

\theoremstyle{OCREnumbox}
\newtheorem{propositionT}[counter]{Fakt}
\newtheorem{euclidelement}[counter]{EUKLIDESOWY ELEMENT}
\newtheorem{geoconstructionT}[counter]{Konstrukcja}

\newtheorem*{personT}{Postać}
\newtheorem{theoremeT}[counter]{Twierdzenie}
\newtheorem{problem}{Problem}[chapter]
\newtheorem{exerciseT}{Exercise}[chapter]

\theoremstyle{blacknumex}
\newtheorem{exampleT}[counter]{Przyk\l{}ad}

\newtheorem{notation}{Notation}[chapter]
\newtheorem{vocabulary}{Vocabulary}[chapter]

\theoremstyle{blacknumbox}

\newtheorem{definitionT}[counter]{Definicja}
\newtheorem{corollaryT}[counter]{Wniosek}

%%%%%%%%%%
%%%%%%%%%% COLORED BOXES
%%%%%%%%%%

\RequirePackage[framemethod=default]{mdframed}

\newmdenv[skipabove=7pt, skipbelow=7pt, backgroundcolor=black!5, linecolor=verySpecialColor, innerleftmargin=5pt, innerrightmargin=5pt, innertopmargin=5pt, innerbottommargin=5pt, leftmargin=0cm, rightmargin=0cm]{tBox}
\newmdenv[skipabove=7pt, skipbelow=7pt, rightline=false, leftline=true, topline=false, bottomline=false, linecolor=verySpecialColor, linewidth=4pt, backgroundcolor=verySpecialColor!10, innerleftmargin=5pt, innerrightmargin=5pt, innertopmargin=5pt, innerbottommargin=5pt, leftmargin=0cm, rightmargin=0cm]{eBox}
\newmdenv[skipabove=5pt, skipbelow=5pt, rightline=false, leftline=true, topline=false, bottomline=false, linecolor=verySpecialColor, linewidth=4pt, backgroundcolor=verySpecialColor!10, innerleftmargin=5pt, innerrightmargin=5pt, innertopmargin=5pt, innerbottommargin=5pt, leftmargin=0cm, rightmargin=0cm]{constructionBox}
\newmdenv[skipabove=7pt, skipbelow=7pt, rightline=false, leftline=true, topline=false, bottomline=false, linecolor=verySpecialColor, linewidth=4pt, innerleftmargin=5pt, innerrightmargin=5pt, innertopmargin=0pt, innerbottommargin=0pt, leftmargin=0cm, rightmargin=0cm]{dBox}
\newmdenv[skipabove=7pt, skipbelow=7pt, rightline=false, leftline=true, topline=false, bottomline=false, linecolor=gray, linewidth=4pt, backgroundcolor=black!5, innerleftmargin=5pt, innerrightmargin=5pt, innertopmargin=5pt, innerbottommargin=5pt, leftmargin=0cm, rightmargin=0cm]{cBox}
\newmdenv[skipabove=7pt, skipbelow=7pt, rightline=false, leftline=true, topline=false, bottomline=false, linecolor=verySpecialColor, linewidth=4pt, backgroundcolor=verySpecialColor!15, innerleftmargin=5pt, innerrightmargin=5pt, innertopmargin=5pt, innerbottommargin=5pt, leftmargin=0cm, rightmargin=0cm]{cpropBox}
\newmdenv[skipabove=3pt, skipbelow=3pt, rightline=true, leftline=true, topline=false, bottomline=false, linecolor=verySpecialColor, linewidth=4pt, backgroundcolor=verySpecialColor!35, innerleftmargin=5pt, innerrightmargin=5pt, innertopmargin=5pt, innerbottommargin=5pt, leftmargin=0cm, rightmargin=0cm]{personBox}

\newenvironment{dupaexercise}{\begin{eBox}\begin{exerciseT}}{\hfill{\color{verySpecialColor}\tiny\ensuremath{\blacksquare}}\end{exerciseT}\end{eBox}}
\newenvironment{definition}{\begin{dBox}\begin{definitionT}}{\end{definitionT}\end{dBox}}
\newenvironment{example}{\begin{exampleT}}{\hfill{\tiny\ensuremath{\blacksquare}}\end{exampleT}}
\newenvironment{examplenosquare}{\begin{exampleT}}{\end{exampleT}}
\newenvironment{theorem}{\begin{tBox}\begin{theoremeT}}{\end{theoremeT}\end{tBox}}
\newenvironment{corollary}{\begin{cBox}\begin{corollaryT}}{\end{corollaryT}\end{cBox}}
\newenvironment{proposition}{\begin{cpropBox}\begin{propositionT}}{\end{propositionT}\end{cpropBox}}
\newenvironment{remark}{\small\begin{personBox}\begin{personT}}{\end{personT}\end{personBox}}
\newenvironment{geoconstruction}{\small\begin{constructionBox}\begin{geoconstructionT}}{\end{geoconstructionT}\end{constructionBox}}

\theoremstyle{plain}
\numberwithin{counter}{section}
\newtheorem{conjecture}[counter]{Hipoteza}
\newtheorem{lemma}[counter]{Lemat}
\newtheorem{warning}[counter]{Uwaga}
\newtheorem{tobedone}[counter]{Wymaga przeredagowania}

%----------------------------------------------------------------------------------------
%     LOAD PACKAGES THAT CLASH WITH OTHER PACKAGES
%----------------------------------------------------------------------------------------

\RequirePackage{tikz} % Required for drawing custom shapes and positioning elements absolutely on the page
\RequirePackage{comment}
\includecomment{comment}

\chapterimage{chapter_background.jpg} % Chapter heading image
\chapterspaceabove{6.5cm} % Default whitespace from the top of the page to the chapter title on chapter pages
\chapterspacebelow{6.75cm} % Default amount of vertical whitespace from the top margin to the start of the text on chapter pages

% https://www.reddit.com/r/LaTeX/comments/athzn1/replacing_leq_and_geq_with_leqslant_and_geqslant/
\let\savedleq=\leq
\let\savedgeq=\geq
\let\le=\leqslant
\let\ge=\geqslant

%----------------------------------------------------------------------------------------
%   LINKS
%----------------------------------------------------------------------------------------

\RequirePackage{hyperref} % clickable links, add [backref] for links from bib entries to citations
\hypersetup{
    colorlinks,
    linkcolor={verySpecialColor!50!black},
    citecolor={verySpecialColor!50!black},
    urlcolor={verySpecialColor!80!black}
}


\RequirePackage{tkz-euclide}