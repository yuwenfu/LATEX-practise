
Contents
 =========================

<<About TpX drawing tool>>

<<TpX usage>>

<<TpX output formats>>

<<Export formats>>

<<Import>>

<<TpX primitives>>

<<LaTeX preamble>>

<<LaTeX figure environment>>

<<Using mouse for editing>>

<<TpX command line options>>

<<Preview>>

<<Some painting details>>

<<Adding TpX to WinEdt menu>>

<<Acknowledgements>>

<<Links>>

About TpX drawing tool
 =========================

TpX is a lightweight, easy-to-use graphical editor for Windows
platform for creation of drawings and inclusion them into LaTeX files
in publication-ready form. It can also be used as a stand-alone editor
for vector graphics.

The output is a file (with extension .TpX) containing the drawing as
LaTeX code or as an \includegraphics link to an external file created
by the program. User can choose between several <<output formats>>.
TpX saves its own data in TeX file comments so that the drawing could
be loaded into TpX and edited again. This internal TpX format is based
on XML and could be understood and edited easily.

TpX can <<import>> EMF/WMF pictures created by other Windows
applications, including many applications producing scientific graphs.
It also can import simple SVG pictures. In most cases the result is
nice, though sometimes imported picture needs some manual editing. So
TpX can be used as a EMF-to-any and SVG-to-any converter.

TpX usage
 =========================

TpX drawings are included in LaTeX files using \input{} command, like
\input{foo.TpX}.
It is necessary to use several LaTeX packages for TpX to be functional
(see <<LaTeX preamble>>). One can start from template document called
Template.tex in TpX distribution.

It is possible to keep TpX drawings in a subdirectory. The command in
LaTeX file would be
\input{mypics/foo.TpX}
if subdirectory name is mypics. Set IncludePath in TpX file to
mypics/.

TpX can also be used from command line without GUI. See <<TpX command
line options>>.

TpX output formats
 =========================

TpX provides several output formats. Use "Picture properties" to
change the format. The format is chosen separately for LaTeX and
PdfLaTeX.

Not all of the formats are ideal, so the choice needs thoughtful
consideration. EPS and PDF are TpX defaults for LaTeX/DVI and PdfLaTeX
respectively. Also recommended is PGF.

* LaTeX picture environment. This standard LaTeX environment is enhanced
 by epic.sty and bez123.sty LaTeX packages. Both packages are
 compatible with TeX/DVI and PdfLaTeX. The format is suitable for
 simple drawings only, because complicated drawings take a long time
 for TeX to translate and can cause memory shortage. Also, in general
 the result is poor.

* Encapsulated Postscript (EPS). The most popular format for advanced
 TeX graphics. EPS is saved as a separate file without text and is
 inserted into TpX file using \includegraphics command from graphicx
 LaTeX package. TpX surrounds \includegraphics command by picture
 environment to put text over the picture. Can not be used with
 PdfLaTeX.

* PDF. Included in TpX in the same fashion as EPS. Can only be used with
 PdfLaTeX, not LaTeX/DVI.

* PDF using EpsToPdf. PDF is created from EPS using EpsToPdf. Set the
 path to the program in "TpX Settings".

* PGF. PGF code is kept in LaTeX pgfpicture environment similar to
 picture environment. Requires pgf package. Compatible with both
 LaTeX/DVI and PdfLaTeX.

* PSTricks. PSTricks code is kept in TeX pspicture environment similar
 to picture environment. Requires pstricks package. Not compatible with
 PdfLaTeX.

* Metapost. Graphic language similar to pstricks, but an external file
 is created and an external MetaPost program is needed. Set the path to
 the program in "TpX Settings". Compatible with both LaTeX/DVI and
 PdfLaTeX. TeX is used to typeset text labels in MetaPost. This could
 be turned off by setting MetaPostTeXText to 0. Use metapost.tex.inc
 file to configure <<LaTeX preamble>>.

