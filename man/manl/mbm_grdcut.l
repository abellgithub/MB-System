.TH mbm_grdcut l "23 April 2001" "MB-System 5.0" "MB-System 5.0"
.SH NAME
\fBmbm_grdcut\fP - Macro to extract a specified subarea of a
GMT GRD grid file as another GRD file. 

.SH VERSION
Version 5.0

.SH SYNOPSIS
mbm_grdcut \fB-I\fP\fIinfile\fP \fB-O\fP\fIoutfile\fP \fB-R\fP\fIw/e/s/n\fP [\fB-H\fP \fB-V\fP]

.SH DESCRIPTION
\fBmbm_grdcut\fP is a macro to painlessly cut out a region from a 
GMT GRD grid file.
The GMT program grdcut requires that one specify bounds which
exactly match grid cell boundaries. Frequently, one just wants
to extract an approximate region quickly, without calculating
grid cell sizes and boundary locations. This macro does the
the calculations and extracts the subregion closest to that
specified by the user.

.SH AUTHORSHIP
David W. Caress (caress@mbari.org)
.br
  Monterey Bay Aquarium Research Institute
.br
Dale N. Chayes (dale@ldeo.columbia.edu)
.br
  Lamont-Doherty Earth Observatory

.SH OPTIONS
.TP
.B \-H
This "help" flag cause the program to print out a description
of its operation and then exit immediately.
.TP
.B \-I
\fIinfile\fP
.br
Sets the filename of the input GMT grid file. This file must be
in the GMT NetCDF GRD format. 
.TP
.B \-O
\fIarcfile\fP
.br
Sets the filename of the output GMT grid file. This file will be
in the GMT NetCDF GRD format. 
.TP
.B \-V
The \fB-V\fP option causes \fBmbm_grdcut\fP to print out status messages.

.SH EXAMPLES
Suppose that we have used \fBmbgrid\fP to obtain a
topography grid file called KohalaA_bath.grd in the GMT NetCDF
GRD format:
 	mbgrid -Idatalist \\
 		-OKohalaA_bath \\
 		-R-155.72855/-155.31928/20.09488/20.47645 \\
 		-E30.0/0m! -A2 -N -G3 -C1 -V
.br
Further suppose that one wishes to extract a smaller grid with
bounds of 155 degrees 31 minutes W to 155 degrees 26 minutes W
in longitude and 20 degrees 13 minutes N to 20 degrees 18 minutes N
in latitude. This can be done using the \fBGMT\fP program
\fBgrdcut\fP, but \fBgrdcut\fP requires that the user specify
bounds that exactly match the grid cell boundaries in the file.
The \fBmbm_grdcut\fP macros allows one to specify approximate
desired bounds, calculates the exact, nearest bounds
that \fBgrdcut\fP will accept, and then executes \fBgrdcut\fP.

To obtain the desired sub-grid, the following will suffice:
 	mbm_grdcut -I KohalaA_bath.grd \
 		-O Kohala_plunge \
 		-R-155:31/-155:26/20:13/20:18 \
		-V
.br
The resulting output is:
.br
 	Program mbm_grdcut status:
 		Input GRD file:         kohalaa.grd
 		Output GRD file:        z.grd
 		Input Grid bounds:      -155.72855 -155.3192906  20.09488 20.47628103
 		Input grid dimensions:  1426  1329
 		Grid cell sizes:        0.0002871995719  0.0002871995719
 		Requested Grid bounds:  -155.516666666667 -155.433333333333  20.2166666666667 20.3
 		Output Grid bounds:     -155.51688391551 -155.433596039659  20.2166526184856 20.2999404943366
 		Output grid dimensions: 291  291
 	
 	Running grdcut...
 	grdcut kohalaa.grd -Gz.grd -R-155.51688391551/-155.433596039659/20.2166526184856/20.2999404943366 -V
 	grdcut: File spec:	W E S N dx dy nx ny:
 	grdcut: Old:	-155.729	-155.319	20.0949	20.4763	0.0002872	0.0002872	1426	1329
 	grdcut: New:	-155.517	-155.434	20.2167	20.2999	0.0002872	0.0002872	291	291

 
.SH SEE ALSO
\fBmbsystem\fP(l), \fBmbgrid\fP(l),
\fBmbmosaic\fP(l), \fBmbm_grid\fP(l), \fBmbm_grdplot\fP(l)

.SH BUGS
This macro is new and hasn't been tested in serious
usage yet - let us know what to fix, add, or
change!.

