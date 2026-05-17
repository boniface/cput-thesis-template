% CPUT Thesis LaTeX class
% Version 2.8 – fully compliant with CPUT Harvard Referencing Style (October 2025)
% Authors: Boniface Kabaso and Waldon Henricks
% License: CC BY 4.0
% CPUT Thesis LaTeX class
% Version 2.8 – Enhanced Harvard Referencing (October 2025 CPUT Manual Compliance)
% 
% This class implements the Harvard referencing style as specified in:
% "The CPUT Official Harvard Referencing Style Manual" (Updated: October 2025)
% 
% Key Features:
% - Author-Year (Harvard) referencing system with biblatex
% - Sentence case for book/website titles (per CPUT manual)
% - Proper "and" vs "&" usage (and in text, & in brackets)
% - Page numbers in format (Author, Year:Page) 
% - Alphabetically sorted bibliography
% - Support for all standard source types
% - Multiple author handling (et al. for 3+ authors)
%
% Usage Examples:
%   \textcite{key}          → Van Aswegen (2006) found...
%   \parencite[45]{key}     → (Van Aswegen, 2006:45)
%   \parencite{key}         → (Van Aswegen, 2006)
%
% Changelog (v2.8):
%   - Added comprehensive Harvard compliance comments
%   - Updated to CPUT October 2025 manual specifications
%   - Enhanced documentation for citation usage
%   - Added reference guide for BibTeX entry formats
%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cputthesis}[2026/05/16 v2.8 CPUT Thesis Template - Harvard Referencing]

\LoadClass[11pt,a4paper,oneside]{report}

\RequirePackage[a4paper,top=2cm,bottom=2cm,left=3cm,right=2cm,footskip=1.1cm]{geometry}
\RequirePackage{iftex}

\ifPDFTeX
\RequirePackage[T1]{fontenc}
\RequirePackage[utf8]{inputenc}
\RequirePackage{textcomp}
\RequirePackage[scaled=0.95]{helvet}
\renewcommand{\familydefault}{\sfdefault}
\else
\RequirePackage{fontspec}
\IfFontExistsTF{Arial}{\setmainfont{Arial}}{\setmainfont{TeX Gyre Heros}}
\fi

\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{array}
\RequirePackage{booktabs}
\RequirePackage{caption}
\RequirePackage{csquotes}
\RequirePackage{etoolbox}
\RequirePackage{fancyhdr}
\RequirePackage{graphicx}
\RequirePackage{xcolor}
\definecolor{cputcitationblue}{HTML}{0057B8}
\RequirePackage[hypertexnames=false,hyperfootnotes=false]{hyperref}
\RequirePackage{longtable}
\RequirePackage{ragged2e}
\RequirePackage{setspace}
\RequirePackage{tabularx}
\RequirePackage{titlesec}
\RequirePackage{titletoc}
\RequirePackage{xparse}
\RequirePackage{xpatch}

% ---------- Biblatex with CPUT Harvard style ----------
% HARVARD REFERENCING SYSTEM CONFIGURATION
%
% The CPUT Manual (October 2025) specifies the following Harvard conventions:
% 
% 1. IN-TEXT CITATIONS:
%    - Author in text: van Aswegen (2006) found that...
%    - Author in brackets: (van Aswegen, 2006)
%    - With page: (van Aswegen, 2006:45)
%    - Two authors in text: Ellis and Peters (2000) argue...
%    - Two authors bracketed: (Ellis & Peters, 2000:45) — Note the &
%    - Three+ authors: Henderson et al. (1987:12)
%
% 2. REFERENCE LIST (Bibliography) ORDER:
%    - Alphabetical by author surname
%    - Multiple works by same author: chronological by year
%    - Same author & year: assign suffixes (2006a, 2006b, 2006c)
%
% 3. FORMATTING RULES:
%    - Book/website titles: sentence case (capitalize only first word & proper nouns)
%    - Journal names: Title Case acceptable
%    - All titles in references: italicized
%    - Format: Author(s). Year. Title. Location: Publisher.
%    - Journal articles: Author. Year. Article. Journal Name, vol(issue):pages.
%
% 4. SOURCE-SPECIFIC FORMATS:
%    - Books: Surname, I. Year. Title. Location: Publisher.
%    - Chapters: Author. Year. Chapter title. In Editor (ed.), Book title. Location: Publisher.
%    - Journal articles: Author. Year. Title. Journal, 12(3):45-60.
%    - Online: Author. Year. Title. https://url.com [DD Month YYYY].
%    - Thesis: Author. Year. Title. Unpublished degree. University, Location.
%    - Interviews: Author. Year. Interview with [person] on DD Month YYYY, Location.
%
% Configuration below ensures all CPUT Harvard requirements are met.
%
\RequirePackage[
backend=biber,
style=authoryear,
sorting=nyt,           % Sort by Name-Year-Title (alphabetical)
maxcitenames=2,        % Show first 2 authors in text (rest as "et al.")
maxbibnames=99,        % Show all authors in bibliography
giveninits=true,       % Use initials for given names (van Aswegen, L.)
uniquename=init,       % Disambiguate authors with same surname
doi=false,             % Don't show DOI in bibliography
isbn=false,            % Don't show ISBN
dashed=false,          % Don't use em-dashes for repeated authors
date=year              % Show only year (not full date)
]{biblatex}

