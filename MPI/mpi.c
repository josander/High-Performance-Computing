#include <stdio.h>
#include "mpi.h"

int main(int argc, char *argv[]) {

	int 				message, length, source, dest, tag;
	int 				n_procs;
	int 				my_rank;
	MPI_Status 	status;

	// Start up MPI
	MPI_Init(&argc, &argv);

	// Find out the nuber of processes
	MPI_Comm_size(MPI_COMM_WORLD, &n_procs);

	tag = 1;
	length = 1;

  if (my_rank == 0) {           /* I'm the master process */
    printf("Number of processes = %d\n", n_procs);
    dest = 1;                   /* Send to the other process */
    message = 1;                /* Just send one int */

    /* Send message to slave */
    MPI_Send(&message, length, MPI_INT, dest, tag, MPI_COMM_WORLD);
    printf("After MPI_Send\n");

    source = 1;

    /* Receive message from slave */
    MPI_Recv(&message, length, MPI_INT, source, tag, MPI_COMM_WORLD, &status);

    printf("After MPI_Recv, message = %d\n", message);

  } else {                      /* I'm the slave process */

    source = 0;

    /* Receive message from master */
    MPI_Recv(&message, length, MPI_INT, source, tag, MPI_COMM_WORLD, &status);

    dest = 0;                   /* Send to the other process */
    message++;                  /* Increase message */

    /* Send message to master */
    MPI_Send(&message, length, MPI_INT, dest, tag, MPI_COMM_WORLD);

  }

  MPI_Finalize();               /* Shut down MPI */

  return 0;
		

}
