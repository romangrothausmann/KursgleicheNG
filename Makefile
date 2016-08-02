#### MF to call windrose.gp on processed CSV

.PHONY: all clean

all : windrose.svg

clean :
	-rm -v *.svg

%.tsv : %.csv
	iconv -f ISO-8859-1 -t UTF-8 $< | sed 's/,/./g;s/;/\t/g' > $@

%.svg : %.tsv
	gnuplot -e " datafiles='$<'; outfile='$@'; cL='Kurs g [°]'; "'sep="\t"' windrose.gp # sep needs to be in "" not ''!


# .SECONDARY:
