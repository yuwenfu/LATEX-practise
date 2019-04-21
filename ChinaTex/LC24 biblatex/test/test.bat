@echo off

  call:document
  goto:EOF

:document
  echo building documents...
  xelatex -shell-escape *.tex
  biber  *.*
  xelatex -shell-escape *.tex
goto:EOF