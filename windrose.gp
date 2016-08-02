### gnuplot script to create a windrose of loxodromes (courses)

if (!exists("datafiles")) datafiles='default.dat' # http://gnuplot.sourceforge.net/docs_4.2/node60.html
if (!exists("outfile")) outfile='windrose.svg' # use ARG0."svg" for gp-5:  http://stackoverflow.com/questions/12328603/how-to-pass-command-line-argument-to-gnuplot#31815067
if (!exists("cL")) cL='loxodrome' # http://stackoverflow.com/questions/16089301/how-do-i-set-axis-label-with-column-header-in-gnuplot#18309074
if (!exists("cS")) cS='location'
if (!exists("r")) r=1
if (!exists("sep")) sep="\t"

set datafile separator sep

d1= word(datafiles,1)

set size ratio -1
set xrange [-1.1:1.1]
set yrange [-1.1:1.1]

unset border
unset xtics
unset ytics

set terminal svg enhanced font "sans,10" size 1024,1024 #don't use: courier or arial
set output outfile

## http://www.gnuplotting.org/vector-field-from-data-file/
xf(phi) = r*cos(pi/2-phi/180.0*pi) # rotate left from north
yf(phi) = r*sin(pi/2-phi/180.0*pi)

plot \
     d1 u (0):(0):(xf(column(cL))):(yf(column(cL))) with vectors head size 0.05,15,60 filled lc 'black' , \
     "" u (xf(column(cL))):(yf(column(cL))):cS with labels left # offset 10 rotate by column(cL)
