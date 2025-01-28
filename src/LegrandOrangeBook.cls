\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{LegrandOrangeBook}[2022/01/26 The Legrand Orange Book Class v3.0]
\LoadClass[9pt, twoside]{extbook}
\RequirePackage{graphicx}
\graphicspath{{Images/}}
\RequirePackage{float} % [H] for figure environment
\RequirePackage[usenames, svgnames, table]{xcolor}
\RequirePackage{calc}
%\usepackage{changepage} not needed?
\RequirePackage[toc]{appendix}
\RequirePackage{etoolbox}

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

\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}
\RequirePackage[final]{microtype}

\RequirePackage{fancyhdr}
\pagestyle{fancy}
\renewcommand{\headrulewidth}{0.5pt}
\renewcommand{\chaptermark}[1]{\markboth{\sffamily\normalsize\bfseries\chaptername\ \thechapter.~#1}{}}
\renewcommand{\sectionmark}[1]{\markright{\sffamily\normalsize\thesection~#1}{}}
\fancyhf{}
\fancyhead[LE, RO]{\sffamily\thepage}
\fancyhead[LO]{\rightmark}
\fancyhead[RE]{\leftmark}
\fancypagestyle{plain}{
    \fancyhead{}
    \renewcommand{\headrulewidth}{0pt}
}
\RequirePackage{emptypage}

\RequirePackage[explicit, newparttoc]{titlesec}

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
\newcommand{\thechapterspaceabove}{}
\newcommand{\thechapterspacebelow}{}
\newcommand{\chapterimage}[1]{\renewcommand{\thechapterimage}{#1}}
\newcommand{\chapterspaceabove}[1]{\renewcommand{\thechapterspaceabove}{#1}}
\newcommand{\chapterspacebelow}[1]{\renewcommand{\thechapterspacebelow}{#1}}

% Command to output the chapter title with optional background image
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

% Numbered chapters
\titleformat
	{\chapter} % Section type being modified
	[block] % Shape type, can be: hang, block, display, runin, leftmargin, rightmargin, drop, wrap, frame
	{\outputchaptertitle{\thechapter}{#1}} % Format of the whole section
	{} % Format of the section label
	{0cm} % Space between the title and label
	{} % Code before the label
	[] % Code after the label

% Unnumbered chapters
\titleformat
	{name=\chapter, numberless} % Section type being modified
	[block] % Shape type, can be: hang, block, display, runin, leftmargin, rightmargin, drop, wrap, frame
	{\outputchaptertitle{}{#1}} % Format of the whole section
	{} % Format of the section label
	{0cm} % Space between the title and label
	{} % Code before the label
	[] % Code after the label

\titlespacing*{\chapter}{0pt}{0pt}{150pt} % Spacing around section titles, the order is: left, before and after

%-------------------------------------------

\titleformat
	{\section} % Section type being modified
	[block] % Shape type, can be: hang, block, display, runin, leftmargin, rightmargin, drop, wrap, frame
	{\bfseries\sffamily\Large} % Format of the whole section
	{{\textcolor{ocre}{\thesection}\hspace{1em}}#1} % Format of the section label
	{0cm} % Space between the title and label
	{} % Code before the label
	[] % Code after the label
	
\titleformat
	{name=\section, numberless} % Section type being modified
	[block] % Shape type, can be: hang, block, display, runin, leftmargin, rightmargin, drop, wrap, frame
	{\bfseries\sffamily\Large} % Format of the whole section
	{#1} % Format of the section label
	{0cm} % Space between the title and label
	{} % Code before the label
	[] % Code after the label

\titlespacing*{\section}{0pt}{12pt}{6pt} % Spacing around section titles, the order is: left, before and after

%-------------------------------------------

\titleformat
	{\subsection} % Section type being modified
	[block] % Shape type, can be: hang, block, display, runin, leftmargin, rightmargin, drop, wrap, frame
	{\bfseries\sffamily\large} % Format of the whole section
	{{\textcolor{ocre}{\thesubsection}\hspace{1em}}#1} % Format of the section label
	{0cm} % Space between the title and label
	{} % Code before the label
	[] % Code after the label
	
\titleformat
	{name=\subsection, numberless} % Section type being modified
	[block] % Shape type, can be: hang, block, display, runin, leftmargin, rightmargin, drop, wrap, frame
	{\bfseries\sffamily\large} % Format of the whole section
	{#1} % Format of the section label
	{0cm} % Space between the title and label
	{} % Code before the label
	[] % Code after the label

\titlespacing*{\subsection}{0pt}{12pt}{4pt} % Spacing around section titles, the order is: left, before and after

%-------------------------------------------

\titleformat
	{\subsubsection} % Section type being modified
	[block] % Shape type, can be: hang, block, display, runin, leftmargin, rightmargin, drop, wrap, frame
	{\bfseries\sffamily} % Format of the whole section
	{\llap{{\thesubsubsection}\hspace{1em}}#1} % Format of the section label
	{0cm} % Space between the title and label
	{} % Code before the label
	[] % Code after the label
	
\titleformat
	{name=\subsubsection, numberless} % Section type being modified
	[block] % Shape type, can be: hang, block, display, runin, leftmargin, rightmargin, drop, wrap, frame
	{\bfseries\sffamily} % Format of the whole section
	{#1} % Format of the section label
	{0cm} % Space between the title and label
	{} % Code before the label
	[] % Code after the label

\titlespacing*{\subsubsection}{0pt}{8pt}{4pt} % Spacing around section titles, the order is: left, before and after

%-------------------------------------------

\titleformat
	{\paragraph} % Section type being modified
	[runin] % Shape type, can be: hang, block, display, runin, leftmargin, rightmargin, drop, wrap, frame
	{\bfseries\sffamily} % Format of the whole section
	{} % Format of the section label
	{0cm} % Space between the title and label
	{#1} % Code before the label
	[] % Code after the label

\titlespacing*{\paragraph}{0pt}{0pt}{6pt} % Spacing around section titles, the order is: left, before and after

%----------------------------------------------------------------------------------------
%	TABLE OF CONTENTS
%----------------------------------------------------------------------------------------

\usepackage{titletoc} % Required for manipulating the table of contents

\setcounter{tocdepth}{2} % Display down to subsections in the table of contents

\contentsmargin{0cm} % Removes the default right margin

%------------------------------------------------

% Styling of numbered parts in the table of contents
\newcommand{\tocentrypartnumbered}[1]{%
	\setlength\fboxsep{0pt}% Remove box padding
	\contentslabel[%
		% Part number box
		\colorbox{ocre!20}{% Background color
			\strut\parbox[c][.7cm]{1.1cm}{% Box size
				\color{ocre!70}\Large\sffamily\bfseries\centering\thecontentslabel% Part number
			}%
		}%
		\hspace{4pt}%
		% Part title box
		\colorbox{ocre!40}{% Background color
			\strut\parbox[c][.7cm]{\linewidth-1.25cm}{% Box size
				\centering\Large\sffamily #1% Part title
			}%
		}%
	]{1.25cm}
}

% Styling of unnumbered parts in the table of contents
\newcommand{\tocentrypartunnumbered}[1]{%
	\setlength\fboxsep{0pt}% Remove box padding
	\contentslabel[%
		% Part title box
		\colorbox{ocre!40}{% Background color
			\strut\parbox[c][.7cm]{\linewidth}{% Box size
				\centering\Large\sffamily #1% Part title
			}%
		}%
	]{1.25cm}
}

\titlecontents{part} % Section type being modified
	[1.25cm] % Left indentation
	{\addvspace{20pt}\Large\sffamily\bfseries\hypersetup{linkcolor=black}} % Before code
	{\tocentrypartnumbered} % Formatting of numbered sections of this type
	{\tocentrypartunnumbered} % Formatting of numberless sections of this type
	{} % Formatting of the filler to the right of the heading and the page number
	[] % After code

%------------------------------------------------

\titlecontents{chapter} % Section type being modified
	[1.25cm] % Left indentation
	{\addvspace{12pt}\large\sffamily\bfseries\hypersetup{linkcolor=ocre}} % Before code
	{\color{ocre}\contentslabel[\Large\thecontentslabel]{1.25cm}} % Formatting of numbered sections of this type
	{} % Formatting of numberless sections of this type
	{\color{ocre!60}\normalsize\;\titlerule*[6pt]{.}\;\color{ocre}\thecontentspage} % Formatting of the filler to the right of the heading and the page number
	[] % After code

%------------------------------------------------

\titlecontents{section} % Section type being modified
	[1.25cm] % Left indentation
	{\addvspace{3pt}\sffamily\bfseries} % Before code
	{\contentslabel[\thecontentslabel]{1.25cm}} % Formatting of numbered sections of this type
	{} % Formatting of numberless sections of this type
	{~{\normalfont\titlerule*[6pt]{.}}~\thecontentspage} % Formatting of the filler to the right of the heading and the page number
	[] % After code

%------------------------------------------------

\titlecontents{subsection} % Section type being modified
	[1.25cm] % Left indentation
	{\addvspace{1pt}\sffamily\small} % Before code
	{\contentslabel[\thecontentslabel]{1.25cm}} % Formatting of numbered sections of this type
	{} % Formatting of numberless sections of this type
	{~\titlerule*[6pt]{.}~\thecontentspage} % Formatting of the filler to the right of the heading and the page number
	[] % After code
	
%------------------------------------------------

\titlecontents{subsubsection} % Section type being modified
	[1.75cm] % Left indentation
	{\sffamily\small} % Before code
	{\contentslabel[\thecontentslabel]{1.75cm}} % Formatting of numbered sections of this type
	{} % Formatting of numberless sections of this type
	{~\titlerule*[6pt]{.}~\thecontentspage} % Formatting of the filler to the right of the heading and the page number
	[] % After code

%------------------------------------------------

% List of figures entries
\titlecontents{figure} % Section type being modified
	[0cm] % Left indentation
	{\addvspace{2pt}\sffamily\small} % Before code
	{\thecontentslabel\hspace*{1em}} % Formatting of numbered sections of this type
	{} % Formatting of numberless sections of this type
	{~\titlerule*[6pt]{.}~\thecontentspage} % Formatting of the filler to the right of the heading and the page number
	[] % After code

%------------------------------------------------

% List of tables entries
\titlecontents{table} % Section type being modified
	[0cm] % Left indentation
	{\addvspace{2pt}\sffamily\small} % Before code
	{\thecontentslabel\hspace*{1em}} % Formatting of numbered sections of this type
	{} % Formatting of numberless sections of this type
	{~\titlerule*[6pt]{.}~\thecontentspage} % Formatting of the filler to the right of the heading and the page number
	[] % After code

%------------------------------------------------

\titlecontents{lchapter} % Chapter headings on part pages
	[0cm] % Left indentation
	{\addvspace{12pt}\large\sffamily\bfseries\hypersetup{linkcolor=ocre}} % Before code
	{\color{ocre}\contentslabel[\Large\thecontentslabel]{1.25cm}} % Formatting of numbered sections of this type
	{\color{ocre}} % Formatting of numberless sections of this type
	{~\color{ocre!60}\normalsize\titlerule*[6pt]{.}~\color{ocre}\thecontentspage} % Formatting of the filler to the right of the heading and the page number

%------------------------------------------------

\titlecontents{lsection} % Section headings on part pages
	[0cm] % Left indentation
	{\sffamily\small} % Before code
	{\contentslabel[\thecontentslabel]{1.25cm}} % Formatting of numbered sections of this type
	{} % Formatting of numberless sections of this type
	{~{\normalfont\titlerule*[6pt]{.}}~\thecontentspage} % Formatting of the filler to the right of the heading and the page number

%------------------------------------------------

\titlecontents{lsubsection} % Subsection headings on part pages
	[0cm] % Left indentation
	{\sffamily\footnotesize} % Before code
	{\contentslabel[\thecontentslabel]{1.25cm}\hspace{0.5cm}} % Formatting of numbered sections of this type
	{} % Formatting of numberless sections of this type
	{~{\normalfont\titlerule*[6pt]{.}}~\thecontentspage} % Formatting of the filler to the right of the heading and the page number

%----------------------------------------------------------------------------------------
%	INDEX
%----------------------------------------------------------------------------------------

\usepackage{makeidx} % Required to make an index

% Modify the command to output the index to output the correctly styled Index name to the page headers
\patchcmd{\theindex}
	{\MakeUppercase\indexname} % Find
	{\sffamily\normalsize\bfseries\indexname} % Replace
	{}
	{}

%----------------------------------------------------------------------------------------
%	 TABLES
%----------------------------------------------------------------------------------------

\usepackage{array}
\usepackage{booktabs}
\usepackage{longtable}

\newcolumntype{R}[1]{>{\raggedleft\arraybackslash}p{#1}}
\newcolumntype{L}[1]{>{\raggedright\arraybackslash}p{#1}}
\newcolumntype{C}[1]{>{\centering\arraybackslash}p{#1}}

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

%----------------------------------------------------------------------------------------
%	THEOREM STYLES
%----------------------------------------------------------------------------------------

\usepackage{amsmath, amsfonts, amssymb, amsthm} % For math equations, theorems, symbols, etc

\renewcommand{\qedsymbol}{$\blacksquare$} % Redefine the QED symbol to be a filled square vs. the default unfilled square

%------------------------------------------------

% Orange theorem number and optional black title with padding above and below
\newtheoremstyle{ocrenum} % Theorem style name
	{6pt} % Space above
	{6pt} % Space below
	{\normalfont} % Body font
	{} % Indent amount
	{} % Theorem head font
	{} % Punctuation after theorem head
	{0.25em} % Space after theorem head
	{\small\sffamily\bfseries\color{ocre}\thmname{#1}~\thmnumber{\@ifnotempty{#1}{}\@upn{#2}} % Theorem text (e.g. Theorem 2.1)
	\thmnote{\the\thm@notefont\sffamily\bfseries\color{black}---~#3.\hspace{0.25em}}} % Optional theorem note

%------------------------------------------------

% Orange theorem number and optional black title with no padding above and below
\newtheoremstyle{ocrenumbox} % Theorem style name
	{0pt} % Space above
	{0pt} % Space below
	{\normalfont} % Body font
	{} % Indent amount
	{} % Theorem head font
	{} % Punctuation after theorem head
	{0.25em} % Space after theorem head
	{\small\sffamily\bfseries\color{ocre!80!black}\thmname{#1}~\thmnumber{\@ifnotempty{#1}{}\@upn{#2}} % Theorem text (e.g. Theorem 2.1)
	\thmnote{\the\thm@notefont\sffamily\bfseries\color{black}---~#3.\hspace{0.25em}}} % Optional theorem note

%------------------------------------------------

% Black theorem number and optional black title no padding above and below
\newtheoremstyle{blacknumex} % Theorem style name
	{6pt} % Space above
	{6pt} % Space below
	{\normalfont} % Body font
	{} % Indent amount
	{} % Theorem head font
	{} % Punctuation after theorem head
	{0.25em} % Space after theorem head
	{\small\sffamily\bfseries{\raisebox{1.25pt}{\tiny\ensuremath{\blacksquare}}}~\thmname{#1}~\thmnumber{\@ifnotempty{#1}{}\@upn{#2}} % Theorem text (e.g. Theorem 2.1)
	\thmnote{\the\thm@notefont\sffamily\bfseries---~#3.\hspace{0.25em}}} % Optional theorem note

%------------------------------------------------

% Black theorem number and optional black title padding above and below
\newtheoremstyle{blacknumbox} % Theorem style name
	{0pt} % Space above
	{0pt} % Space below
	{\normalfont} % Body font
	{} % Indent amount
	{} % Theorem head font
	{} % Punctuation after theorem head
	{0.25em} % Space after theorem head
	{\small\sffamily\bfseries\thmname{#1}~\thmnumber{\@ifnotempty{#1}{}\@upn{#2}} % Theorem text (e.g. Theorem 2.1)
	\thmnote{\the\thm@notefont\sffamily\bfseries---~#3.\hspace{0.25em}}} % Optional theorem note

%------------------------------------------------

\newcounter{counter}
\numberwithin{counter}{section}
% Orange theorem number and optional black title with padding above and below
\theoremstyle{ocrenum}
% Orange theorem number and optional black title with no padding above and below
\theoremstyle{ocrenumbox}
\newtheorem{propositionT}[counter]{Fakt} % Propositions, the first argument is the theorem name, the second the theorem title used before the number and the third optional argument is whether to number under chapters (e.g. 2.1) or sections (e.g. 2.1.1)
\newtheorem*{personT}{Postać} % Propositions, the first argument is the theorem name, the second the theorem title used before the number and the third optional argument is whether to number under chapters (e.g. 2.1) or sections (e.g. 2.1.1)
\newtheorem{theoremeT}[counter]{Twierdzenie} % Theorems, the first argument is the theorem name, the second the theorem title used before the number and the third optional argument is whether to number under chapters (e.g. 2.1) or sections (e.g. 2.1.1)
\newtheorem{problem}{Problem}[chapter] % Problems, the first argument is the theorem name, the second the theorem title used before the number and the third optional argument is whether to number under chapters (e.g. 2.1) or sections (e.g. 2.1.1)
\newtheorem{exerciseT}{Exercise}[chapter] % Exercises, the first argument is the theorem name, the second the theorem title used before the number and the third optional argument is whether to number under chapters (e.g. 2.1) or sections (e.g. 2.1.1)

% Black theorem number and optional black title no padding above and below
\theoremstyle{blacknumex}
\newtheorem{exampleT}[counter]{Przyk\l{}ad} % Examples, the first argument is the theorem name, the second the theorem title used before the number and the third optional argument is whether to number under chapters (e.g. 2.1) or sections (e.g. 2.1.1)
\newtheorem{notation}{Notation}[chapter] % Notations, the first argument is the theorem name, the second the theorem title used before the number and the third optional argument is whether to number under chapters (e.g. 2.1) or sections (e.g. 2.1.1)
\newtheorem{vocabulary}{Vocabulary}[chapter] % Vocabularies, the first argument is the theorem name, the second the theorem title used before the number and the third optional argument is whether to number under chapters (e.g. 2.1) or sections (e.g. 2.1.1)

% Black theorem number and optional black title with padding above and below
\theoremstyle{blacknumbox}
\newtheorem{definitionT}[counter]{Definicja} % Definitions, the first argument is the theorem name, the second the theorem title used before the number and the third optional argument is whether to number under chapters (e.g. 2.1) or sections (e.g. 2.1.1)
\newtheorem{corollaryT}[counter]{Wniosek} % Corollaries, the first argument is the theorem name, the second the theorem title used before the number and the third optional argument is whether to number under chapters (e.g. 2.1) or sections (e.g. 2.1.1
%----------------------------------------------------------------------------------------
%	COLORED THEOREM BOXES
%----------------------------------------------------------------------------------------

\RequirePackage[framemethod=default]{mdframed} % Required for creating colored boxes used for theorems, definitions, exercises and corollaries

% Theorem box
\newmdenv[
	skipabove=7pt, % Whitespace above box
	skipbelow=7pt, % Whitespace below box
	backgroundcolor=black!5, % Background color
	linecolor=ocre, % Border color
	innerleftmargin=5pt, % Inside left margin width
	innerrightmargin=5pt, % Inside right margin width
	innertopmargin=5pt, % Inside top margin height
	innerbottommargin=5pt, % Inside bottom margin height
	leftmargin=0cm, % Outside left margin width
	rightmargin=0cm % Outside right margin width
]{tBox}

% Exercise box
\newmdenv[
	skipabove=7pt, % Whitespace above box
	skipbelow=7pt, % Whitespace below box
	rightline=false, % Right line visible
	leftline=true, % Left line visible
	topline=false, % Top line visible
	bottomline=false, % Bottom line visible
	linecolor=ocre, % Line color
	linewidth=4pt, % Line width
	backgroundcolor=ocre!10, % Background color
	innerleftmargin=5pt, % Inside left margin width
	innerrightmargin=5pt, % Inside right margin width
	innertopmargin=5pt, % Inside top margin height
	innerbottommargin=5pt, % Inside bottom margin height
	leftmargin=0cm, % Outside left margin width
	rightmargin=0cm % Outside right margin width
]{eBox}

% Definition box
\newmdenv[
	skipabove=7pt, % Whitespace above box
	skipbelow=7pt, % Whitespace below box
	rightline=false, % Right line visible
	leftline=true, % Left line visible
	topline=false, % Top line visible
	bottomline=false, % Bottom line visible
	linecolor=ocre, % Border color
	linewidth=4pt, % Border width
	innerleftmargin=5pt, % Inside left margin width
	innerrightmargin=5pt, % Inside right margin width
	innertopmargin=0pt, % Inside top margin height
	innerbottommargin=0pt, % Inside bottom margin height
	leftmargin=0cm, % Outside left margin width
	rightmargin=0cm % Outside right margin width
]{dBox}

% Corollary box
\newmdenv[
	skipabove=7pt, % Whitespace above box
	skipbelow=7pt, % Whitespace below box
	rightline=false, % Right line visible
	leftline=true, % Left line visible
	topline=false, % Top line visible
	bottomline=false, % Bottom line visible
	linecolor=gray, % Line color
	linewidth=4pt, % Line width
	backgroundcolor=black!5, % Background color
	innerleftmargin=5pt, % Inside left margin width
	innerrightmargin=5pt, % Inside right margin width
	innertopmargin=5pt, % Inside top margin height
	innerbottommargin=5pt, % Inside bottom margin height
	leftmargin=0cm, % Outside left margin width
	rightmargin=0cm % Outside right margin width
]{cBox}
% Corollary box
\newmdenv[
	skipabove=7pt, % Whitespace above box
	skipbelow=7pt, % Whitespace below box
	rightline=false, % Right line visible
	leftline=true, % Left line visible
	topline=false, % Top line visible
	bottomline=false, % Bottom line visible
	linecolor=ocre, % Line color
	linewidth=4pt, % Line width
	backgroundcolor=ocre!15, % Background color
	innerleftmargin=5pt, % Inside left margin width
	innerrightmargin=5pt, % Inside right margin width
	innertopmargin=5pt, % Inside top margin height
	innerbottommargin=5pt, % Inside bottom margin height
	leftmargin=0cm, % Outside left margin width
	rightmargin=0cm % Outside right margin width
]{cpropBox}

\newmdenv[
	skipabove=3pt, % Whitespace above box
	skipbelow=3pt, % Whitespace below box
	rightline=true, % Right line visible
	leftline=true, % Left line visible
	topline=false, % Top line visible
	bottomline=false, % Bottom line visible
	linecolor=ocre, % Line color
	linewidth=4pt, % Line width
	backgroundcolor=ocre!35, % Background color
	innerleftmargin=5pt, % Inside left margin width
	innerrightmargin=5pt, % Inside right margin width
	innertopmargin=5pt, % Inside top margin height
	innerbottommargin=5pt, % Inside bottom margin height
	leftmargin=0cm, % Outside left margin width
	rightmargin=0cm % Outside right margin width
]{personBox}

% Creates an environment for each type of theorem and assigns it a theorem text style from the THEOREM STYLES block above and a colored box from above

\newenvironment{dupaexercise}{\begin{eBox}\begin{exerciseT}}{\hfill{\color{ocre}\tiny\ensuremath{\blacksquare}}\end{exerciseT}\end{eBox}}
\newenvironment{definition}{\begin{dBox}\begin{definitionT}}{\end{definitionT}\end{dBox}}
\newenvironment{example}{\begin{exampleT}}{\hfill{\tiny\ensuremath{\blacksquare}}\end{exampleT}}	
\newenvironment{examplenosquare}{\begin{exampleT}}{\end{exampleT}}	
\newenvironment{theorem}{\begin{tBox}\begin{theoremeT}}{\end{theoremeT}\end{tBox}}
\newenvironment{corollary}{\begin{cBox}\begin{corollaryT}}{\end{corollaryT}\end{cBox}}
\newenvironment{proposition}{\begin{cpropBox}\begin{propositionT}}{\end{propositionT}\end{cpropBox}}
\newenvironment{remark}{\small\begin{personBox}\begin{personT}}{\end{personT}\end{personBox}}

\theoremstyle{plain}
\numberwithin{counter}{section}
\newtheorem{conjecture}[counter]{Hipoteza}
\newtheorem{lemma}[counter]{Lemat}
\newtheorem{warning}[counter]{Uwaga}
\newtheorem{tobedone}[counter]{Wymaga przeredagowania}

%----------------------------------------------------------------------------------------
%	 LOAD PACKAGES THAT CLASH WITH OTHER PACKAGES
%----------------------------------------------------------------------------------------

\usepackage{tikz} % Required for drawing custom shapes and positioning elements absolutely on the page

\definecolor{ocre}{RGB}{255, 105, 180} % Define the color used for highlighting throughout the book
\colorlet{darkblue}{blue!80!black}
\definecolor{diagramfiller}{RGB}{255, 182, 193} % HTML: LightPink
\definecolor{first_colour}{RGB}{255, 105, 180}
\definecolor{hotpink}{RGB}{255, 105, 180}
\definecolor{mediumvioletred}{RGB}{199, 21, 133}

\chapterimage{orange1.jpg} % Chapter heading image
\chapterspaceabove{6.5cm} % Default whitespace from the top of the page to the chapter title on chapter pages
\chapterspacebelow{6.75cm} % Default amount of vertical whitespace from the top margin to the start of the text on chapter pages

% my personal inventions

% to handle ą, ć, ę, etc.
\RequirePackage{polski}
\usepackage{Alegreya}
\RequirePackage{paralist}

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

% https://tex.stackexchange.com/questions/22012/hyperref-and-imakeidx-do-not-work-together
\RequirePackage{imakeidx}

\RequirePackage{subcaption} % \subcaption for minipage inside figure:

% https://www.reddit.com/r/LaTeX/comments/athzn1/replacing_leq_and_geq_with_leqslant_and_geqslant/
\let\savedleq=\leq
\let\savedgeq=\geq
\let\le=\leqslant
\let\ge=\geqslant
\usepackage{comment}
\includecomment{comment}

\usepackage{enumitem}

% knot diagrams
\usetikzlibrary{arrows.meta}
\usetikzlibrary{decorations.markings}
\usetikzlibrary{decorations.pathreplacing}
\usetikzlibrary{knots}
\input{00-meta-latex/diagrams}
\input{00-meta-latex/shortcuts}

\author{Casimir Allard}
\title{Kombinatoryczna teoria węzłów}
%----------------------------------------------------------------------------------------
%	LINKS
%----------------------------------------------------------------------------------------

\RequirePackage[pdfusetitle]{hyperref}
\hypersetup{
	pdftitle={Kombinatoryczna teoria wężów},
	pdfauthor={Cassimir Allard}, % Author field
	pdfsubject={teoria węzłów}, % Subject field
	% pdfkeywords={Keyword1, Keyword2, ...}, % Keywords
	pdfcreator={LaTeX}, % Content creator field
    colorlinks,
    linkcolor={mediumvioletred},
    citecolor={mediumvioletred},
    urlcolor={mediumvioletred}
}