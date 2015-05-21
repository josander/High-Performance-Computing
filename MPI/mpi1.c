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
  MPI_Comm_rank(MPI_COMM_WORLD, &my_rank);

	tag = 1;
	length = 1;

  if (my_rank == 0) {           /* I'm the master process */

    printf("Number of processes = %d\n", n_procs);
    dest = 1;                   /* Send to the other process */
    message = 0;                /* Just send one int */
	
    /* Send message to slave */
    MPI_Send(&message, length, MPI_INT, dest, tag, MPI_COMM_WORLD);
    printf("After MPI_Send\n");

    source = n_procs - 1;

    /* Receive message from slave */
    MPI_Recv(&message, length, MPI_INT, source, tag, MPI_COMM_WORLD, &status);

    printf("After MPI_Recv, message = %d\n", message);

  } else {                      /* I'm the slave process */

		if(my_rank < n_procs - 1){
			source = my_rank - 1;

    	MPI_Recv(&message, length, MPI_INT, source, tag, MPI_COMM_WORLD, &status);
	
    	dest = my_rank + 1;         /* Send to the other process */
    	message++;                  /* Increase message */

   		MPI_Send(&message, length, MPI_INT, dest, tag, MPI_COMM_WORLD);

		} else {

			source = my_rank - 1;

    	MPI_Recv(&message, length, MPI_INT, source, tag, MPI_COMM_WORLD, &status);
	
    	message++;                  /* Increase message */
			dest = 0;
			
    	/* Send message to master */
    	MPI_Send(&message, length, MPI_INT, dest, tag, MPI_COMM_WORLD);

		}

  }

  MPI_Finalize();               /* Shut down MPI */

  return 0;
		

}
