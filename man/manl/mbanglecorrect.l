.TH mbanglecorrect l "14 February 1995"
.SH NAME
\fBmbanglecorrect\fP - Apply a grazing angle correction to beam
amplitude or sidescan data.

.SH VERSION
Version 4.2

.SH SYNOPSIS
\fBmbanglecorrect\fP [\fB-A\fIkind/scale\fP \fB-B\fIyr/mo/da/hr/mn/sc 
\fB-C\fP \fB-D\fImode/length\fP \fB-E\fIyr/mo/da/hr/mn/sc 
\fB-F\fIformat\fP \fB-G\fI\fP \fB-I\fIinfile\fP  \fB-N\fInangle/anglemax\fP
\fB-O\fIoutfile\fP \fB-R\fIwest/east/south/north\fP 
\fB-S\fIcorrectionfile\fP 
\fB-Z\fIdepth\fP \fB-V -H\fP]

.SH DESCRIPTION
The program mbanglecorrect is used for processing sidescan data.  
This program corrects the sidescan data by dividing by a model of the
backscatter vs grazing angle function to produce a flat image
which shows geology better than the raw data (each value is
also multiplied by a scale factor set with the \fB-A\fP option. 
The backscatter 
vs grazing angle model is either read from a file (global correction)
or obtained by averaging over the input sidescan data in some number 
of nearby pings (local correction) using the same 
algorithm as the program 
\fBmbbackangle\fP. If local correction is used, the user 
specifies the angular width of the swath considered and the 
number of angular bins in that swath which are used in 
calculating the local correction. When the correction model 
is defined using the entire
dataset the output data will predominantly show large scale
variability in seafloor reflectivity. When the model used to correct 
the data is locally defined, the output data will tend to show 
an enhanced view of local or fine scale structure, although
odd effects may occur at boundaries between different types
of seafloor. 
No assumption is made about the nature of the data or the sonar used to
collect it. If bathymetry data is available, then the acrosstrack
seafloor slope is taken into account when calculating grazing
angles, unless the \fB-G\fP option is used to force the
assumption of a flat seafloor (this pertains only to the application
of the grazing angle correction; seafloor slopes are always used,
if available, in calculating local grazing angle correction
functions). If bathymetry is
not available, the seafloor is assumed to be flat with a depth
specified by the \fB-Z\fP option. The use of bathymetric slopes
in the grazing angle calculations will tend to remove 
bathymetric signals from the data. 
The default input and output streams are stdin and stdout.\n";

.SH AUTHORSHIP
David W. Caress (caress@lamont.ldeo.columbia.edu)
.br
Dale N. Chayes (dale@lamont.ldeo.columbia.edu)
.br
Lamont-Doherty Earth Observatory
.br
Palisades, NY 10964

.SH OPTIONS
.TP
.B \fB-A\fIkind/scale\fP
Determines whether beam amplitude (\fIkind\fP = 1) 
or sidescan (\fIkind\fP = 2) data will be processed. 
Also determines the scaling factor \fIscale\fP which
is multiplied times the amplitude or sidescan value
after it has been divided by the appropriate grazing
angle correction. Since the correction is done by division,
any pixel or beam value which is exactly the same as
the correction function will end up with a value equal
to \fIscale\fP. The value \fIscale\fP should be chosen
so that the resulting values can be 
represented in the relevent data format
(e.g. if sidescan values are represented by unsigned
short integers so that possible values range from 0 to
65535, a choice of \fIscale\fP = 1000 works well). 
Default: \fIkind\fP = 2, \fIscale\fP = 1000.
.TP
.B \fB-B\fIyr/mo/da/hr/mn/sc\fP
Sets the starting time for data allowed in the input data; pings
with times before the starting time will be ignored. 
Default: \fIyr/mo/da/hr/mn/sc\fP = 1962/2/21/10/30/0.
.TP
.B \fB-C\fP
Normally, if \fBmbbackangle\fP generates the grazing angle
correction locally, the correction is forced to be symmetric 
about the vertical
(zero angle) axis. If \fB-C\fP is specified, the local amplitude
vs grazing angle function will not be forced to be symmetric.
.TP
.B \fB-D\fImode/length\fP
Sets the manner in which the local grazing angle correction
is calculated. If \fImode\fP = 1, then the local correction
function will be calculated for the current ping using the
\fIlength\fP previous pings and the next \fIlength\fP pings,
thus using a total of 2*\fIlength\fP + 1 pings for the
grazing angle correction. I\fImode\fP = 2, then the local
correction will be calculated for the current ping using all
pings which are within \fIlength\fP km of the current ping
along the shiptrack.
.TP
.B \fB-E\fIyr/mo/da/hr/mn/sc\fP
Sets the ending time for data allowed in the input data; pings
with times after the ending time will be ignored. 
Default: \fIyr/mo/da/hr/mn/sc\fP = 2062/2/21/10/30/0.
.TP
.B \fB-F\fIformat\fP
Sets the data format used in reading the input from stdin
or from a file. This program uses the \fBMBIO\fP library 
and will read or write any multibeam
format supported by \fBMBIO\fP. A list of the multibeam data formats
currently supported by \fBMBIO\fP and their identifier values
is given in the \fBMBIO\fP manual page. Default: \fIformat\fP = 11.
.TP
.B \fB-G\fP
This option forces the grazing angle correction to be made using
a flat seafloor assumption, so that seafloor slopes are ignored
even if bathymetry is available. 
.TP
.B \fB-H\fP
This "help" flag causes the program to print out a description
of its operation and then exit immediately.
.TP
.B \fB-I\fIinfile\fP
Sets the input multibeam data filename. 
This program uses the \fBMBIO\fP library and will read or write any multibeam
format supported by \fBMBIO\fP. A list of the multibeam data formats
currently supported by \fBMBIO\fP and their identifier values
is given in the \fBMBIO\fP manual page. Default: \fIinfile\fP = "stdin".
.TP
.B \fB-N\fInangle/angle\fP
The amplitude vs grazing angle table is calculated by binning the
amplitude values according to their grazing angles and averaging
the amplitudes within each bin. This option sets the number of
grazing angle bins (\fInangle\fP) and the maximum angle considered
(\fIangle\fP). The grazing angle function will be defined at
\fInangle\fP points spaced equally from -\fIangle\fP to 
+\fIangle\fP. The \fInangle\fP value should be an odd integer
so that the middle bin is centered on the angle 0.0.
Default: \fInangle\fP = 161, \fIangle\fP = 80.0.
.TP
.B \fB-O\fIoutfile\fP
Data file to which the output data will be written. The \fBMBIO\fP
format id used is the same as for the input data. If
no output file is specified, the output will be written to
stdout. Default: \fIoutfile\fP = stdout.
.TP
.B \fB-R\fIwest/east/south/north\fP
Sets the longitude and latitude bounds within which multibeam 
data will be read. Only the data which lies within these bounds will
be copied. 
Default: \fIwest\fP=-360, east\fI=360\fP, \fIsouth\fP=-90, \fInorth\fP=90.
.TP
.B \fB-S\fIcorrectionfile\fP
Data file from which a global grazing angle correction function
is read. If the \fB-S\fP option is not used, then local corrections
will be calculated using the parameters specified with the
\fB-D\fP and \fB-N\fP options.
.TP
.B \fB-V\fP
Normally, \fBmbanglecorrect\fP works "silently" without outputting
anything to the stderr stream.  If the
\fB-V\fP flag is given, then \fBmbanglecorrect\fP works in a "verbose" 
mode and outputs the program version being used, the values
of some important control parameters, and 
all error status messages.
.TP
.B \fB-Z\fIdepth\fP
This option specifies a default depth value in meters to be
used whenever bathymetry values are unavailable. A flat seafloor
(zero slope) will be assumed wherever the default depth needs
to be used (e.g. data files with sidescan but no bathymetry, or
the outer parts of swaths where the sidescan may extend further
than the bathymetry). If this option is not used, no corrected
amplitude or sidescan values will be output where bathymetry
is unavailable.

.SH EXAMPLES
Suppose one has a SeaBeam 2100 data file called test.mb41
which contains bathymetry (121 beams in a 120 degree swath), 
beam amplitude (121 beams coincident with bathymetry),
and sidescan data (2000 pixels, roughly a 150 degree swath).
Plots of the raw sidescan are dominated by the high amplitude
specular region in the center of the swath and the gradual
fall-off of amplitudes in the outer swath. 
In order to obtain a global correction function 
which can be used by \fBmbanglecorrect\fP
to "flatten out" the sidescan values so that seafloor features
are more evident, the user can run \fBmbbackangle\fP as follows:
 	mbbackangle -F41 -Itest.mb41 -A2 -N161/80 > gaf.dat
.br
Given the correction file, \fBmbanglecorrect\fP can now be used
to apply the correction uniformly to the data:
 	mbanglecorrect -F41 -Itest.mb41 -Otest_corr.mb41 \
 		-A2/1000 -Sgaf.dat
.br
Here the scale of 1000 applied with the \fB-A\fP option implies
that "normal" pixels (having values 
originally equal to the correction function
at their grazing angle) will end up with values of 1000.
In order to calculate the grazing angle correction locally,
the following will work:
 	mbanglecorrect -F41 -Itest.mb41 -Otest_corr.mb41 \
 		-A2/1000 -D2/1 -N161/80
.br
Here the local grazing angle correction for each ping will be
calculated using all pings within 1 km of that ping along
the shiptrack, as specified using the \fB-D\fP option. 
The calculation of the grazing angle
correction function itself will involve binning
and averaging the sidescan values in 161 1-degree-wide angular
bins extending from -80 to +80 degrees, as specified using
the \fB-N\fP option

.SH SEE ALSO
\fBmbsystem\fP(l), \fBmbbackangle\fP(l), \fBmbfilter\fP(l)

.SH BUGS
None that are particularly memorable.