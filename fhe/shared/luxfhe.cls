% luxfhe.cls - Lux FHE Research Paper Class
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{luxfhe}[2025/01/26 Lux FHE Research Paper Class]

% Base class
\LoadClass[11pt,twocolumn]{article}

% Packages
\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}
\RequirePackage{amsmath,amssymb,amsthm}
\RequirePackage{mathtools}
\RequirePackage{algorithm}
\RequirePackage{algpseudocode}
\RequirePackage{booktabs}
\RequirePackage{graphicx}
\RequirePackage{xcolor}
\RequirePackage{hyperref}
\RequirePackage{cleveref}
\RequirePackage{listings}
\RequirePackage{tikz}
\RequirePackage{pgfplots}
\RequirePackage{subcaption}
\RequirePackage{multirow}
\RequirePackage{enumitem}
\RequirePackage{pifont}
\RequirePackage[margin=1in]{geometry}
\RequirePackage{fancyhdr}
\RequirePackage{titlesec}

% TikZ libraries
\usetikzlibrary{arrows,shapes,positioning,calc,backgrounds,fit}
\pgfplotsset{compat=1.18}

% Colors
\definecolor{luxblue}{RGB}{0,82,147}
\definecolor{luxgold}{RGB}{207,181,59}
\definecolor{codebg}{RGB}{245,245,245}

% Hyperref setup
\hypersetup{
    colorlinks=true,
    linkcolor=luxblue,
    citecolor=luxblue,
    urlcolor=luxblue
}

% Code listings
\lstset{
    backgroundcolor=\color{codebg},
    basicstyle=\ttfamily\small,
    breaklines=true,
    frame=single,
    numbers=left,
    numberstyle=\tiny\color{gray},
    keywordstyle=\color{luxblue}\bfseries,
    commentstyle=\color{gray}\itshape,
    stringstyle=\color{luxgold},
}

% Theorem environments
\theoremstyle{plain}
\newtheorem{theorem}{Theorem}[section]
\newtheorem{lemma}[theorem]{Lemma}
\newtheorem{proposition}[theorem]{Proposition}
\newtheorem{corollary}[theorem]{Corollary}

\theoremstyle{definition}
\newtheorem{definition}[theorem]{Definition}
\newtheorem{example}[theorem]{Example}
\newtheorem{protocol}[theorem]{Protocol}

\theoremstyle{remark}
\newtheorem{remark}[theorem]{Remark}

% Header/Footer
\pagestyle{fancy}
\fancyhf{}
\fancyhead[L]{\leftmark}
\fancyhead[R]{\thepage}
\renewcommand{\headrulewidth}{0.4pt}

% Title formatting
\titleformat{\section}{\large\bfseries\color{luxblue}}{\thesection}{1em}{}
\titleformat{\subsection}{\normalsize\bfseries}{\thesubsection}{1em}{}

\endinput
