\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{greaseproof}[2024/08/28]
\LoadClass[9pt, twoside]{extbook}

\RequirePackage[
	paperwidth=6.125in,
	paperheight=9.25in,
	left=0.6in,
	right=0.6in,
	top=0.8in,
	bottom=0.8in,
	twoside,
	% showframe,
	headsep=0.2in,
]{geometry}


\RequirePackage{graphicx}
\graphicspath{{images/}}
\RequirePackage{tikz} % Required for drawing custom shapes and positioning elements absolutely on the page

\RequirePackage[usenames, svgnames, table]{xcolor}
\RequirePackage{calc}
\RequirePackage{changepage}
\RequirePackage[toc]{appendix}
\RequirePackage{etoolbox}

\RequirePackage{float}      % [H] for figure environment:

\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}
\RequirePackage[final]{microtype}

%%%%%%%%%% FONTS
\RequirePackage{Alegreya} %% Option 'black' gives heavier bold face 

% \RequirePackage[euler-digits,small]{eulervm}
\RequirePackage{fontspec}
\RequirePackage[polish]{babel}
\RequirePackage[utf8]{inputenc}
\RequirePackage[final]{microtype}


\RequirePackage{polski}

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
\fancyhead[CE]{$\mathcal{L}$emiałgiusz z Hornšperku}
\fancyhead[RE]{}
\fancyhead[LO]{}
\fancyhead[CO]{Almanach geometryczny}
\fancyhead[RO]{\thepage}
\renewcommand{\headrulewidth}{0.4pt}
\renewcommand{\footrulewidth}{0.0pt}

\RequirePackage{amsmath} % \DeclareMathOperator
\RequirePackage{amssymb} % \mathbb
\RequirePackage{amsthm}  % \theoremstyle, \newtheorem

\theoremstyle{plain}
\newcounter{counter}
\numberwithin{counter}{section}
\newtheorem{conjecture}[counter]{Hipoteza}
\newtheorem{geoconstruction}[counter]{Konstrukcja}
\newtheorem{exercise}[counter]{Ćwiczenie}
\newtheorem{integral}[counter]{Całka}
\newtheorem{corollary}[counter]{Wniosek}
\newtheorem{definition}[counter]{Definicja}
\newtheorem{problem}[counter]{Problem}
\newtheorem{example}[counter]{Przyk\l{}ad}
\newtheorem{axiom}[counter]{Aksjomat}
\newtheorem{lemma}[counter]{Lemat}
\newtheorem{proposition}[counter]{Fakt}
\newtheorem{theorem}[counter]{Twierdzenie}
\newtheorem{warning}[counter]{Uwaga}
\newtheorem{tobedone}[counter]{Wymaga przeredagowania}

\theoremstyle{plain}
\newtheorem*{euclidelement}{Element Euklidesa}

% https://tex.stackexchange.com/questions/22012/hyperref-and-imakeidx-do-not-work-together
\RequirePackage{imakeidx}

%%%%%%%%%% HYPERLINKS
\RequirePackage[pdfusetitle]{hyperref}
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
\RequirePackage{tkz-euclide}
\RequirePackage{subcaption}

% index
\RequirePackage{makeidx}
\patchcmd{\theindex}{\MakeUppercase\indexname}{\sffamily\normalsize\bfseries\indexname}{}{}
\makeindex[title=Skorowidz]
\makeindex[name=persons,title=Indeks osób]

\definecolor{ocre}{RGB}{105, 180, 255} % Define the color used for highlighting throughout the book
\colorlet{darkblue}{ocre!80!black}

% \usepackage[subtle]{savetrees}

\usepackage{titlesec}
