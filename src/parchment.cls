\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{parchment}[2024/04/26 Lecture notes]
\LoadClass[twoside, 9pt]{extreport}

\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}
\RequirePackage{polski}

\RequirePackage{Alegreya}
\RequirePackage[final]{microtype}

\RequirePackage{float} % [H] for figure environment:

\RequirePackage[
    paperwidth=6.14in,
    paperheight=9.21in,
    left=0.82in,
    right=0.695in,
    top=0.6in,
    bottom=0.71in,
    % twoside,
    % headsep=0.15in,
    % includehead,
    % includefoot
]{geometry}


% https://tex.stackexchange.com/questions/22012/hyperref-and-imakeidx-do-not-work-together
\RequirePackage{imakeidx}
% https://tex.stackexchange.com/questions/492461/showidx-gives-undefined-control-sequence-error
\RequirePackage[pdfusetitle]{hyperref}

% \RequirePackage{etoolbox}



\RequirePackage{amsmath} % \DeclareMathOperator:
\RequirePackage{amsthm}  % \theoremstyle, \newtheorem:

\makeindex[title=Skorowidz]
\makeindex[name=persons,title=Indeks osób]

\theoremstyle{plain}
\newcounter{counter}
\numberwithin{counter}{section}
% \newtheorem{conjecture}[counter]{Hipoteza}
% \newtheorem{corollary}[counter]{Wniosek}
% \newtheorem{definition}[counter]{Definicja}
% \newtheorem{example}[counter]{Przyk\l{}ad}
% \newtheorem{lemma}[counter]{Lemat}
% \newtheorem{proposition}[counter]{Fakt}
\newtheorem{theorem}[counter]{Twierdzenie}
% \newtheorem{warning}[counter]{Uwaga}
% \newtheorem{tobedone}[counter]{Wymaga przeredagowania}


% \usepackage{tikz}
% \usetikzlibrary{positioning,through,calc,intersections,arrows.meta,arrows,external}
% \usetikzlibrary{calc,intersections,through,backgrounds}
% \tikzexternalize[prefix=tikz/]
% \tikzset{>=stealth} % Use stealth arrows
\usepackage{tkz-euclide}