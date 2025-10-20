@echo off
echo Compilando tesis...
pdflatex -interaction=nonstopmode main.tex
biber main
pdflatex -interaction=nonstopmode main.tex
pdflatex -interaction=nonstopmode main.tex
echo.
echo ========================================
echo Compilacion completa!
echo PDF generado: main.pdf
echo ========================================
pause
