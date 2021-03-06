/*--------------------------------------------------------------------
 *    The MB-system:	mb_put_comment.c	7/15/97
 *    $Id$
 *
 *    Copyright (c) 1997-2017 by
 *    David W. Caress (caress@mbari.org)
 *      Monterey Bay Aquarium Research Institute
 *      Moss Landing, CA 95039
 *    and Dale N. Chayes (dale@ldeo.columbia.edu)
 *      Lamont-Doherty Earth Observatory
 *      Palisades, NY 10964
 *
 *    See README file for copying and redistribution conditions.
 *--------------------------------------------------------------------*/
/*
 * mb_put.c writes comments to a swath sonar data file
 * which has been initialized by mb_write_init().
 *
 * Author:	D. W. Caress
 * Date:	July 15, 1997
 *
 *
 *
 */

/* standard include files */
#include <stdio.h>
#include <math.h>
#include <string.h>

/* mbio include files */
#include "mb_status.h"
#include "mb_format.h"
#include "mb_io.h"
#include "mb_define.h"

/*--------------------------------------------------------------------*/
int mb_put_comment(int verbose, void *mbio_ptr, char *comment, int *error) {
	static char rcs_id[] = "$Id $";
	char *function_name = "mb_put_comment";
	int status;
	struct mb_io_struct *mb_io_ptr;
	int time_i[7] = {0, 0, 0, 0, 0, 0, 0};
	double time_d = 0.0;
	double navlon = 0.0;
	double navlat = 0.0;
	double speed = 0.0;
	double heading = 0.0;
	int i;

	/* print input debug statements */
	if (verbose >= 2) {
		fprintf(stderr, "\ndbg2  MBIO function <%s> called\n", function_name);
		fprintf(stderr, "dbg2  Revision id: %s\n", rcs_id);
		fprintf(stderr, "dbg2  Input arguments:\n");
		fprintf(stderr, "dbg2       verbose:    %d\n", verbose);
		fprintf(stderr, "dbg2       mb_ptr:     %p\n", (void *)mbio_ptr);
		fprintf(stderr, "dbg2       comment:    %s\n", comment);
	}

	/* get mbio descriptor */
	mb_io_ptr = (struct mb_io_struct *)mbio_ptr;

	/* insert comment using mb_insert */
	for (i = 0; i < 7; i++)
		time_i[i] = 0;
	time_d = 0.0;
	navlon = 0.0;
	status = mb_insert(verbose, mbio_ptr, mb_io_ptr->store_data, MB_DATA_COMMENT, time_i, time_d, navlon, navlat, speed, heading,
	                   0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, comment, error);

	/* write the data */
	status = mb_write_ping(verbose, mbio_ptr, mb_io_ptr->store_data, error);

	/* print output debug statements */
	if (verbose >= 2) {
		fprintf(stderr, "\ndbg2  MBIO function <%s> completed\n", function_name);
		fprintf(stderr, "dbg2  Revision id: %s\n", rcs_id);
		fprintf(stderr, "dbg2  Return value:\n");
		fprintf(stderr, "dbg2       error:      %d\n", *error);
		fprintf(stderr, "dbg2  Return status:\n");
		fprintf(stderr, "dbg2       status:  %d\n", status);
	}

	return (status);
}
/*--------------------------------------------------------------------*/
