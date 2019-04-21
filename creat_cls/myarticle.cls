%myarticle.cls
\ProvidesPackage{myarticle}[2018/12/22 v1.0]

\LoadClass[a4paper,11pt]{ctexart}
\RequirePackage{boldemph}[2018/12/12]

%《LaTeX入门（刘海洋）》P475
\AtEndDocument{
	\begin{center}
		\includegraphics{cust_logo.pdf}
	\end{center}
}
%《LaTeX入门（刘海洋）》P482
 \RequirePackage{keyval}
% 定义text族的emph选项，控制\emph命令的定义
\let\text@emph=\emph
\define@key{text}{emph}[\text@emph]{
	\let\emph=#1	
}
\newcommand\settext[1]{%
	\setkeys{text}{#1}
}

