$pdf_previewer = 'open -a Skim';
$pdflatex = 'pdflatex -synctex=1 -interaction=nonstopmode --shell-escape %O %S';
@generated_exts = (@generated_exts, 'synctex.gz');
$clean_ext = 'synctex.gz synctex.gz(busy) run.xml tex.bak bbl bcf fdb_latexmk run tdo %R-blx.bib'