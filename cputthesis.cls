% CPUT Thesis LaTeX class
% Version 2.8 – fully compliant with CPUT Harvard Referencing Style (October 2025)
% Authors: Boniface Kabaso and Waldon Henricks
% License: CC BY 4.0

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cputthesis}[2026/05/15 v2.8 CPUT Thesis Template]

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
\RequirePackage[hidelinks,hypertexnames=false,hyperfootnotes=false]{hyperref}
\RequirePackage{longtable}
\RequirePackage{ragged2e}
\RequirePackage{setspace}
\RequirePackage{tabularx}
\RequirePackage{titlesec}
\RequirePackage{titletoc}
\RequirePackage{xparse}
\RequirePackage{xpatch}

% ---------- Biblatex with CPUT Harvard style (October 2025) ----------
\RequirePackage[
backend=biber,
style=authoryear,
sorting=nyt,
maxcitenames=2,
maxbibnames=99,
giveninits=true,
uniquename=init,
doi=false,
isbn=false,
dashed=false,
date=year
]{biblatex}

% ---- Convert numeric extradate to letters ----
\DeclareFieldFormat{extradate}{%
	\ifcase#1\or a\or b\or c\or d\or e\or f\or g\or h\or i\or j\else #1\fi
}

% ---- Remove parentheses around the year ----
\AtBeginDocument{%
	\ifcsdef{mkbibdateparens}{\renewcommand*{\mkbibdateparens}[1]{#1}}{}%
	\ifcsdef{bibdateparens}{\renewcommand*{\bibdateparens}[1]{#1}}{}%
}

% ---- Date macro: year + extradate + period + space ----
\renewbibmacro*{date}{%
	\printfield{year}%
	\iffieldundef{extradate}{}{\printfield{extradate}}%
	\addperiod\addspace
}
\renewbibmacro*{date+extradate}{\usebibmacro{date}}

% ---- Suppress issue/URL dates ----
\renewbibmacro*{issue+date}{}
\renewbibmacro*{url+urldate}{}

% ---- In-text citation: (Author, Year:Page) ----
\DeclareFieldFormat{postnote}{#1}
\DeclareFieldFormat{multipostnote}{#1}
\renewcommand{\postnotedelim}{\addcolon}
\DeclareDelimFormat{postnotedelim}{\addcolon}

% ---- Two authors: 'and' in text, '&' in parentheses ----
\renewcommand*{\finalnamedelim}{\addspace\&\addspace}               % parentheses
\DeclareDelimFormat{textcitedelim}{\addspace\bibstring{and}\addspace} % running text
\DeclareDelimFormat{compcitedelim}{\addspace\&\addspace}
\renewcommand*{\nameyeardelim}{\addcomma\space}                     % comma before year

% ---- Remove italics from all titles ----
\DeclareFieldFormat{title}{#1\isdot}
\DeclareFieldFormat{booktitle}{#1\isdot}
\DeclareFieldFormat{journaltitle}{#1}
\DeclareFieldFormat[article]{title}{#1}
\DeclareFieldFormat[incollection]{title}{#1}
\DeclareFieldFormat[thesis]{title}{#1}
\DeclareFieldFormat[book]{title}{#1}

% ---- Journal article: Volume(Issue):Pages (colon, no period) ----
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
% Remove period before pages, replace with colon
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

% ---- Thesis: "Unpublished" + type + institution + location (no date) ----
\renewbibmacro*{institution+location+date}{%
	\printtext{Unpublished }%
	\printfield{type}%
	\setunit{\addcomma\space}%
	\printlist{institution}%
	\setunit{\addcomma\space}%
	\printlist{location}%
	% No date
}

% ---- Books: Place: Publisher. (no date) ----
\renewbibmacro*{publisher+location+date}{%
	\printlist{location}%
	\iflistundef{publisher}
	{\setunit*{\addcomma\space}}
	{\setunit*{\addcolon\space}}%
	\printlist{publisher}%
	\setunit*{\addperiod\space}%
	% No date
}

% ---- Online sources: URL + [access date] ----
\DeclareFieldFormat{urldate}{\mkbibbrackets{#1}}
\renewbibmacro*{url+urldate}{%
	\iffieldundef{year}{\printtext{n.d.}}{}%
	\setunit{\addspace}%
	\printfield{url}%
	\setunit{\addspace}%
	\printfield{urldate}%
}
\DeclareFieldFormat{url}{\url{#1}}

% ---- Newspaper: page:note (note contains date) ----
\renewbibmacro*{note+pages}{%
	\printfield{pages}%
	\setunit{\addcolon\space}%
	\printfield{note}%
}

% ---- General punctuation ----
\setlength{\bibitemsep}{\baselineskip}
\renewcommand*{\bibrangedash}{-}
\renewcommand{\finentrypunct}{\addperiod}   % every reference ends with a period

% ---- Clean online entries (remove location/publisher) ----
\AtEveryBibitem{%
	\ifentrytype{online}
	{\clearlist{location}\clearlist{publisher}}
	{}%
	\clearfield{note}\clearfield{month}\clearfield{day}
}

% ---------- End of biblatex customisations ----------

\hypersetup{
	colorlinks=false,
	pdfborder={0 0 0},
	pdfcreator={LaTeX using cputthesis.cls}
}

\setstretch{1.5}
\setlength{\parindent}{0pt}
\setlength{\parskip}{0pt}
\setlength{\emergencystretch}{3em}
\setcounter{secnumdepth}{4}
\setcounter{tocdepth}{3}

\newcolumntype{Y}{>{\RaggedRight\arraybackslash}X}
\newcolumntype{R}{>{\raggedleft\arraybackslash}X}

% ----- Page styles -----
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

% ----- TOC formatting -----
\contentsmargin{0pt}
\dottedcontents{chapter}[2.5em]{\bfseries}{2.5em}{2pc}
\dottedcontents{section}[4.5em]{}{2.8em}{2pc}
\dottedcontents{subsection}[7.5em]{}{3.5em}{2pc}
\dottedcontents{subsubsection}[11.0em]{}{4.5em}{2pc}

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
	\addcontentsline{toc}{chapter}{Bibliography/References}%
}

\newcommand{\printcputbibliography}{%
	\clearpage
	\singlespacing
	\RaggedRight
	\printbibliography[heading=cputbibliography]%
	\clearpage
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

% ----- Title page (no page number) -----
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
	% Do NOT call \frontmatter here
}

% ----- Front matter environments -----
\newenvironment{declaration}{%
	\clearpage
	\thispagestyle{plain}
	\vspace{3.9cm}
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
	\cputfrontheading{ABSTRACT}
	\setstretch{1.5}
}{%
	\clearpage
}

\newenvironment{acknowledgements}{%
	\clearpage
	\thispagestyle{plain}
	\cputfrontheading{ACKNOWLEDGEMENTS}
	\setstretch{1.5}
}{%
	\clearpage
}

\newenvironment{dedication}{%
	\clearpage
	\thispagestyle{plain}
	\cputfrontheading{DEDICATION}
	\setstretch{1.5}
}{%
	\clearpage
}

\newenvironment{cputglossary}{%
	\clearpage
	\thispagestyle{plain}
	\cputfrontheading{GLOSSARY}
	\setstretch{1.5}
}{%
	\clearpage
}

% ----- Automatic TOC, LOF, LOT -----
\renewcommand{\tableofcontents}{%
	\clearpage
	\thispagestyle{plain}
	\cputfrontheading{TABLE OF CONTENTS}
	\@starttoc{toc}%
	\clearpage
}

\renewcommand{\listoffigures}{%
	\clearpage
	\thispagestyle{plain}
	\cputfrontheading{LIST OF FIGURES}
	\@starttoc{lof}%
	\clearpage
}

\renewcommand{\listoftables}{%
	\clearpage
	\thispagestyle{plain}
	\cputfrontheading{LIST OF TABLES}
	\@starttoc{lot}%
	\clearpage
}

% ----- Manual TOC (legacy) -----
\newcommand{\cputmanualtocline}[3]{%
	\noindent
	\makebox[2.2cm][l]{#1}%
	\makebox[\dimexpr\linewidth-3.5cm\relax][l]{#2\leaders\hbox to .6em{\hss.\hss}\hfill}%
	\makebox[1.3cm][r]{#3}\par
}

\newcommand{\cputmanualcontents}{%
	\cputfrontheading{TABLE OF CONTENTS}
	\singlespacing
	If you are an accomplished user of Microsoft Word, you can type your thesis using STYLES, and generate an automatic Table of Contents. If not, use the template below. This gives you an indication of section and sub-section numbering. Do the Table of Contents right at the end, otherwise you will have to update it continuously. If you are typing each chapter in a separate file, you might find it easier to collate the final thesis if you number your pages according to each chapter, e.g., in Chapter 3, your page numbers will be 3-1, 3-2, 3-3, etc. In Chapter 4 your page numbers will be 4-1, 4-2, 4-3, 4-4, etc.
	\vspace{10pt}
	Make sure that your headings are exactly the same as those in the text (use of sentence case and title case also). Sentence case is less confusing, easier to use and looks more modern and professional. Align page numbers on the right. Use single line-spacing.
	\vspace{16pt}
	\cputmanualtocline{}{Declaration}{ii}
	\cputmanualtocline{}{Abstract}{iii}
	\cputmanualtocline{}{Acknowledgements}{iv}
	\cputmanualtocline{}{Dedication}{v}
	\cputmanualtocline{}{Glossary}{viii}
	\clearpage
	{\bfseries CHAPTER ONE: TYPE THE TITLE HERE}\par
	\vspace{8pt}
	\cputmanualtocline{1.1}{Introduction}{1}
	\cputmanualtocline{1.1.1}{Heading: use sentence case, as in this example}{2}
	\cputmanualtocline{1.1.2}{Heading}{3}
	\cputmanualtocline{1.1.2.1}{Heading}{5}
	\cputmanualtocline{1.1.2.2}{Heading}{6}
	\vspace{18pt}
	{\bfseries CHAPTER TWO: TYPE THE TITLE HERE}\par
	\vspace{8pt}
	\cputmanualtocline{2.1}{Heading}{7}
	\cputmanualtocline{2.2}{Heading}{8}
	\cputmanualtocline{2.2.1}{Heading}{11}
	\cputmanualtocline{2.2.2}{Heading}{15}
	\vspace{18pt}
	Copy and paste the above for the rest of the chapters, changing the chapter and section numbers accordingly.
	\vspace{18pt}
	\cputmanualtocline{}{\bfseries BIBLIOGRAPHY/REFERENCES choose one}{150}
	\clearpage
	\vspace{18pt}
	{\bfseries LIST OF FIGURES (these are numbered according to the chapter in which they appear)}\par
	\vspace{8pt}
	\cputmanualtocline{}{Figure 4.1: Caption}{75}
	\cputmanualtocline{}{Figure 4.2: Caption}{82}
	\cputmanualtocline{}{Figure 5.1: Caption}{101}
	\vspace{18pt}
	{\bfseries LIST OF TABLES (these are numbered according to the chapter in which they appear)}\par
	\vspace{8pt}
	\cputmanualtocline{}{Table 4.1: Caption}{72}
	\cputmanualtocline{}{Table 4.2: Caption}{79}
	\cputmanualtocline{}{Table 5.1: Caption}{121}
	\vspace{18pt}
	\cputmanualtocline{}{\bfseries APPENDIX/APPENDICES}{160}
	(Choose one. If you have only one appendix, do not use Appendix A. List it as simply as Appendix.)
	\vspace{12pt}
	\cputmanualtocline{}{Appendix A: Caption}{161}
	\cputmanualtocline{}{Appendix B: Caption}{163}
	Add C, D, E, etc.
	\clearpage
}

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