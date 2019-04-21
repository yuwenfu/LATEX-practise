%---------------------------------------------------------------------------%
%-                                                                         -%
%-                           Document Class                                -%
%-                                                                         -%
%---------------------------------------------------------------------------%
%---------------------------------------------------------------------------%
%->> Identification
%---------------------------------------------------------------------------%
\NeedsTeXFormat{LaTeX2e}%
\ProvidesClass{custthesis}[2018/12/12 v1.0 LaTeX document class]%
%---------------------------------------------------------------------------%
%->> Declare options
%---------------------------------------------------------------------------%
%-
%-> Layout
%-
\newif\ifcust@singlesided \cust@singlesidedfalse
\DeclareOption{singlesided}{% enable single-sided printing
    \cust@singlesidedtrue%
}
\newif\ifcust@doublesided \cust@doublesidedfalse
\DeclareOption{doublesided}{% enable double-sided printing
    \cust@doublesidedtrue%
}
\newif\ifcust@printcopy \cust@printcopyfalse
\DeclareOption{printcopy}{% enable print copy layout
    \cust@doublesidedtrue% auto enable double-sided style
    \cust@printcopytrue%
}
%---------------------------------------------------------------------------%
%-> Draft version info
%---------------------------------------------------------------------------%
\newif\ifcust@versioninfo \cust@versioninfofalse
\DeclareOption{draftversion}{%
    \cust@versioninfotrue%
}
%---------------------------------------------------------------------------%
%-> Handle non-implemented options
%---------------------------------------------------------------------------%
\DeclareOption*{%
    \PassOptionsToClass{\CurrentOption}{ctexbook}%
}
%---------------------------------------------------------------------------%
%-> Terminates all options processing
%---------------------------------------------------------------------------%
\ProcessOptions\relax%
%---------------------------------------------------------------------------%
%->> Load class information
%---------------------------------------------------------------------------%
\ifcust@doublesided% if double-sided printing enabled
    \LoadClass[UTF8,a4paper,twoside,zihao=-4]{ctexbook}
\else% if double-sided printing isn't enabled
    \LoadClass[UTF8,a4paper,oneside,zihao=-4]{ctexbook}
\fi
%---------------------------------------------------------------------------%
%->> Required packages
%---------------------------------------------------------------------------%
\RequirePackage{ifxetex}% LaTeX engine detection
\RequirePackage{etoolbox}% a toolbox of programming facilities
\newcommand{\custifstreq}{\expandafter\ifstrequal\expandafter}% expansion control
\newcommand{\custifstrbk}{\expandafter\ifblank\expandafter}% expansion control

\RequirePackage{lipsum} %test word
%---------------------------------------------------------------------------%
%->> Load class configuration
%---------------------------------------------------------------------------%
\AtEndOfPackage{% class cfg loaded after package to make preamble commands take effect
    \makeatletter
    \InputIfFileExists{Style/custthesis.cfg}{}{}
    \makeatother
}
%---------------------------------------------------------------------------%
%->> Page layout
%---------------------------------------------------------------------------%
%detail can see in doc fancyhdr page3(cmd:texdoc fancyhdr)
%- part one -- horizontal widths

%- left side width + textwidth + right side width = paperwidth
%- binding side width + textwidth + nonbinding side width = paperwidth
%- binding side width of [odd, even] page = [left, right] side width
%- left side width of [odd, even] page = 1.0in (fixed) + hoffset + [odd, even]sidemargin
%- assuming A4 paper (210mm x 297mm)
\setlength{\textwidth}{146.6mm}% set required text width first
\setlength{\hoffset}{0mm}% set horizontal offset
\ifcust@printcopy% if print copy layout enabled
    \setlength{\oddsidemargin}{12.6mm}% binding side margin
    \setlength{\evensidemargin}{0mm}% ensure uniform binding side width for printing
\else
    \setlength{\oddsidemargin}{6.3mm}% left side margin
    \setlength{\evensidemargin}{6.3mm}% ensure uniform left side width for EThesis
