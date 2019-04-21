\LoadClass{article}
\RequirePackage{xeCJK}
\RequirePackage{ctex}
\RequirePackage{graphicx}
\RequirePackage{geometry}
\RequirePackage{titlesec}
\RequirePackage{fancyhdr}
\RequirePackage{enumitem}
\RequirePackage{listings}
\RequirePackage{xcolor}
\RequirePackage{fancybox}
\RequirePackage{caption}
\RequirePackage[plain]{fancyref}	%设置引用格式
\RequirePackage{lastpage}	%设置页脚页码格式
\RequirePackage{amsmath}
\RequirePackage{multirow} %用于表格合并行

\RequirePackage{booktabs}%普通三线表
\RequirePackage{makecell} %\Xcline{2-14}{0.4pt} \Xhline

\linespread{1.25}
\geometry{a4paper,top=1in,bottom=1in,left=0.5in,right=0.5in,headsep=0.1in}
\setcounter{secnumdepth}{2}
\renewcommand\thesection{\chinese{section}、}
\renewcommand\thesubsection{\arabic{subsection}.}
\renewcommand\thesubsubsection{(\arabic{subsubsection})}
\newCJKfontfamily[song]\song{SimSun}[AutoFakeBold]


% \setmainfont{CMU Serif}
\setmonofont{Lucida Console}
\setsansfont{SimHei}
\titleformat*{\section}{\large\bfseries}
\titleformat*{\subsection}{\normalsize\bfseries}
\titleformat*{\subsubsection}{\normalsize}
\graphicspath{{figures/}{figure/}{pictures/}%
{picture/}{pic/}{pics/}{image/}{images/}}

\titlespacing{\subsection}{2em}{*4}{*1.5}

\lstset{
  frame=tb,
  aboveskip=3mm,
  belowskip=3mm,
  xleftmargin=2em,
  xrightmargin=2em,
  showstringspaces=false,
  columns=flexible,
  framerule=1pt,
  rulecolor=\color{gray!35},
  backgroundcolor=\color{gray!5},
  basicstyle={\small\ttfamily},
  numbers=none,
  numberstyle=\tiny\color{gray},
  keywordstyle=\color{blue},
  commentstyle=\color{comment},
  stringstyle=\color{dkgreen},
  breaklines=true,
  breakatwhitespace=true,
  tabsize=2,
}

\usepackage{lastpage}
\pagestyle{fancy}
%这条代码针对第一页（只保留页脚页码）
\fancypagestyle{plain}{%
	\fancyhf{} % clear all header and footer fields
	\renewcommand{\headrulewidth}{0pt} 
	\fancyfoot[C]{
	\thepage\ of \pageref{LastPage} % except the center
	\renewcommand{\footrulewidth}{0pt}
	}
}

\fancyhead{}
\lhead{实验名称：\newtitle}
\chead{姓名：\name}
\rhead{学号：\stuid}
%这条代码针对除第一页的页码
\cfoot{\thepage\ of \pageref{LastPage}} 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%加页边框%%%%%%%%%%%%%%%%%
\fancypage{%
	\setlength{\fboxsep}{8pt}%
	\setlength{\fboxrule}{0.8pt}%
	\setlength{\shadowsize}{0pt}%
	\shadowbox}{}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%文件中可以有超链接的宏包并且可以为其设定样式
%\usepackage[colorlinks,linkcolor=red,anchorcolor=blue,citecolor=green]{hyperref} 


\newcommand{\degree}{^\circ}

%重新定义插入图片的格式
\newcommand{\addimagesml}[2]{
	\begin{figure}[!htb]
		\centering
		\includegraphics[width=0.5\linewidth,scale=1.5]{figures/#1}\caption{#2}\label{#1}
	\end{figure}
}
\newcommand{\addimagebig}[2]{
	\begin{figure}[!htb]
		\centering
		\includegraphics[width=0.8\linewidth,scale=1.5]{figures/#1}\caption{#2}\label{#1}
	\end{figure}
}%\addimage{fig_new_mode1}{The new model is listed}