* Bitmap (PNG, BMP). Requires graphicx LaTeX package. Obviously, bitmap
 is not vector graphics, so it is not scalable. TpX does not use TeX to
 write text in bitmaps, so they can not incorporate TeX formulas. PNG
 is compatible with both LaTeX/DVI and PdfLaTeX. Currently BMP is not
 compatible with PdfLaTeX. Note that PNG is more compact than BMP so it
 is recommended. Currently bitmaps are not compatible with DVIPS and
 dvi2pdf; they are for DVI viewers only when used with LaTeX. Thus,
 bitmaps are most useful with PdfLaTeX.

* Enhanced Metafile (EMF). Can be used with LaTeX/DVI for preview (it is
 converted to bitmap for this purpose). Not compatible with PdfLaTeX.
 Recommended for export only.

* None. Set format to 'none' if you do not need output.

All TeX packages used are available from CTAN [http://www.ctan.org/].

See also <<Export formats>>

Export formats
 =========================

To import TpX drawing into some other program or publish it on the
Web, TpX export capabilites could be used ("Save as.." in "File"
menu). TpX can export to several formats. Note that files produced by
export can not incorporate TeX fonts and formulas (one exception is
MetaPost, which is TeX-aware).

* EPS. Type 1 fonts (.pfb) could be embedded. Set the path to a font in
 "TpX Settings".

* PDF. Currently font embedding is not implemented, so only Latin
 characters are supported.

* PDF using EpsToPdf. PDF is created from EPS using EpsToPdf. Set the
 path to the program in "TpX Settings".

* Scalable Vector Graphics (SVG). A promising Web vector graphics
 format. Needs a viewer. Several popular vector graphics editors like
 Corel Draw or Adobe Illustrator can read it.

* Bitmap (PNG, BMP). PNG is more compact and could be viewed in most
 modern Web browsers.

* Enhanced Metafile (EMF). Standard Windows vector format. It can also
 be copied to Windows clipboard and then pasted into some other program
 (like MS Word, PowerPoint, Adobe Illustrator).

* Metapost program.

* Metapost EPS output (MPS).

* LaTeX EPS (latex-dvips). EPS produced by running latex and dvips on
 TpX drawing. Attempt is made to ensure tight bounding box for the EPS.
 (Note: This export format is experimental. There are known problems
 with PGF.)

* LaTeX PDF (latex-dvips-epstopdf). The same as LaTeX EPS with
 additional run of epstopdf to produce PDF.

* LaTeX custom (latex-dvips-gs-<foo>). The same as LaTeX EPS with
 additional run of GhostScript to produce a custom image in a format
 supported by GhostScript. Set GhostscriptCustomKeys to change the
 device and resolution.

See also <<TpX output formats>>

Import
 =========================

TpX can import Enhanced Metafile (EMF), though not 100% correctly.
Under Windows most reasonable programs, which produce graphs, can
either export them as EMF files, or copy to clipboard as EMF. To
capture EMF from clipboard, use "Tools">"Capture EMF". EMF can also be
just pasted from clipboard (though this is not recommended if phisical
units must be preserved). TpX can also import old-style Windows
Metafiles (WMF).

Another TpX import format is Scalable Vector Graphics (SVG) based on
open international standard created by W3C [http://www.w3.org/]. As
the format is very rich TpX can understand only some basic subset of
it.

There is a possibility to use pstoedit utility to import EPS and PDF.
Set the path to the program in "TpX Settings". The utility could be
downloaded from http://pstoedit.com/.

TpX primitives
 =========================

Line (can include arrows)
Rectangle
Polyline
Polygon
Circle
Ellipse
Arc
Sector
Segment
Curve
Closed curve
Bezier path
Closed Bezier path
Text
Star
Symbol

LaTeX preamble
 =========================

This is a sample preamble to include in parent LaTeX file. It uses
ifpdf package to switch between two different modes of running
PdfLaTeX. (Download ifpdf from CTAN [http://www.ctan.org/] if you do
not have one).

\documentclass[a4paper,10pt]{article}
\usepackage{color}
%\pdfoutput=0 % uncomment this if running PdfTeX in TeX mode
\usepackage{ifpdf}
\ifx\pdftexversion\undefined %if using TeX
  \usepackage{graphicx}
\else %if using PdfTeX
  \usepackage[pdftex]{graphicx}
\fi
\ifpdf %if using PdfTeX in PDF mode
  \DeclareGraphicsExtensions{.pdf,.png,.mps}
  \usepackage{pgf}
\else %if using TeX or PdfTeX in TeX mode
  \usepackage{graphicx}
  \DeclareGraphicsExtensions{.eps,.bmp}
  \DeclareGraphicsRule{.emf}{bmp}{}{}% declare EMF filename extension
  \DeclareGraphicsRule{.png}{bmp}{}{}% declare PNG filename extension
  \usepackage{pgf}
  \usepackage{pstricks}%variant: \usepackage{pst-all}
\fi
\usepackage{epic,bez123}
\usepackage{floatflt}% package for floatingfigure environment
\usepackage{wrapfig}% package for wrapfigure environment

LaTeX figure environment
 =========================

Possible options for LaTeX figure environment are:

* no figure

* standard LaTeX figure environment

* floatingfigure from floatflt package

* wrapfigure from wrapfig package

Packages floatflt and wrapfig are available from CTAN
[http://www.ctan.org/]. Both implement floating figure.

Using mouse for editing
 =========================

TpX hot keys could be learned from the main menu. However, some
editing tasks could only be done with mouse. The list follows:

* Click object:  Select object (current selection would be lost)

* Shift-click object:  Add object to selection (current selection would
 be maintained)

* Double-click object:  Edit object properties

* Drag object:  Move object

* Drag control point:  Move control point of selected object to reshape
 it

* Ctrl-click object/control point:  Add/delete control point of selected
 object

* Wheel:  Move viewport vertically

* Shift-wheel:  Move viewport horizontally

* Ctrl-wheel:  Zoom viewport

* Alt-drag round control point of Bezier curve:   Determines whether the
 joint is kept smooth.

TpX command line options
 =========================

* -f, --file <file name> The name of input file (TpX, EMF, SVG, ...)

* -i, --texinput <LaTeX file> The name of parent LaTeX document

* -l, --texline <line number> The line number in parent LaTeX document

* -o, --output <file name> The name of output file

* -m, --format <format name>,<format name> The names of TpX <<output
 formats>> The formats are tex, pgf, pstricks, eps, png, bmp, metapost,
 emf, none for LaTeX/DVI and tex, pgf, pdf, png, metapost, epstopdf,
 none for PdfLaTeX.

* -x, --export <format name> The id of <<export format>>. The formats
 are svg, emf, eps, png, bmp, pdf, metapost, mps, epstopdf, latexeps,
 latexpdf, latexcustom.

-f option can be absent. Just run TpX as
TpX.exe <options> <file name>.

When output file is not specified with -o option, TpX chooses file
name automatically.

When -i -l options are used the parent TeX file is scanned for
\input{<filename>.TpX} line. The line closest to specified line is
chosen. This is useful for calling TpX from LaTeX editor like WinEdt.
(See <<Adding TpX to WinEdt menu>> on how to use this with WinEdt.)

In presence of -o and/or -x option TpX runs without GUI.

Examples:

TpX.exe foo.TpX
- open foo.TpX in TpX program, GUI

TpX.exe foo.TpX -o
- refresh foo.TpX, no GUI

TpX.exe foo.svg -x png
- import foo.svg and export it as png with name foo-export.png, no GUI

TpX.exe foo.TpX -o foofoo.TpX -m pgf,png
- load foo.TpX and save it as foofoo.TpX using pgf and png output
formats, no GUI

Preview
 =========================

TpX drawing can be previewed in many formats. It can be previewed as a
part of LaTeX document (see <<TpX output formats>>) or as a stand-
alone image (see <<Export formats>>).

Stand-alone image is just exported and opened by default program
associated with image extension. Temporary LaTeX document is produced
using one of the following sequences:

* LaTeX -> DVI

* LaTeX -> DVI -> PS

* PdfLaTeX -> PDF

<<LaTeX preamble>> is taken from the preview.tex.inc file. Use "TpX
settings" to set paths to the tools (LaTeX, PdfLaTeX, DVIPS) and
viewers needed.

Make sure that all relevant packages are included in LaTeX preamble.
For example, if you use AMS fonts, put
\usepackage[psamsfonts]{amssymb} to the preamble. Do not forget to
include language and encoding stuff as needed. For example,

\usepackage[english,russianb]{babel}
\usepackage[cp1251]{inputenc}

Some painting details
 =========================

Line join. Currently TpX uses only "miter line join" (not "bevel join"
or "round join").

Miter limit. Used to cut off too long spike miter join could have when
the angle between two lines is sharp. If the ratio of miter length
(distance between the outer corner and the inner corner of the miter)
to line width is greater than miter limit, then bevel join is used
instead of miter join. Default value of miter limit is 10. This option
is not applicable to LaTeX-picture and PsTricks formats.

Line cap. Currently TpX uses only "butt" line caps.

Fill rule. Currently TpX uses only "nonzero winding" fill rule (as
opposed to "even-odd" aka "alternate").

References:

* Scalable Vector Graphics (SVG) Specification by W3C
 http://www.w3.org/TR/SVG/

* PostScript Language Reference by Adobe Systems ("Red Book")
 http://www.adobe.com/products/postscript/resources.html

Adding TpX to WinEdt menu
 =========================

* Edit TpX_menu.dat, replacing Path_to_TpX by the actual path to TpX.exe

* Start "Macros">"Execute Macro..."

* Choose install_TpX.edt

Default keyboard shortcut is Alt+P. You can change this in
"Options">"Menu Setup">"Tools">"TpX drawing tool"

Typing Alt+P in a TeX document with included TpX drawings will run
TpX.exe and load a drawing into it. The drawing closest to the current
cursor position will be opened. The TpX file containing drawing need
not exist.

WinEdt [http://www.winedt.com] is a powerful editor and shell for TeX
documents.

Acknowledgements
 =========================

Modules used in TpX:

  CADSYS 4.0
  Copyright (c) 2001 Piero Valagussa
  pivalag[@@@]tin.it

  Graphics32 library
  Copyright (c) 2000-2004 Alex Denisov and Contributors
  http://graphics32.org

  PowerPdf library
  Takeshi Kanno
  takeshi_kanno[@@@]est.hi-ho.ne.jp

  XML library
  Copyright (c) 2002 Ravil Batyrshin, Mikhail Vlasov (Aravil Software)
  http://www.torry.net/vcl/internet/html/mvrbxmlparsers.zip

  PNG Component
  Copyright (c) Gustavo Huffenbacher Daud,
  http://pngdelphi.sourceforge.net
  gubadaud[@@@]terra.com.br

  HTML Help Kit for Delphi,
  Copyright (c) 1999 The Helpware Group
  support[@@@]helpware.net
  http://www.helpware.net

  MD5 Message-Digest for Delphi
  Copyright (c) 1997-1999 Medienagentur Fichtner & Meyer
  Written by Matthias Fichtner
  http://www.fichtner.net/delphi/md5.delphi.phtml

  StitchSAX 1.1 - Trivial SAX parser for Delphi
  Copyright (c) 2002, Roman Poterin
  poterin[@@@]mail.ru

Links
 =========================

Some links to similar and related programs

  jPicEdt
  http://www.jpicedt.org/

  Xfig
  http://www.xfig.org/

  WinFIG
  http://user.cs.tu-berlin.de/~huluvu/WinFIG.htm

  Metagraf
  http://w3.mecanica.upm.es/metapost/metagraf.php

  Ipe
  http://ipe.compgeom.org/

  Mayura Draw
  http://www.mayura.com/

  Graphics Layout Engine
  http://glx.sourceforge.net/

  LaTeXPiX
  http://members.home.nl/nickvanbeurden/latexpix.htm

  TeXCAD
  http://homepage.sunrise.ch/mysunrise/gdm/texcad.htm

  TeXCad32
  http://www.gelbes-rechenbuch.de/Texcad32/Index_e.html

  ePiX
  http://mathcs.holycross.edu/~ahwang/software/epix_html/

  OLETeX Utility
  http://oletex.sourceforge.net/

  pstoedit
  http://www.pstoedit.net/

-------------------------------
TpX 1.3 readme file
Generated 2006-05-22 16:21:08
