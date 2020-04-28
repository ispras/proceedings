\ProvidesClass{ProcISPRAS}[2018/07/15 V0.1 by Kirill Batuzov]
\NeedsTeXFormat{LaTeX2e}
\def\ProcISPRASversionmajor{0}
\def\ProcISPRASversionminor{1}

\LoadClass[twoside,10pt]{article}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax

\RequirePackage{ifxetex}
\ifxetex
    \RequirePackage{fontspec}
    % Set up fonts
    \setmainfont{tempora}
    \defaultfontfeatures[zcoL]{
        Extension = .otf,
        UprightFont = zco-Light,
        BoldFont = zco-Bold,
        ItalicFont = zco-Oblique,
        BoldItalicFont = zco-BoldOblique
    }
    \setmonofont{zcoL}
    \setsansfont{zhv}
\else
    \RequirePackage{cmap}
    \RequirePackage[T2A]{fontenc}
    \RequirePackage[utf8]{inputenc}
    % Set up fonts
    %\RequirePackage{paratype} % Arial-like sans serif font
    %\RequirePackage{DejaVuSansMono} % Free widespread monospace font with cyrillic support
    \RequirePackage{nimbussans} % Helvetica clone
    \RequirePackage[bold,light]{nimbusmono} % Courier clone
    \RequirePackage{tempora}  % "Times" font
\fi
\RequirePackage[english,russian]{babel}

\let\scshape\relax
\DeclareRobustCommand\scshape{%
  \not@math@alphabet\scshape\relax
  \fontfamily{cmr}%
  \fontshape\scdefault\selectfont}

% Set list parameters
\RequirePackage{enumitem}
\setlist[itemize]{itemsep=0.1cm,parsep=0cm,partopsep=0cm,topsep=0.1cm}
\setlist[enumerate]{itemsep=0.1cm,parsep=0cm,partopsep=0cm,topsep=0.1cm}

