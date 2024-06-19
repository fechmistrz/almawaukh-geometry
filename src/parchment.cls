\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{parchment}[2024/06/18]
\LoadClass[9pt, twoside]{extbook}
\usepackage{graphicx}
\graphicspath{{images/}}
\RequirePackage{float}      % [H] for figure environment:
\usepackage[usenames, svgnames, table]{xcolor}
\usepackage{calc}
\usepackage{changepage}
\usepackage[toc]{appendix}
\usepackage{etoolbox}

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

\usepackage[utf8]{inputenc}
\usepackage[T1]{fontenc}
\usepackage[final]{microtype}

% headers, footers
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

\usepackage{emptypage}

% \setcounter{secnumdepth}{3} % Number sections down to subsubsections, a value of 2 will number to subsections only and 1 to sections only
\usepackage[explicit, newparttoc, compact]{titlesec} % Required for modifying sections

\newcommand{\outputpartpage}[2]{
	\begin{tikzpicture}[remember picture, overlay]
		\node[anchor=center, rectangle, fill=ocre!20, inner sep=0pt, minimum height=\paperheight, minimum width=\paperwidth] at (current page.center) {}; % Background color
		\node[anchor=north west, inner sep=0pt, xshift=\Gm@lmargin, yshift=-\Gm@tmargin] at (current page.north west) {\fontsize{220pt}{220pt}\selectfont\sffamily\bfseries\textcolor{ocre!40}{#1}}; % Part number
		\node[anchor=north east, inner sep=0pt, xshift=-\Gm@rmargin, yshift=-\Gm@tmargin] at (current page.north east) {\fontsize{30pt}{30pt}\selectfont\sffamily\bfseries\textcolor{white}{\strut #2}}; % Part title
		\node[anchor=south east, inner sep=0pt, xshift=-\Gm@rmargin, yshift=\Gm@bmargin] at (current page.south east) { % Mini table of contents
			\parbox[t][][t]{8.5cm}{ % Width of box holding the mini ToC
				\printcontents[part]{l}{0}{\setcounter{tocdepth}{1}} % Display the mini table of contents showing chapters and sections, change tocdepth to 2 to also show subsections or 0 to only show chapters
			}
		};
	\end{tikzpicture}
}

\titleformat
	{\part} % Section type being modified
	[block] % Shape type, can be: hang, block, display, runin, leftmargin, rightmargin, drop, wrap, frame
	{\startcontents[part]\outputpartpage{\thepart}{#1}} % Format of the whole section
	{} % Format of the section label
	{0em} % Space between the title and label
	{} % Code before the label
	[] % Code after the label

%-------------------------------------------

\newcommand{\thechapterimage}{}
\newcommand{\chapterimage}[1]{\renewcommand{\thechapterimage}{#1}}
\newcommand{\thechapterspaceabove}{}
\newcommand{\chapterspaceabove}[1]{\renewcommand{\thechapterspaceabove}{#1}}
\newcommand{\thechapterspacebelow}{}
\newcommand{\chapterspacebelow}[1]{\renewcommand{\thechapterspacebelow}{#1}}

\newcommand{\outputchaptertitle}[2]{
	\begin{tikzpicture}[remember picture,overlay]
		% If a chapter image has been specified
		\expandafter\ifstrequal\expandafter{\thechapterimage}{}{}{
			% Output the chapter image
			\node[
				anchor=north west, % Anchor point on the image
				inner sep=0pt, % Inner padding
			] at (current page.north west) {\includegraphics[width=\paperwidth]{\thechapterimage}};
		}
		% Box with the chapter title
		\draw[anchor=west] (current page.north west) node [
			anchor=north west, % Anchor point of the chapter box
			xshift=\Gm@lmargin, % Horizontal distance from the left side of the page
			yshift=-110pt, % Vertical distance from the top of the page
			line width=2pt, % Border line thickness
			rounded corners=10pt, % Rounded corners amount
			draw=ocre, % Border line color
			fill=black!5, % Box background color
			fill opacity=0.6, % Background transparency
			text opacity=1, % Text transparency
			inner ysep=12.5pt, % Inner vertical padding
			inner xsep=20pt, % Inner horizontal padding
			align=flush left, % Text alignment inside box
			text width=1.2\linewidth, % Box width (wider than page to go off the right side)
			font=\huge\sffamily\bfseries, % Font styling for chapter title
		] {\parbox{0.85\linewidth}{\strut\raggedright\expandafter\ifstrequal\expandafter{#1}{}{}{#1. }#2\vspace{-3pt}}}; % Chapter title in a fixed width box for wrapping
	\end{tikzpicture}
}

% Shape type, can be: hang, >> block << , display, runin, leftmargin, rightmargin, drop, wrap, frame
\titleformat{\chapter}[block] {\outputchaptertitle{\thechapter}{#1}}{}{0cm}{}[]
\titleformat{name=\chapter, numberless}[block]{\outputchaptertitle{}{#1}}{}{0cm}{}[]
\titlespacing*{\chapter}{0pt}{0pt}{150pt}

\titleformat{\section}[block]{\bfseries\sffamily\Large}{{\textcolor{ocre}{\thesection}\hspace{1em}}#1}{0cm}{}[]
\titleformat{name=\section, numberless}[block]{\bfseries\sffamily\Large}{#1}{0cm}{}[]
\titlespacing*{\section}{0pt}{12pt}{6pt}

\titleformat{\subsection}[block]{\bfseries\sffamily\large}{{\textcolor{ocre}{\thesubsection}\hspace{1em}}#1}{0cm}{}[]
\titleformat{name=\subsection, numberless}[block]{\bfseries\sffamily\large}{#1}{0cm}{}[]
\titlespacing*{\subsection}{0pt}{12pt}{4pt}

\titleformat{\subsubsection}[block]{\bfseries\sffamily}{\llap{{\thesubsubsection}\hspace{1em}}#1}{0cm}{}[]
\titleformat{name=\subsubsection, numberless}[block]{\bfseries\sffamily}{#1}{0cm}{}[]
\titlespacing*{\subsubsection}{0pt}{8pt}{4pt}

\titleformat{\paragraph}[runin]{\bfseries\sffamily}{}{0cm}{#1}[]
\titlespacing*{\paragraph}{0pt}{0pt}{6pt}

% table of contents
\usepackage{titletoc} % Required for manipulating the table of contents
\setcounter{tocdepth}{2} % Display down to subsections in the table of contents
\contentsmargin{0cm} % Removes the default right margin

\newcommand{\tocentrypartnumbered}[1]{\setlength\fboxsep{0pt}\contentslabel[\colorbox{ocre!20}{\strut\parbox[c][.7cm]{1.1cm}{\color{ocre!70}\Large\sffamily\bfseries\centering\thecontentslabel}}\hspace{4pt}\colorbox{ocre!40}{\strut\parbox[c][.7cm]{\linewidth-1.25cm}{\centering\Large\sffamily #1}}]{1.25cm}}
\newcommand{\tocentrypartunnumbered}[1]{\setlength\fboxsep{0pt}\contentslabel[\colorbox{ocre!40}{\strut\parbox[c][.7cm]{\linewidth}{\centering\Large\sffamily #1}}]{1.25cm}}

\titlecontents{part}[1.25cm]{\addvspace{20pt}\Large\sffamily\bfseries\hypersetup{linkcolor=black}}{\tocentrypartnumbered}{\tocentrypartunnumbered}{}[]
\titlecontents{chapter}[1.25cm]{\addvspace{12pt}\large\sffamily\bfseries\hypersetup{linkcolor=ocre}}{\color{ocre}\contentslabel[\Large\thecontentslabel]{1.25cm}}{}{\color{ocre!60}\normalsize\;\titlerule*[6pt]{.}\;\color{ocre}\thecontentspage}[]
\titlecontents{section}[1.25cm]{\addvspace{3pt}\sffamily\bfseries}{\contentslabel[\thecontentslabel]{1.25cm}}{}{~{\normalfont\titlerule*[6pt]{.}}~\thecontentspage}[]
\titlecontents{subsection}[1.25cm]{\addvspace{1pt}\sffamily\small}{\contentslabel[\thecontentslabel]{1.25cm}}{}{~\titlerule*[6pt]{.}~\thecontentspage}[]
\titlecontents{subsubsection}[1.75cm]{\sffamily\small}{\contentslabel[\thecontentslabel]{1.75cm}}{}{~\titlerule*[6pt]{.}~\thecontentspage}[]
\titlecontents{figure}[0cm]{\addvspace{2pt}\sffamily\small}{\thecontentslabel\hspace*{1em}}{}{~\titlerule*[6pt]{.}~\thecontentspage}[]
\titlecontents{table}[0cm]{\addvspace{2pt}\sffamily\small}{\thecontentslabel\hspace*{1em}}{}{~\titlerule*[6pt]{.}~\thecontentspage}[]
\titlecontents{lchapter}[0cm]{\addvspace{12pt}\large\sffamily\bfseries\hypersetup{linkcolor=ocre}}{\color{ocre}\contentslabel[\Large\thecontentslabel]{1.25cm}}{\color{ocre}}{~\color{ocre!60}\normalsize\titlerule*[6pt]{.}~\color{ocre}\thecontentspage}
\titlecontents{lsection}[0cm]{\sffamily\small}{\contentslabel[\thecontentslabel]{1.25cm}}{}{~{\normalfont\titlerule*[6pt]{.}}~\thecontentspage}
\titlecontents{lsubsection}[0cm]{\sffamily\footnotesize}{\contentslabel[\thecontentslabel]{1.25cm}\hspace{0.5cm}}{}{~{\normalfont\titlerule*[6pt]{.}}~\thecontentspage}

% tables
\usepackage{array}
\newcolumntype{R}[1]{>{\raggedleft\arraybackslash}p{#1}}
\newcolumntype{L}[1]{>{\raggedright\arraybackslash}p{#1}}
\newcolumntype{C}[1]{>{\centering\arraybackslash}p{#1}}
\usepackage{booktabs}
\RequirePackage[pdfusetitle]{hyperref}
\hypersetup{
	colorlinks=true,
	% hidelinks,
 	urlcolor=ocre,
 	linkcolor=black,
 	citecolor=ocre,
 	hyperindex=true,
 	linktoc=all,
}

% bookmarks
\usepackage{bookmark} % Required for customizing PDF bookmarks
\bookmarksetup{
	open, % Open all bookmark drawers automatically
	numbered, % Add section numbers to bookmarks
	addtohook={%
		\ifnum\bookmarkget{level}=-1 % Customize part bookmarks
			\bookmarksetup{color=ocre, bold}% Bold and colored
		\fi
		\ifnum\bookmarkget{level}=0 % Customize chapter bookmarks
			\bookmarksetup{bold}% Bold
		\fi
	}
}

\usepackage{amsmath, amsfonts, amssymb, amsthm} % For math equations, theorems, symbols, etc
\renewcommand{\qedsymbol}{$\blacksquare$}

\newtheoremstyle{ocrenum}{6pt}{6pt}{\normalfont}{}{}{}{0.25em}{\small\sffamily\bfseries\color{ocre}\thmname{#1}~\thmnumber{\@ifnotempty{#1}{}\@upn{#2}}\thmnote{\the\thm@notefont\sffamily\bfseries\color{black}---~#3.\hspace{0.25em}}}
\newtheoremstyle{ocrenumbox}{0pt}{0pt}{\normalfont}{}{}{}{0.25em}{\small\sffamily\bfseries\color{ocre!80!black}\thmname{#1}~\thmnumber{\@ifnotempty{#1}{}\@upn{#2}}\thmnote{\the\thm@notefont\sffamily\bfseries\color{black}---~#3.\hspace{0.25em}}}
\newtheoremstyle{blacknumex}{6pt}{6pt}{\normalfont}{}{}{}{0.25em}{\small\sffamily\bfseries{\raisebox{1.25pt}{\tiny\ensuremath{\blacksquare}}}~\thmname{#1}~\thmnumber{\@ifnotempty{#1}{}\@upn{#2}}\thmnote{\the\thm@notefont\sffamily\bfseries---~#3.\hspace{0.25em}}}
\newtheoremstyle{blacknumbox}{0pt}{0pt}{\normalfont}{}{}{}{0.25em}{\small\sffamily\bfseries\thmname{#1}~\thmnumber{\@ifnotempty{#1}{}\@upn{#2}}\thmnote{\the\thm@notefont\sffamily\bfseries---~#3.\hspace{0.25em}}}

\newcounter{counter}
\numberwithin{counter}{section}

\theoremstyle{ocrenum}

\theoremstyle{ocrenumbox}
\newtheorem{propositionT}[counter]{Fakt}
\newtheorem{problemT}[counter]{Problem}
\newtheorem*{personT}{Postać}
\newtheorem{theoremeT}[counter]{Twierdzenie}
\newtheorem{exerciseT}{Exercise}[chapter]

\theoremstyle{blacknumex}
\newtheorem{exampleT}[counter]{Przyk\l{}ad}
\newtheorem{notation}{Notation}[chapter]
\newtheorem{vocabulary}{Vocabulary}[chapter]

\theoremstyle{blacknumbox}
\newtheorem{definitionT}[counter]{Definicja}
\newtheorem{corollaryT}[counter]{Wniosek}

\RequirePackage[framemethod=default]{mdframed} % Required for creating colored boxes used for theorems, definitions, exercises and corollaries

\newmdenv[skipabove=7pt,skipbelow=7pt,backgroundcolor=black!5,linecolor=ocre,innerleftmargin=5pt,innerrightmargin=5pt,innertopmargin=5pt,innerbottommargin=5pt,leftmargin=0cm,rightmargin=0cm]{tBox}
\newmdenv[skipabove=7pt,skipbelow=7pt,rightline=false,leftline=true,topline=false,bottomline=false,linecolor=ocre,linewidth=4pt,backgroundcolor=ocre!10,innerleftmargin=5pt,innerrightmargin=5pt,innertopmargin=5pt,innerbottommargin=5pt,leftmargin=0cm,rightmargin=0cm]{eBox}
\newmdenv[skipabove=7pt,skipbelow=7pt,rightline=false,leftline=true,topline=false,bottomline=false,linecolor=ocre,linewidth=4pt,innerleftmargin=5pt,innerrightmargin=5pt,innertopmargin=0pt,innerbottommargin=0pt,leftmargin=0cm,rightmargin=0cm]{dBox}
\newmdenv[skipabove=7pt,skipbelow=7pt,rightline=false,leftline=true,topline=false,bottomline=false,linecolor=gray,linewidth=4pt,backgroundcolor=black!5,innerleftmargin=5pt,innerrightmargin=5pt,innertopmargin=5pt,innerbottommargin=5pt,leftmargin=0cm,rightmargin=0cm]{cBox}
\newmdenv[skipabove=7pt,skipbelow=7pt,rightline=false,leftline=true,topline=false,bottomline=false,linecolor=ocre,linewidth=4pt,backgroundcolor=ocre!15,innerleftmargin=5pt,innerrightmargin=5pt,innertopmargin=5pt,innerbottommargin=5pt,leftmargin=0cm,rightmargin=0cm]{cpropBox}
\newmdenv[skipabove=7pt,skipbelow=7pt,rightline=false,leftline=true,topline=false,bottomline=false,linecolor=ocre,linewidth=4pt,backgroundcolor=ocre!15,innerleftmargin=5pt,innerrightmargin=5pt,innertopmargin=5pt,innerbottommargin=5pt,leftmargin=0cm,rightmargin=0cm]{cprobBox}
\newmdenv[skipabove=3pt,skipbelow=3pt,rightline=true,leftline=true,topline=false,bottomline=false,linecolor=ocre,linewidth=4pt,backgroundcolor=ocre!35,innerleftmargin=5pt,innerrightmargin=5pt,innertopmargin=5pt,innerbottommargin=5pt,leftmargin=0cm,rightmargin=0cm]{personBox}

\newenvironment{dupaexercise}{\begin{eBox}\begin{exerciseT}}{\hfill{\color{ocre}\tiny\ensuremath{\blacksquare}}\end{exerciseT}\end{eBox}}

\newenvironment{definition}{\begin{dBox}\begin{definitionT}}{\end{definitionT}\end{dBox}}
\newenvironment{example}{\begin{exampleT}}{\hfill{\tiny\ensuremath{\blacksquare}}\end{exampleT}}	
\newenvironment{examplenosquare}{\begin{exampleT}}{\end{exampleT}}	
\newenvironment{theorem}{\begin{tBox}\begin{theoremeT}}{\end{theoremeT}\end{tBox}}
\newenvironment{corollary}{\begin{cBox}\begin{corollaryT}}{\end{corollaryT}\end{cBox}}
\newenvironment{proposition}{\begin{cpropBox}\begin{propositionT}}{\end{propositionT}\end{cpropBox}}
\newenvironment{problem}{\begin{cprobBox}\begin{problemT}}{\end{problemT}\end{cprobBox}}
\newenvironment{remark}{\small\begin{personBox}\begin{personT}}{\end{personT}\end{personBox}}

\theoremstyle{plain}
\numberwithin{counter}{section}
\newtheorem{conjecture}[counter]{Hipoteza}
\newtheorem{lemma}[counter]{Lemat}
\newtheorem{warning}[counter]{Uwaga}
\newtheorem{tobedone}[counter]{Wymaga przeredagowania}

\usepackage{tikz} % Required for drawing custom shapes and positioning elements absolutely on the page
\definecolor{ocre}{RGB}{105, 180, 255} % Define the color used for highlighting throughout the book
\chapterimage{chapter_background.jpg} % Chapter heading image
\chapterspaceabove{6.5cm} % Default whitespace from the top of the page to the chapter title on chapter pages
\chapterspacebelow{6.75cm} % Default amount of vertical whitespace from the top margin to the start of the text on chapter pages

% to handle ą, ć, ę, etc.
\RequirePackage{polski}
\usepackage{Alegreya}
\RequirePackage{paralist}

% https://tex.stackexchange.com/questions/22012/hyperref-and-imakeidx-do-not-work-together
\RequirePackage{imakeidx}

\RequirePackage{subcaption} % captions to subfigures

% https://www.reddit.com/r/LaTeX/comments/athzn1/replacing_leq_and_geq_with_leqslant_and_geqslant/
\let\savedleq=\leq %
\let\savedgeq=\geq %
\let\le=\leqslant %
\let\ge=\geqslant %

\usepackage{enumitem}
\usepackage{booktabs}
\usepackage{longtable}
\usepackage[table]{xcolor}
\usepackage[colorinlistoftodos,prependcaption]{todonotes}
\usepackage{tikz}
\usetikzlibrary{arrows.meta}
\usetikzlibrary{decorations.markings}
\usetikzlibrary{decorations.pathreplacing}
\usetikzlibrary{knots}
\colorlet{darkblue}{ocre!80!black}

\let\oldtabular\tabular % alternate rowcolors for all tables
\let\endoldtabular\endtabular
\renewenvironment{tabular}
{\rowcolors{2}{white}{ocre}\oldtabular}
{\endoldtabular}
\let\oldlongtable\longtable % alternate rowcolors for all long-tables
\let\endoldlongtable\endlongtable
\renewenvironment{longtable}
{\rowcolors{2}{white}{ocre}\oldlongtable}
{\endoldlongtable}

% clickable links
% add [backref] for links from bib entries to citations
% add [pdfusetitle] for metadata
\hypersetup{
    colorlinks,
    linkcolor={darkblue},
    citecolor={darkblue},
    urlcolor={darkblue}
}

% constructions
\usepackage{tkz-euclide}

% index
\usepackage{makeidx}
\patchcmd{\theindex}{\MakeUppercase\indexname}{\sffamily\normalsize\bfseries\indexname}{}{}
\makeindex[title=Skorowidz]
\makeindex[name=persons,title=Indeks osób]