\fi
\setlength{\marginparwidth}{35pt}% width of margin notes
\setlength{\marginparsep}{10pt}% width of space between body text and margin notes

%- part two -- vertical heights

%- top height + textheight + bottom height = paperheight
%- top height = 1.0in (fixed) + voffset + topmargin + headheight + headsep 
\setlength{\textheight}{246.2mm}% set required text height first
%\setlength{\voffset}{-17.4mm}% set vertical offset
\setlength{\voffset}{0mm}% set vertical offset
\setlength{\topmargin}{20pt}% vertical margin above header
\setlength{\headheight}{12pt}% header height
\setlength{\headsep}{17.5pt}% vertical margin between header and body text
\setlength{\footskip}{29.5pt}% vertical margin between footer and body text

%- specifies the amount of space between paragraphs.
\setlength{\parskip}{0.5ex plus 0.25ex minus 0.25ex}

%- line spacing
\linespread{1.25}% line space setting %控制全局行间距
\raggedbottom% prevent adding vertical white space in strange places  ??

%- default pagestyle is page number at bottom without headers and footers
\pagestyle{plain}
%---------------------------------------------------------------------------%
%->> Style control commands
%---------------------------------------------------------------------------%
%- redefine cleardoublepage to have page style argument
\renewcommand{\cleardoublepage}[1][plain]{%
    \clearpage
    \if@twoside
	    \ifodd
	    	\c@page
		\else%
		   	\thispagestyle{#1}%
		   	\hbox{}\newpage
		  	 \if@twocolumn
		  	 \hbox{}\newpage
		  	 \fi
	    \fi
    \fi%
}
%- underline
\ifxetex% use underline from xeCJKfntef
    \renewcommand{\CJKunderlinecolor}{\color[rgb]{0,0,0}}% set underline color
    \renewcommand{\uline}[1]{\CJKunderline{#1}}% unified name
\else% use underline from ulem
    \RequirePackage{ulem}%
\fi
\newcommand{\ulenhance}[2][1pt]{% enhanced underline
    \def\ULthickness{#1}% set thickness
    \uline{#2}}
%\newcommand{\ulhshift}{-4em}% horizontal shift on underline
%\newcommand{\ulextend}[2][350pt]{% extend underline length
%	\hbox to #1{\hfill\hspace*{\ulhshift}#2\hfill}}
\newcommand{\ulhshift}{0em}% horizontal shift on underline
\newcommand{\ulextend}[2][250pt]{% extend underline length
    \hbox to #1{\hfill\hspace*{\ulhshift}#2\hfill}}
%---------------------------------------------------------------------------%
%->> Titlepage
%---------------------------------------------------------------------------%
%-
%-> Chinese item commands
%-
\def\cust@value@confidential{}  %定义密文
\newcommand{\confidential}[1]{\def\cust@value@confidential{#1}}
\def\cust@value@schoollogo{}  %校徽
\newcommand{\schoollogo}[2]{\def\cust@value@schoollogo{\includegraphics[#1]{#2}}}
\def\cust@value@title{} % 论文中文题目
\def\cust@value@titlemark{}
\renewcommand{\title}[2][\cust@value@title]{%
    \def\cust@value@title{#2}
    %\def\cust@value@titlemark{\MakeUppercase{#1}}}
    \def\cust@value@titlemark{#1}}
\renewcommand{\@title}{\cust@value@titlemark}
\def\cust@value@author{} % 论文作者
\renewcommand{\author}[1]{\def\cust@value@author{#1}} % 指导老师附加信息 或 第二指导老师信息
\def\cust@value@advisor{}
\newcommand{\advisor}[1]{\def\cust@value@advisor{#1}}
\def\cust@value@advisorsec{}
\newcommand{\advisorsec}[1]{\def\cust@value@advisorsec{#1}}
\def\cust@value@degree{}	% 学位：学士、硕士、博士
\newcommand{\degree}[1]{\def\cust@value@degree{#1}}
\def\cust@value@degreetype{} % 学位类别：理学、工学、工程、医学等
\newcommand{\degreetype}[1]{\def\cust@value@degreetype{#1}}
\def\cust@value@major{}	% 二级学科专业名称
\newcommand{\major}[1]{\def\cust@value@major{#1}}
\def\cust@value@institute{} % 院系名称
\newcommand{\institute}[1]{\def\cust@value@institute{#1}}
\def\cust@value@chinesedate{}	% 毕业日期：夏季为6月、冬季为12月
\newcommand{\chinesedate}[1]{\def\cust@value@chinesedate{#1}}
\def\cust@value@studentnumber{}	%学号
\newcommand{\studentnumber}[1]{\def\cust@value@studentnumber{#1}}
%-
%-> Redefine Chinese style
%-
\renewcommand{\maketitle}{%
	%学士封面设置
    \custifstreq{\cust@value@englishdegree}{Bachelor}{%如果字符相等
        \def\cust@label@thesis{\cust@label@bacthesis}%
        \def\cust@label@major{\cust@label@ungradmajor}%
        \def\cust@label@institute{\cust@label@ungradinstitute}%
    }{%
    %硕士封面设置
    \custifstreq{\cust@value@englishdegree}{Master}{%
        \def\cust@label@thesis{\cust@label@masthesis}%
        \def\cust@label@major{\cust@label@gradmajor}%
        \def\cust@label@institute{\cust@label@gradinstitute}%
    }{%
    %博士封面设置
        \def\cust@label@thesis{\cust@label@docthesis}%
        \def\cust@label@major{\cust@label@gradmajor}%
        \def\cust@label@institute{\cust@label@gradinstitute}%
    }}%

	%封面布局设置
    \cleardoublepage
    \thispagestyle{empty}
    %显示右上角的编号
    \begin{flushleft}
    	{\zihao{-4}\bfseries \cust@label@number\ulenhance[1.2pt]{\qquad \qquad}}
    \end{flushleft}
    \begin{center}
        \linespread{1.5}
        \zihao{4}\bfseries
        
	%密文显示设置
        \hfill{} \custifstrbk{\cust@value@confidential}{}{\cust@label@confidential \ulenhance{\ulextend[50pt]{\hspace*{-\ulhshift}\zihao{5}\cust@value@confidential}}}

        \vspace*{\stretch{4}}
	%载入学校logo
        {\cust@value@schoollogo}

        \vspace*{\stretch{4}}
	%**学位论文
        {\zihao{1}\bfseries\sffamily {\cust@label@thesis}}

        \vspace*{\stretch{5}}
	%论文题目显示
        {\zihao{-3}\bfseries\sffamily \ulenhance[1.5pt]{\ \cust@value@title\ }}

        \vspace*{\stretch{7}}

        \def\tabcolsep{1pt}
        \def\arraystretch{1.3} %若是简单调整行距，则可以在插入表格前添加一行这样的命令
        \begin{tabular}{cc}
            \cust@label@author & \ulenhance[1.2pt]{\ulextend{\cust@value@author}}\\ %作者姓名
            \cust@label@major & \ulenhance[1.2pt]{\ulextend{\cust@value@major}}\\ %专业
            \cust@label@studentnumber & \ulenhance[1.2pt]{\ulextend{\cust@value@studentnumber}}\\ %学生学号
            \cust@label@advisor & \ulenhance[1.2pt]{\ulextend{\cust@value@advisor}}\\%指导老师
           % & \ulenhance[1.2pt]{\ulextend{\cust@value@advisorsec}}\\ %第二指导老师
            %\cust@label@degree & \ulenhance[1.2pt]{\ulextend{\cust@value@degreetype\cust@value@degree}}\\%学位类别
            \cust@label@institute & \ulenhance[1.2pt]{\ulextend{\cust@value@institute}}\\ %学院（系）
        \end{tabular}

        \vspace*{\stretch{4.5}}
		%毕业时间
        {\cust@value@chinesedate}

        \vspace*{\stretch{3.5}}
    \end{center}
    \clearpage
    \if@twoside
        \thispagestyle{empty}
        \ifcust@versioninfo
            \vspace*{\stretch{1}}
            \begin{footnotesize}
                \noindent
                Draft Version (\today)
            \end{footnotesize}
        \fi
        \cleardoublepage[empty]
    \else
        \ifcust@versioninfo
            \thispagestyle{empty}
            \vspace*{\stretch{1}}
            \begin{footnotesize}
                \noindent
                Draft Version (\today)
            \end{footnotesize}
            \cleardoublepage[empty]
        \fi
    \fi
}
%-
%-> English item commands
%-
\def\cust@value@englishtitle{}
\newcommand{\englishtitle}[1]{\def\cust@value@englishtitle{#1}}
\def\cust@value@englishauthor{}
\newcommand{\englishauthor}[1]{\def\cust@value@englishauthor{#1}}
\def\cust@value@englishadvisor{}
\newcommand{\englishadvisor}[1]{\def\cust@value@englishadvisor{#1}}
\def\cust@value@englishdegree{}
\newcommand{\englishdegree}[1]{\edef\cust@value@englishdegree{\zap@space#1 \@empty}}% expand and remove space
\def\cust@value@englishdegreetype{}
\newcommand{\englishdegreetype}[1]{\def\cust@value@englishdegreetype{#1}}
\def\cust@value@englishthesistype{}
\newcommand{\englishthesistype}[1]{\def\cust@value@englishthesistype{#1}}
\def\cust@value@englishmajor{}
\newcommand{\englishmajor}[1]{\def\cust@value@englishmajor{#1}}
\def\cust@value@englishinstitute{}
\newcommand{\englishinstitute}[1]{\def\cust@value@englishinstitute{#1}}
\def\cust@value@englishdate{}
\newcommand{\englishdate}[1]{\def\cust@value@englishdate{#1}}
%-
%-> Redefine English style
%-
\newcommand{\makeenglishtitle}{%
    \cleardoublepage
    \thispagestyle{empty}
    \begin{center}
        \linespread{1.5}
        \zihao{4}\bfseries

        \vspace*{50pt}

        {\zihao{-3}\bfseries \ulenhance[1.5pt]{\ \cust@value@englishtitle\ }}

        \vspace*{\stretch{2}}

        {\cust@label@englishstatement}

        {By}

        {\cust@value@englishauthor}

        {\cust@value@englishadvisor}

        \vspace*{\stretch{3}}

        {\cust@value@englishinstitute}

        \vspace*{\stretch{1}}

        {\cust@value@englishdate}

        \vspace*{\stretch{3}}
    \end{center}
    \clearpage
    \if@twoside
      \thispagestyle{empty}
      \cleardoublepage[empty]
    \fi
}
%---------------------------------------------------------------------------%
%->> Author's declaration
%---------------------------------------------------------------------------%

%学位论文原创性声明
\newcommand{\makedeclaration}{%
    \cleardoublepage
    \thispagestyle{empty}
    {
        \linespread{1.5}
        \zihao{-4}

        \vspace*{2ex}

        \begin{center}
            {\zihao{4}\bfseries\sffamily \cust@value@declare@create}
        \end{center}

        {\cust@value@declare@creativity}

        \vspace*{3ex}
%作者签名
        { \hfill{}{\cust@value@declare@s \hspace*{14em}}}
%声明日期

        {\hfill{}{\cust@value@declare@d \hspace*{14em}} }

        \vspace*{6ex}
%学位论文授权使用声明
        \begin{center}
            {\zihao{4}\bfseries\sffamily \cust@value@declare@right}
        \end{center}

        {\cust@value@declare@rights}

        {\cust@value@declare@rule}

        \vspace*{3ex}

%作者签名  导师签名
        {\hfill{} {\cust@value@declare@s \hspace*{10em} \cust@value@declare@t \hspace*{9em}}}
		
%日期 日期
        {\hfill{} {\cust@value@declare@d \hspace*{10em} \cust@value@declare@d \hspace*{9em}}}

        \vspace*{3ex}
    }
    \clearpage
    \if@twoside
        \thispagestyle{empty}
        \cleardoublepage[empty]
    \fi
}
%---------------------------------------------------------------------------%
%->> New environments
%---------------------------------------------------------------------------%
%- define chinese keywords
\newcommand{\keywords}[1]{%
    \vspace{\baselineskip}
    \noindent {\bfseries \cust@label@keywords} #1}
%- define engish keywords
\newcommand{\englishkeywords}[1]{%
    \vspace{\baselineskip}
    \noindent {\bfseries \cust@label@englishkeywords} #1}
%---------------------------------------------------------------------------%
%->> Configure table of contents
%---------------------------------------------------------------------------%
%- define spacing and length
\def\@dotsep{1.5mu}% spacing for dots
\def\@pnumwidth{2em}% spacing between titles and page numbers
\def\@tocrmarg{2em}% right margin indentation
\def\@chaptervspace{1ex}% spacing between chapter titles
%- redefine dottedtocline from classes.dtx and latex.ltx
\renewcommand*{\@dottedtocline}[5]{% [<level>,<indent>,<numwidth>,<title>,<page>]
    \ifnum #1>\c@tocdepth \else
        \vskip \z@ \@plus.2\p@
        {\leftskip #2\relax \rightskip \@tocrmarg \parfillskip -\rightskip
        \parindent #2\relax\@afterindenttrue
        \interlinepenalty\@M
        \leavevmode \zihao{-4}\sffamily
        \@tempdima #3\relax
        \advance\leftskip \@tempdima \null\nobreak\hskip -\leftskip
        {#4}\nobreak
        \leaders\hbox{$\m@th\mkern \@dotsep \cdot\mkern \@dotsep$}\hfill
        \nobreak
        \hb@xt@\@pnumwidth{\hfil\normalfont \normalcolor #5}%
        \par\penalty\@highpenalty}%
    \fi
}
%- redefine l@part from book.cls to add dotted toc line
\renewcommand*{\l@part}[2]{% [<title>,<page>]
    \ifnum \c@tocdepth >-2\relax
        \addpenalty{-\@highpenalty}%
        \addvspace{2.25em \@plus\p@}%
        \setlength\@tempdima{3em}%
        \begingroup
            \parindent \z@ \rightskip \@pnumwidth
            \parfillskip -\@pnumwidth
            {\leavevmode
            \zihao{4}\sffamily #1
            \leaders\hbox{$\m@th\mkern \@dotsep \cdot\mkern \@dotsep$}% add dotted toc line
            \hfil \hb@xt@\@pnumwidth{\hss #2}}\par
            \nobreak
            \global\@nobreaktrue
            \everypar{\global\@nobreakfalse\everypar{}}%
        \endgroup
    \fi
}
%- redefine l@chapter from book.cls to add dotted toc line
\renewcommand*{\l@chapter}[2]{% [<title>,<page>]
    \ifnum \c@tocdepth >\m@ne
        \addpenalty{-\@highpenalty}%
        \vskip \@chaptervspace \@plus\p@
        \setlength\@tempdima{1.5em}%
        \begingroup
            \parindent \z@ \rightskip \@pnumwidth
            \parfillskip -\@pnumwidth
            \leavevmode \zihao{4}\sffamily
            \advance\leftskip\@tempdima
            \hskip -\leftskip
            #1\nobreak
            \leaders\hbox{$\m@th\mkern \@dotsep \cdot\mkern \@dotsep$}% add dotted toc line
            \hfil \nobreak\hb@xt@\@pnumwidth{\hss #2}\par
            \penalty\@highpenalty
        \endgroup
    \fi
}
%---------------------------------------------------------------------------%
\endinput

