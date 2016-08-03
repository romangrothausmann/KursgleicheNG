#### MF to call windrose.gp on processed CSV


#### ToDo
## rotate labels according to laxodrome angle
## awk script to calc laxodrome angles


.PHONY: all clean

all : windrose.svg

clean :
	-rm -v *.svg

%.tsv : %.csv
	iconv -f ISO-8859-1 -t UTF-8 $< | sed 's/,/./g;s/;/\t/g' > $@

%.tsv : %.krs # expecting *.krs in UTF-8
	echo "i	Ort	geogr. Breite	geogr. Länge	Land	Besonderheit	Lat. [°]	Lon. [°]	DLon. l [°]	Dist. e [°]	Dist. e [km]	Alpha a [°]	Kurs g [°]	sel" > $@
	dos2unix < $< | sed '1d;s/,/./g' | awk '{ printf "%s%s", $$0, (NR%14 != 0 ? "\t" : RS) }' >> $@

%.svg : %.tsv
	gnuplot -e " datafiles='$<'; outfile='$@'; cS='Ort'; cL='Kurs g [°]'; "'sep="\t"' windrose.gp # sep needs to be in "" not ''!


# .SECONDARY:
