### gnuplot script to create a windrose of loxodromes (courses)

if (GPVAL_VERSION < 5.1) {print "This script needs gnuplot-5.1\n"; exit;}

if (!exists("datafiles")) datafiles='default.dat' # http://gnuplot.sourceforge.net/docs_4.2/node60.html
if (!exists("outfile")) outfile='windrose.svg' # use ARG0."svg" for gp-5:  http://stackoverflow.com/questions/12328603/how-to-pass-command-line-argument-to-gnuplot#31815067
if (!exists("cL")) cL='loxodrome' # http://stackoverflow.com/questions/16089301/how-do-i-set-axis-label-with-column-header-in-gnuplot#18309074
if (!exists("cS")) cS='location'
if (!exists("r")) r=1
if (!exists("sep")) sep="\t"

set datafile separator sep

d1= word(datafiles,1)

set angle degrees
set size ratio -1
set xrange [-1.1:1.1]
set yrange [-1.1:1.1]

unset border
unset xtics
unset ytics

set terminal svg enhanced font "sans,10" size 1024,1024 #don't use: courier or arial
set output outfile

## http://www.gnuplotting.org/vector-field-from-data-file/
xf(phi,r) = r*cos(90-phi) # rotate left from north
yf(phi,r) = r*sin(90-phi)
ls(l,a) = sprintf("%s %.2f°", l, a)
rf(a) = 90-a

plot \
     d1 u (0):(0):(xf(column(cL), r )):(yf(column(cL), r )) with vectors head size 0.05,15,60 filled lc 'black' t '' , \
     "" u (xf(column(cL), r*0.94 )):(yf(column(cL), r*0.94 )):(ls(stringcolumn(cS),column(cL))):(rf(column(cL))) with labels right offset 0 rotate variable t '' # http://gnuplot.sourceforge.net/demo_cvs/rotate_labels.html
