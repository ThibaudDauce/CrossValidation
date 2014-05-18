all : compilSuivi compilSoutenance clean
compilSuivi : suivi.pdf
compilSoutenance : soutenance.pdf

suivi.pdf : suivi.tex
	pdflatex -shell-escape suivi.tex; pdflatex -shell-escape suivi.tex
soutenance.pdf : soutenance.tex
	pdflatex -shell-escape soutenance.tex; pdflatex -shell-escape soutenance.tex

clean :
	rm soutenance.aux soutenance.log soutenance.maf soutenance.mtc* soutenance.out soutenance.toc soutenance.tex.* soutenance.pyg soutenance.snm soutenance.nav
	rm suivi.aux suivi.log suivi.maf suivi.mtc* suivi.out suivi.toc suivi.tex.* suivi.pyg suivi.snm suivi.nav
