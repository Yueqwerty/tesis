@echo off
echo Compilando tesis...
pdflatex -interaction=batchmode main.tex
pdflatex -interaction=batchmode main.tex
pdflatex -interaction=nonstopmode main.tex
echo Listo!