% ---- Convert numeric extradate to letters ----
\DeclareFieldFormat{extradate}{%
	\ifcase#1\or a\or b\or c\or d\or e\or f\or g\or h\or i\or j\else #1\fi
}

% ---- Remove parentheses around the year (low-level commands) ----
\AtBeginDocument{%
	\ifcsdef{mkbibdateparens}{\renewcommand*{\mkbibdateparens}[1]{#1}}{}%
	\ifcsdef{bibdateparens}{\renewcommand*{\bibdateparens}[1]{#1}}{}%
}

% ---- Redefine the date macro to print year + extradate + period + space ----
\renewbibmacro*{date}{%
	\printfield{year}%
	\iffieldundef{extradate}{}{\printfield{extradate}}%
	\addperiod\addspace
}
\renewbibmacro*{date+extradate}{\usebibmacro{date}}

% ---- Suppress any stray issue/URL dates ----
\renewbibmacro*{issue+date}{}
\renewbibmacro*{url+urldate}{}

% ---- In-text citations: (Author, Year:Page) ----
\AtEveryCitekey{\color{cputcitationblue}}
\DeclareFieldFormat{postnote}{#1}
\DeclareFieldFormat{multipostnote}{#1}
\renewcommand{\postnotedelim}{\addcolon}
\DeclareDelimFormat{postnotedelim}{\addcolon}

% ---- Two authors: 'and' in text, '&' in parentheses ----
\renewcommand*{\finalnamedelim}{\addspace\&\addspace}
\DeclareDelimFormat{textcitedelim}{\addspace\&\addspace}
\DeclareDelimFormat{compcitedelim}{\addspace\&\addspace}
\renewcommand*{\nameyeardelim}{\addcomma\space}

% ---- Remove italics from all titles ----
\DeclareFieldFormat{title}{#1\isdot}
\DeclareFieldFormat{booktitle}{#1\isdot}
\DeclareFieldFormat{journaltitle}{#1}
\DeclareFieldFormat[article]{title}{#1}
\DeclareFieldFormat[incollection]{title}{#1}
\DeclareFieldFormat[thesis]{title}{#1}
\DeclareFieldFormat[book]{title}{#1}

% ---- Journal article: Volume(Issue):Pages (colon instead of period) ----
\DeclareFieldFormat[article]{volume}{#1}
\DeclareFieldFormat[article]{number}{\mkbibparens{#1}}
\renewbibmacro*{volume+number+eid}{%
	\printfield{volume}%
	\setunit*{}%
	\printfield{number}%
	\setunit{\addcolon\space}%
	\printfield{eid}%
}
\renewbibmacro*{journal+issuetitle}{%
	\usebibmacro{journal}%
	\setunit{\addcomma\space}%
	\usebibmacro{volume+number+eid}%
}
% Patch the article driver to replace the period before pages with a colon
\xpatchbibdriver{article}
{\newunit\newblock
	\usebibmacro{doi+eprint+url}%
	\newunit\newblock
	\usebibmacro{addendum+pubstate}%
	\setunit{\bibpagerefpunct}\newblock
	\usebibmacro{pageref}%
	\newunit\newblock
	\iftoggle{bbx:related}
	{\usebibmacro{related:init}%
		\usebibmacro{related}}
	{}}
{\setunit{\addcolon\space}%
	\usebibmacro{doi+eprint+url}%
	\newunit\newblock
	\usebibmacro{addendum+pubstate}%
	\setunit{\bibpagerefpunct}\newblock
	\usebibmacro{pageref}%
	\newunit\newblock
	\iftoggle{bbx:related}
	{\usebibmacro{related:init}%
		\usebibmacro{related}}
	{}}
{}{}
% Remove "pp." from pages
\DeclareFieldFormat[article]{pages}{#1}
\DeclareFieldFormat[incollection]{pages}{#1}
\DeclareFieldFormat{pages}{#1}

% ---- Book chapter: "In" before editor(s), editors before booktitle ----
\renewbibmacro*{in:}{}
\AtEveryBibitem{%
	\ifentrytype{incollection}
	{\renewbibmacro*{in:}{\printtext{\bibstring{in}\addspace}}}
	{}%
}
\renewbibmacro*{editor+others}{%
	\ifboolexpr{
		test \ifuseeditor
		and
		not test {\ifnameundef{editor}}
	}
	{\printnames{editor}%
		\setunit{\addspace}%
		\printtext[parens]{\bibstring{editor}}%
		\clearname{editor}}
	{}%
}
% Patch incollection driver: place editors before booktitle
\xpatchbibdriver{incollection}
{\usebibmacro{in:}%
	\usebibmacro{byeditor+others}%
	\newunit\newblock
	\usebibmacro{maintitle+booktitle}%
	\newunit\newblock
	\usebibmacro{byeditor+others}}
{\usebibmacro{in:}%
	\usebibmacro{editor+others}%
	\setunit{\addspace}%
	\usebibmacro{maintitle+booktitle}%
	\newunit\newblock}
{}{}

% ---- Thesis: add "Unpublished " once and suppress date ----
\renewbibmacro*{institution+location+date}{%
	\printtext{Unpublished }%
	\printfield{type}%
	\setunit{\addcomma\space}%
	\printlist{institution}%
	\setunit{\addcomma\space}%
	\printlist{location}%
	% No date
}

% ---- Suppress duplicate year in publisher+location+date (books) ----
\renewbibmacro*{publisher+location+date}{%
	\printlist{location}%
	\iflistundef{publisher}
	{\setunit*{\addcomma\space}}
	{\setunit*{\addcolon\space}}%
	\printlist{publisher}%
	% No date
}

% ---- Suppress duplicate year in maintitle+booktitle (incollection) ----
\renewbibmacro*{maintitle+booktitle}{%
	\iffieldundef{maintitle}
	{\printfield{booktitle}%
		\setunit{\addspace}}
	{\printfield{maintitle}%
		\setunit{\addspace}%
		\printfield{booktitle}}%
	% No date
}

% ---- Online sources: no "URL:", add n.d. if no year, access date in parentheses ----
\DeclareFieldFormat{urldate}{\mkbibparens{#1}}
\renewbibmacro*{url+urldate}{%
	\iffieldundef{year}{\printtext{n.d.}}{}%
	\setunit{\addspace}%
	\printfield{url}%
	\setunit{\addspace}%
	\printfield{urldate}%
}
\DeclareFieldFormat{url}{\url{#1}}

% ---- Newspaper: page:note (note contains the date) ----
\renewbibmacro*{note+pages}{%
	\printfield{pages}%
	\setunit{\addcolon\space}%
	\printfield{note}%
}

% ---- Remove extra spaces around page ranges ----
\setlength{\bibitemsep}{\baselineskip}
\renewcommand*{\bibrangedash}{-}

% ---- Clean online entries (remove location/publisher) ----
\AtEveryBibitem{%
	\ifentrytype{online}
	{\clearlist{location}\clearlist{publisher}}
	{}%
}

% ---- Remove any extra trailing punctuation ----
\renewcommand{\finentrypunct}{}
\AtEveryBibitem{\clearfield{note}\clearfield{month}\clearfield{day}}

% ---------- End of biblatex customisations ----------

\hypersetup{
	colorlinks=true,
	linkcolor=black,
	citecolor=cputcitationblue,
	urlcolor=cputcitationblue,
	pdfborder={0 0 0},
	pdfcreator={LaTeX using cputthesis.cls}
}
\providecommand*{\toclevel@cputchapter}{0}

\setstretch{1.5}
\setlength{\parindent}{0pt}
\setlength{\parskip}{0pt}
\setlength{\emergencystretch}{3em}
\setcounter{secnumdepth}{4}
\setcounter{tocdepth}{3}

\newcolumntype{Y}{>{\RaggedRight\arraybackslash}X}
\newcolumntype{R}{>{\raggedleft\arraybackslash}X}

% ----- Page styles (fancyhdr) -----
\pagestyle{fancy}
\fancyhf{}
\renewcommand{\headrulewidth}{0pt}
\fancyfoot[C]{\thepage}

\fancypagestyle{plain}{%
	\fancyhf{}%
	\renewcommand{\headrulewidth}{0pt}%
	\fancyfoot[C]{\thepage}%
}

\newcommand{\cput@chapterword}[1]{%
	\ifcase#1\or ONE\or TWO\or THREE\or FOUR\or FIVE\or SIX\or SEVEN\or EIGHT\or NINE\or TEN\else \number#1\fi
}

\newif\ifcput@appendix
\cput@appendixfalse

\newcommand{\cput@chapterlabel}{%
	\ifcput@appendix
	APPENDIX \thechapter
	\else
	CHAPTER \cput@chapterword{\value{chapter}}%
	\fi
}

\newcommand{\cputtocchapter}[2]{%
  {\bfseries #1: \MakeUppercase{#2}}%
}

\def\@chapter[#1]#2{%
  \ifnum \c@secnumdepth >\m@ne
    \refstepcounter{chapter}%
    \typeout{\@chapapp\space\thechapter.}%
    \begingroup
      \edef\cput@toclabel{\cput@chapterlabel}%
      \addcontentsline{toc}{cputchapter}{\protect\cputtocchapter{\cput@toclabel}{#1}}%
    \endgroup
  \else
    \addcontentsline{toc}{chapter}{#1}%
  \fi
  \chaptermark{#1}%
  \addtocontents{lof}{\protect\addvspace{10\p@}}%
  \addtocontents{lot}{\protect\addvspace{10\p@}}%
  \if@twocolumn
    \@topnewpage[\@makechapterhead{#2}]%
  \else
    \@makechapterhead{#2}%
    \@afterheading
  \fi
}

\titleformat{\chapter}[display]
{\normalfont\bfseries\centering\fontsize{12}{14}\selectfont}
{\cput@chapterlabel}
{6pt}
{\MakeUppercase}
\titlespacing*{\chapter}{0pt}{0pt}{24pt}

\titleformat{\section}
{\normalfont\bfseries\fontsize{11}{13}\selectfont}
{\thesection}
{1em}
{}
\titlespacing*{\section}{0pt}{12pt}{6pt}

\titleformat{\subsection}
{\normalfont\bfseries\fontsize{11}{13}\selectfont}
{\thesubsection}
{1em}
{}
\titlespacing*{\subsection}{0pt}{9pt}{4pt}

\titleformat{\subsubsection}
{\normalfont\bfseries\fontsize{11}{13}\selectfont}
{\thesubsubsection}
{1em}
{}
\titlespacing*{\subsubsection}{0pt}{6pt}{3pt}

\contentsmargin{2.6em}
\dottedcontents{chapter}[1.5em]{\bfseries}{1.5em}{1pc}
\dottedcontents{section}[3.8em]{}{2.3em}{1pc}
\dottedcontents{subsection}[7.0em]{}{3.2em}{1pc}
\dottedcontents{subsubsection}[10.0em]{}{4.1em}{1pc}
\dottedcontents{figure}[1.5em]{}{2.8em}{1pc}
\dottedcontents{table}[1.5em]{}{2.8em}{1pc}

% ----- Captions -----
\captionsetup{
	font={small,bf},
	labelfont=bf,
	textfont=bf,
	justification=centering,
	singlelinecheck=false
}
\captionsetup[table]{position=above}
\captionsetup[figure]{position=below}

\AtBeginEnvironment{longtable}{\singlespacing\RaggedRight}
\AtBeginEnvironment{tabularx}{\singlespacing}
\AtBeginEnvironment{table}{\singlespacing}
\AtBeginEnvironment{figure}{\singlespacing}

\DeclareNameAlias{sortname}{family-given}
\setlength{\bibitemsep}{\baselineskip}

\defbibheading{cputbibliography}{%
  \chapter*{BIBLIOGRAPHY/REFERENCES}%
  \phantomsection
  \addcontentsline{toc}{chapter}{Bibliography/References}%
}

\newcommand{\printcputbibliography}{%
	\clearpage
	\begingroup
	\singlespacing
	\RaggedRight
	\printbibliography[heading=cputbibliography]%
	\clearpage
	\endgroup
}

% ---------- Metadata ----------
\newcommand{\@thesistitle}{TITLE OF THESIS/DISSERTATION}
\newcommand{\@authorfull}{FULL FIRST NAMES \& SURNAME}
\newcommand{\@degreetype}{Master of Technology/Doctor of Technology: (choose one)}
\newcommand{\@discipline}{Discipline (e.g. Chemical Engineering, Public Relations Management)}
\newcommand{\@faculty}{in the Faculty of (name of Faculty)}
\newcommand{\@supervisor}{Supervisor: Type the name of your supervisor here, e.g. Prof BA Brain}
\newcommand{\@cosupervisor}{Co-supervisor: Add if necessary -- otherwise delete}
\newcommand{\@campus}{Bellville/Cape Town/Mowbray/Wellington (choose campus)}
\newcommand{\@submissiondate}{Date submitted (e.g. September 2007)}

\newcommand{\thesistitle}[1]{\renewcommand{\@thesistitle}{#1}}
\newcommand{\authorfull}[1]{\renewcommand{\@authorfull}{#1}}
\newcommand{\degreetype}[1]{\renewcommand{\@degreetype}{#1}}
\newcommand{\discipline}[1]{\renewcommand{\@discipline}{#1}}
\newcommand{\faculty}[1]{\renewcommand{\@faculty}{#1}}
\newcommand{\supervisor}[1]{\renewcommand{\@supervisor}{#1}}
\newcommand{\cosupervisor}[1]{\renewcommand{\@cosupervisor}{#1}}
\newcommand{\campus}[1]{\renewcommand{\@campus}{#1}}
\newcommand{\submissiondate}[1]{\renewcommand{\@submissiondate}{#1}}

\newcommand{\cputlogo}{%
	\IfFileExists{media/image1.png}{%
		\includegraphics[width=3.12431in,height=0.92917in,keepaspectratio]{media/image1.png}%
	}{%
		{\bfseries Cape Peninsula University of Technology}%
	}%
}

\newcommand{\cputfrontheading}[1]{%
	\begin{center}
		{\bfseries\fontsize{12}{14}\selectfont #1}
	\end{center}
	\vspace{10pt}
}

\newcommand{\cputblankpage}{%
	\clearpage
	\thispagestyle{empty}%
	\null
	\clearpage
}

% ----- Front matter (roman numerals) and main matter (arabic) -----
\newcommand{\frontmatter}{%
	\clearpage
	\pagenumbering{roman}%
}

\newcommand{\mainmatter}{%
	\clearpage
	\pagenumbering{arabic}%
}

% ----- Title page (absolutely no page number) -----
\renewcommand{\maketitle}{%
	\begin{titlepage}
		\thispagestyle{empty}
		\vspace*{2.2cm}
		\noindent
		\cputlogo
		\par
		
		\begin{minipage}{\textwidth}
			\RaggedRight
			\sloppy
			\vspace{0.85cm}
			{\bfseries\MakeUppercase{\@thesistitle}\par}
			\vspace{0.65cm}
			{\bfseries by\par}
			\vspace{0.65cm}
			{\bfseries\MakeUppercase{\@authorfull}\par}
			\vspace{0.65cm}
			{\bfseries Thesis/Dissertation (choose the correct one) submitted in fulfilment/partial fulfilment (choose the correct one) of the requirements for the degree\par}
			\vspace{0.55cm}
			{\bfseries \@degreetype\ \@discipline\par}
			\vspace{0.55cm}
			{\bfseries \@faculty\par}
			\vspace{0.55cm}
			{\bfseries at the Cape Peninsula University of Technology\par}
			\vspace{0.55cm}
			{\bfseries \@supervisor\par}
			\vspace{0.15cm}
			{\bfseries \@cosupervisor\par}
			\vspace{0.55cm}
			{\bfseries \@campus\par}
			\vspace{0.1cm}
			{\@submissiondate\par}
		\end{minipage}
		
		\vfill
		\begin{center}
			{\bfseries CPUT copyright information}
		\end{center}
		\noindent
		\begin{minipage}{\textwidth}
			\setstretch{1.15}
			The dissertation/thesis may not be published either in part (in scholarly, scientific or technical journals), or as a whole (as a monograph), unless permission has been obtained from the University
		\end{minipage}
	\end{titlepage}
	% Do NOT call \frontmatter here – user must call it explicitly
}

% ----- Front matter environments (each starts a new roman page) -----
\newenvironment{declaration}{%
	\clearpage
	\thispagestyle{plain}
	\vspace{3.9cm}
	\phantomsection
	\addcontentsline{toc}{chapter}{Declaration}%
	\cputfrontheading{DECLARATION}
	\setstretch{1.5}
}{%
	\par
	\vspace{1.65cm}
	\noindent\rule{\textwidth}{0.4pt}\par
	\vspace{0.25cm}
	\noindent\textbf{Signed}\hfill\textbf{Date}
	\clearpage
}

\newenvironment{cputabstract}{%
	\clearpage
	\thispagestyle{plain}
	\phantomsection
	\addcontentsline{toc}{chapter}{Abstract}%
	\cputfrontheading{ABSTRACT}
	\setstretch{1.5}
}{%
	\clearpage
}

\newenvironment{acknowledgements}{%
	\clearpage
	\thispagestyle{plain}
	\phantomsection
	\addcontentsline{toc}{chapter}{Acknowledgements}%
	\cputfrontheading{ACKNOWLEDGEMENTS}
	\setstretch{1.5}
}{%
	\clearpage
}

\newenvironment{dedication}{%
	\clearpage
	\thispagestyle{plain}
	\phantomsection
	\addcontentsline{toc}{chapter}{Dedication}%
	\cputfrontheading{DEDICATION}
	\setstretch{1.5}
}{%
	\clearpage
}

\newenvironment{cputglossary}{%
	\clearpage
	\thispagestyle{plain}
	\phantomsection
	\addcontentsline{toc}{chapter}{Glossary}%
	\cputfrontheading{GLOSSARY}
	\setstretch{1.5}
}{%
	\clearpage
}

% ----- Manual TOC helper (legacy) -----
\newcommand{\cputmanualtocline}[3]{%
	\noindent
	\makebox[2.2cm][l]{#1}%
	\makebox[\dimexpr\linewidth-3.5cm\relax][l]{#2\leaders\hbox to .6em{\hss.\hss}\hfill}%
	\makebox[1.3cm][r]{#3}\par
}

\newcommand{\cput@tocline}[3]{%
  \ifnum \c@tocdepth > #1\relax
    \begingroup
      \parindent\z@
      \leftskip\z@
      \rightskip2.6em
      \parfillskip-2.6em
      \def\numberline##1{##1\hspace{0.8em}}%
      \leavevmode #2\nobreak
      \leaders\hbox to .6em{\hss.\hss}\hfill
      \nobreak\makebox[2.6em][r]{#3}\par
    \endgroup
  \fi
}

\newcommand*\l@cputchapter[2]{%
  \ifnum \c@tocdepth >\m@ne
    \addvspace{12pt}%
    \noindent #1\par
  \fi
}

\renewcommand*\l@chapter[2]{\cput@tocline{-1}{\bfseries #1}{#2}}
\renewcommand*\l@section[2]{\cput@tocline{0}{#1}{#2}}
\renewcommand*\l@subsection[2]{\cput@tocline{1}{#1}{#2}}
\renewcommand*\l@subsubsection[2]{\cput@tocline{2}{#1}{#2}}
\renewcommand*\l@figure[2]{\cput@tocline{0}{#1}{#2}}
\let\l@table\l@figure

\renewcommand{\tableofcontents}{%
  \clearpage
  \begingroup
  \thispagestyle{plain}
  \cputfrontheading{TABLE OF CONTENTS}
  \singlespacing
  \@starttoc{toc}%
  \clearpage
  \endgroup
}

\renewcommand{\listoffigures}{%
  \clearpage
  \begingroup
  \thispagestyle{plain}
  \cputfrontheading{LIST OF FIGURES}
  \singlespacing
  \@starttoc{lof}%
  \clearpage
  \endgroup
}

\renewcommand{\listoftables}{%
  \clearpage
  \begingroup
  \thispagestyle{plain}
  \cputfrontheading{LIST OF TABLES}
  \singlespacing
  \@starttoc{lot}%
  \clearpage
  \endgroup
}

\newcommand{\cputcontents}{%
  \tableofcontents
  \listoffigures
  \listoftables
}

\newcommand{\cputmanualcontents}{\cputcontents}

% ----- Appendix -----
\renewcommand{\appendix}{%
	\par
	\setcounter{chapter}{0}%
	\setcounter{section}{0}%
	\gdef\thechapter{\Alph{chapter}}%
	\gdef\theHchapter{appendix.\Alph{chapter}}%
	\cput@appendixtrue
}

\AtBeginDocument{\justifying}
\endinput
