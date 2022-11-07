install:
	sudo pacman -S ghc cabal-install pandoc texlive-most plantuml pandoc-crossref 
	pip install matplotlib
	make pandoc-plot

pdf:
	@pandoc README.md \
		--pdf-engine=lualatex \
		--metadata-file=metadata.yaml --mathjax \
        	-F pandoc-plot \
	        -F pandoc-crossref --citeproc \
		--highlight-style vendor/pygments.theme \
		--template=plantilla --pdf-engine-opt=-shell-escape \
		-s --toc --toc-depth=2 --number-sections --columns=80 \
		-o README.pdf

ppt:
	cp README.md docs/README.md 
	cp README.pdf docs/README.pdf
	marp -I docs/content -o docs && mv docs/ppt.html docs/index.html && marp -s docs

pandoc-plot:
	git clone https://aur.archlinux.org/pandoc-plot-bin.git
	cd ./pandoc-plot-bin;
	makepkg -si
	cd ../;
	rm pandoc-plot-bin -r