% Parameters to us in head/foot
\newcommand{\titleheadru}[1]{\newcommand{\thetitleheadru}{#1}}
\newcommand{\titleheaden}[1]{\newcommand{\thetitleheaden}{#1}}
\newcommand{\volhead}[1]{\newcommand{\thevolhead}{#1}}
\newcommand{\issuehead}[1]{\newcommand{\theissuehead}{#1}}
\newcommand{\pageshead}[1]{\newcommand{\thepageshead}{#1}}
\newcommand{\yearhead}[1]{\newcommand{\theyearhead}{#1}}

%
\newcounter{authorscount}
\newcounter{affilscount}

\newcommand{\authorlist}{}
\newcommand{\authorlistru}{}
\newcommand{\authorlisten}{}
\newcommand{\authorlistheadru}{}
\newcommand{\authorlistheaden}{}
\newcommand{\affillisten}{}
\newcommand{\affillistru}{}

\newcommand{\authorsep}{\\}
\newcommand{\authorheadsep}{, }
\newcommand{\affilsep}{\\}

\newcommand{\authorname}[2]{
  \g@addto@macro\authorlisten{#1}
  \g@addto@macro\authorlistru{#2}
  \g@addto@macro\authorlistheaden{#1}
  \g@addto@macro\authorlistheadru{#2}
  \g@addto@macro\authorlist{#1}%
}

\newcommand{\orcid}[1]{
  \g@addto@macro\authorlist{, ORCID: #1}
  \g@addto@macro\authorlisten{, ORCID: #1}
  \g@addto@macro\authorlistru{, ORCID: #1}
}

\newcommand{\inst}[1]{
  \g@addto@macro\authorlist{$^{#1}$}
  \g@addto@macro\authorlisten{$^{#1}$}
  \g@addto@macro\authorlistru{$^{#1}$}
}
\newcommand{\email}[1]{
  \g@addto@macro\authorlist{ <#1>}
  \g@addto@macro\authorlisten{ <#1>}
  \g@addto@macro\authorlistru{ <#1>}
}

\newcommand{\newauthor}{
  \stepcounter{authorscount}
  \ifnum \c@authorscount>1
  \g@addto@macro\authorlistru{\authorsep}
  \g@addto@macro\authorlisten{\authorsep}
  \g@addto@macro\authorlistheadru{\authorheadsep}
  \g@addto@macro\authorlistheaden{\authorheadsep}
  \g@addto@macro\authorlist{\authorsep}
  \fi
}

\newcommand{\affil}[3][]{
  \stepcounter{affilscount}

  \ifnum \c@affilscount>1%
  \g@addto@macro\affillisten{\affilsep}
  \g@addto@macro\affillistru{\affilsep}
  \fi

  \edef\affilindex{#1}
  \ifx\affilindex\empty
  \g@addto@macro\affillisten{$^{\theaffilscount}$}
  \g@addto@macro\affillistru{$^{\theaffilscount}$}
  \else
  \g@addto@macro\affillisten{$^{#1}$}
  \g@addto@macro\affillistru{$^{#1}$}
  \fi

  \g@addto@macro\affillisten{#2}
  \g@addto@macro\affillistru{#3}
}

\newcommand{\doi}[1]{\def\doi{#1}}
\newcommand{\@doi}{{\small \textbf{DOI: \doi}}}


% Setup header and footer
\RequirePackage{fancyhdr}

\pagestyle{fancy}
\fancyhf{}
\fancyhead[LE]{\scriptsize \authorlistheadru{} \@titleru{}. Труды ИСП РАН, \theyearhead{}, том~\thevolhead{} вып.~\theissuehead{}, с.~\thepageshead{}}
\fancyhead[LO]{\scriptsize \authorlistheaden{} \@titleen{}. Trudy ISP RAN/Proc. ISP RAS, \theyearhead{}, vol.~\thevolhead{}, issue~\theissuehead{}, pp.~\thepageshead{}}
\fancyfoot[RO,LE]{\thepage}
\renewcommand{\headrulewidth}{.1pt}
\renewcommand{\footrulewidth}{0pt}

% Update abstract to match formatting
\renewcommand{\abstract}[2]{
  \newcommand{\abstracten}{{\small \textbf{Abstract.} #1}}
  \newcommand{\abstractru}{{\small \textbf{Аннотация.} #2}}
}

% Acknowledgments
\newcommand{\acknowledgments}[2]{
  \newcommand{\acknowledgmentsen}{{\vskip 6pt \small \textbf{Acknowledgments:} #1}}
  \newcommand{\acknowledgmentsru}{{\vskip 6pt \small \textbf{Благодарности:} #2}}
}

% Commands to format keywords and DOI
\newcommand{\keywords}[2]{
  \newcommand{\keywordsen}{{\vskip 6pt \small \textbf{Keywords:} #1}}
  \newcommand{\keywordsru}{{\vskip 6pt \small \textbf{Ключевые слова:} #2}}
}
\newcommand{\tociteen}{
{\vskip 6pt \small \textbf{For citation:} \authorlistheaden{} \@titleen{}. Trudy ISP RAN/Proc. ISP RAS, \theyearhead{}, vol.~\thevolhead{}, issue~\theissuehead{}, pp.~\thepageshead{}. \doi{}}}
\newcommand{\tociteru}{
{\vskip 6pt \small \textbf{Для цитирования:} \authorlistheadru{} \@titleru{}. Труды ИСП РАН, \theyearhead{}, том~\thevolhead{} вып.~\theissuehead{}, с.~\thepageshead{}. \doi{}}}


\def\cmp@figurename{figure}
\def\cmp@tablename{table}
\def\cmp@lstname{listing}
\def\cmp@algname{algorithm}

\def\encapname{%
    \ifx\@captype\cmp@figurename%
        Fig.
    \else%
        \ifx\@captype\cmp@tablename%
            Table
        \else%
            \ifx\@captype\cmp@lstname%
                Listing
            \else%
                \ifx\@captype\cmp@algname%
                    Algorithm
                \else%
                    Unknown
                \fi
            \fi
        \fi
    \fi
}

\def\rucapname{%
    \ifx\@captype\cmp@figurename%
        Рис.
    \else%
        \ifx\@captype\cmp@tablename%
            Табл.
        \else%
            \ifx\@captype\cmp@lstname%
                Листинг
            \else%
                \ifx\@captype\cmp@algname%
                    Алгоритм
                \else%
                    Неизв.
                \fi
            \fi
        \fi
    \fi
}

\newlength\midcaptionskip
\setlength\abovecaptionskip{0.2cm}
\setlength\midcaptionskip{0pt}
\setlength\belowcaptionskip{0.2cm}

\newcommand{\captionisp}[2]{\refstepcounter\@captype%
% Table caption should be aligned to the left.
\ifx\@captype\cmp@tablename%
    \begin{flushleft}%
\else%
    \begin{center}%
\fi
\vskip\abovecaptionskip\small\textit{\rucapname{}\arabic{\@captype}. #1}\par%
\vskip\midcaptionskip\small\textit{\encapname{}\arabic{\@captype}. #2}\par%
\vskip\belowcaptionskip%
\ifx\@captype\cmp@tablename%
        \end{flushleft}%
    \else%
        \end{center}%
    \fi
\ifx\@captype\cmp@algname
\kern2pt\hrule\kern2pt
\fi
}

% No paragraph indent.
\setlength{\parindent}{0pt}

% Section titles
% ispSubHeader - 2 level
%\renewcommand\section{\@startsection {section}{1}{\z@}{-3.5ex \@plus -1ex \@minus -.2ex}{2.3ex \@plus.2ex}{\sffamily\bfseries\itshape\sectsize\selectfont}}
\renewcommand\section{\@startsection {section}{1}{\z@}{-12pt}{3pt}{\sffamily\bfseries\itshape\sectsize\selectfont}}
% ispSubHeader - 3 level
\renewcommand\subsection{\@startsection {subsection}{1}{\z@}{-12pt}{3pt}{\sffamily\bfseries\sectsize\selectfont}}

\def\cmp@section{1}
\def\cmp@subsection{2}
\def\cmp@subsubsection{3}
\renewcommand*{\@seccntformat}[1]{%
    \if 1\csname cmp@#1\endcsname%
        \csname the#1\endcsname.\quad% Need dot after section number
    \else%
        \csname the#1\endcsname\quad% No dot after subsection number
    \fi%
}

% From size11.clo
\newcommand\sectsize{%
   \@setfontsize\sectsize\@xipt{13.6}%
   \abovedisplayskip 11\p@ \@plus3\p@ \@minus6\p@
   \abovedisplayshortskip \z@ \@plus3\p@
   \belowdisplayshortskip 6.5\p@ \@plus3.5\p@ \@minus3\p@
   \belowdisplayskip \abovedisplayskip
%   \let\@listi\@listI
}

\renewcommand{\title}[2]{
  \newcommand{\@titleen}{#1}
  \newcommand{\@titleru}{#2}
}
\def\@maketitleru{%
    %\null
    %\vskip 48pt%
    \begin{center}%
        {\sffamily\bfseries\fontsize{16pt}{16pt}\selectfont \@titleru \par}%
        \vskip 24pt%
        \itshape\normalsize
        \authorlistru\leavevmode\\\affillistru
    \end{center}%
    \abstractru
    \keywordsru
    \tociteru
    \ifcsname acknowledgmentsru\endcsname%
        \acknowledgmentsru
    \fi%
}
\newcommand{\maketitleru}{\@maketitleru}
\def\@maketitleen{%
    %\null
    %\vskip 48pt%
    \begin{center}%
        {\sffamily\bfseries\fontsize{16pt}{16pt}\selectfont \@titleen \par}%
        \vskip 24pt%
        \itshape\normalsize
        \authorlisten\leavevmode\\\affillisten
    \end{center}%
    \abstracten
    \keywordsen
    \tociteen
    \ifcsname acknowledgmentsen\endcsname%
        \acknowledgmentsen
    \fi%
}
\newcommand{\maketitleen}{\@maketitleen}

\RequirePackage{csquotes}
\RequirePackage[backend=biber,
                bibencoding=utf8,
                style=trad-abbrv,
                citestyle=numeric-comp,
                sortcites=true,
                autolang=other,
                sorting=none,
                doi=true,
                isbn=false]{biblatex}
\appto{\bibsetup}{\raggedright}

%\renewcommand*{\@biblabel}[1]{[#1].\hfill}
%\let\oldthebibliography\thebibliography
%\let\endoldthebibliography\endthebibliography
%\renewenvironment{thebibliography}[1]{
%    \begin{oldthebibliography}{#1}
%    \setlength{\itemsep}{0em \@plus 0.3ex}
%    \setlength{\parskip}{0em \@plus 0.3ex}
%}
%{
%    \end{oldthebibliography}
%}

\setlength{\itemsep}{0em \@plus 0.3ex}
\setlength{\parskip}{1.5pt} %\@plus 0.3ex}


\RequirePackage{float}

\newfloat{listing}{thp}{lol}
\floatname{listing}{Listing}

\RequirePackage{algorithm}

\emergencystretch 3em

\RequirePackage[unicode, hidelinks]{hyperref}
\hypersetup{colorlinks=false}

\def\@makedoi{%
    \vspace*{23 pt}
    \@doi
    \vskip 18pt%
}
\newcommand{\makedoi}{\@makedoi}

\setlength{\textfloatsep}{6pt}
\setlength{\intextsep}{6pt}
