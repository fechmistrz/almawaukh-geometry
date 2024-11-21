\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{greaseproof}[2024/08/28]
\LoadClass[9pt, twoside]{extarticle}

\RequirePackage[
	paperwidth=6.125in,
	paperheight=9.25in,
	left=0.82in,
    right=0.695in,
    top=0.6in,
    bottom=0.71in,
	twoside,
	% showframe,
	headsep=0.1in,
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

%%%%%%%%%% HEADERS, FOOTERS
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
\fancyhead[LE]{\thepage}
\fancyhead[RE]{\nouppercase{\leftmark}}
\fancyhead[LO]{\nouppercase{\rightmark}}
\fancyhead[RO]{\thepage}
\renewcommand{\headrulewidth}{4pt}
\renewcommand{\footrulewidth}{0.0pt}

%%%%%%%%%% FONTS
\RequirePackage{Alegreya} %% Option 'black' gives heavier bold face 
\RequirePackage[euler-digits,small]{eulervm}
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
\fancyhead[CE]{$\mathcal{E}$udoksos z Ptolemais, $\mathcal{L}$achmid z Al-Hiry, $\mathcal{A}$chradyna Ecetryjska}
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
\newtheorem{integral}[counter]{Całka}
\newtheorem{corollary}[counter]{Wniosek}
\newtheorem{definition}[counter]{Definicja}
\newtheorem{problem}[counter]{Problem}
\newtheorem{example}[counter]{Przyk\l{}ad}
\newtheorem{lemma}[counter]{Lemat}
\newtheorem{proposition}[counter]{Fakt}
\newtheorem{theorem}{Twierdzenie}
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

% index
\RequirePackage{makeidx}
\patchcmd{\theindex}{\MakeUppercase\indexname}{\sffamily\normalsize\bfseries\indexname}{}{}
\makeindex[title=Skorowidz]
\makeindex[name=persons,title=Indeks osób]

\definecolor{ocre}{RGB}{105, 180, 255} % Define the color used for highlighting throughout the book
\colorlet{darkblue}{ocre!80!black}

\usepackage[subtle]{savetrees}

\usepackage{titlesec}

\renewcommand\subsection
  {%
    \@startsection
      {subsection}
      {2}
      {\z@}
      {3.25ex \@plus 0.1ex \@minus .2ex}
      {-0.2em}
      {\normalfont\normalsize\bfseries}%
}

\titleformat{\section}{\normalfont\LARGE\bfseries\centering}{\thesection{.}}{0.3em}{}