#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <complex.h> 
#include "defs.h"

// global shared variables 
#define WIDTH 500 		//Horizontal resolution
#define HEIGHT 500 	//Vertical resolution
#define AREA 1.5 			//area = +-AREA +-i AREA 
#define N_THREADS 4
#define R1 1.0	     	//Roots
#define R2 -0.5 + 0.8660*I
#define R3 -0.5 - 0.8660*I
#define TOL 0.0001 		//Tolerance in distance from root


double complex		x_step, y_step; 
int 							latest_row; 
pthread_mutex_t   mutexrowcount;
pthread_mutex_t   mutexdrawrow;

void *newton(void *restrict arg) {

	int 							result[WIDTH], my_row;
	int 							num_iterations;
	double complex 		z, start;  
	double   					distance;
	int stop = 0; 

	/*Find first row to evluate */
  pthread_mutex_lock(&mutexrowcount);  // critical section
		if(latest_row < HEIGHT){  // Update and get latest row
			latest_row++;
			my_row = latest_row; 
		}else{
			stop = 1;			
		} 

	pthread_mutex_unlock(&mutexrowcount); 

	if(stop == 1){
		// terminate the thread, NULL is the null-pointer 
		pthread_exit(NULL); // not really needed 
		return NULL;        // to silence splint
	}
	

	do {

		start = I * (AREA - my_row*y_step) - AREA; //Starting-point in row
		
		for(int n = 0; n < WIDTH; n++) {

			z = start + n * x_step;
			num_iterations = 0; 			
			distance = 10.0;
			
			do {
				z = z - (cpow(z,3) - 1)/(3 * cpow(z,2)); //Newton: z_n+1 = z_n - (z_n^3 -1 )/(3z_n^2)
				
				distance = (cabs(z - R1) < cabs(z - R2) ? cabs(z - R1) : cabs(z - R2)); //Distance to the closest root
				distance = (distance < cabs(z - R3) ? distance : cabs(z - R3));	
				num_iterations++;

			} while(distance > TOL);

			//Check to which root z has converged 		
			if( cabs(z - R1) <= TOL) {
				result[n] = 1;
			} else if( cabs(z - R2) <= TOL) {
				result[n] = 2;
			} else {
				result[n] = 3;
			}

			// Plot the number of iterations for convergence
			//result[n] = num_iterations % 8;
		}  
		pthread_mutex_lock(&mutexdrawrow);  // critical section
			DrawLine(my_row, result); //Draw the line 
		pthread_mutex_unlock(&mutexdrawrow); 
		
		pthread_mutex_lock(&mutexrowcount);  // critical section

			if(latest_row < HEIGHT) { // If not last row, get new my_row

				latest_row++;
				my_row = latest_row; 

			}else {
				stop = 1; //Don't want to end the loop or thread in lock
			}

		pthread_mutex_unlock(&mutexrowcount); 
		  
	}while(stop != 1);	

  // terminate the thread, NULL is the null-pointer 
  pthread_exit(NULL); // not really needed 
  return NULL;        // to silence splint 
}

int main() {

  pthread_t    thread_id[N_THREADS];
  int          i, ret;

  printf("sizeof(void *restrict) = %d\n",
          sizeof(void *restrict));  // to be sure
  printf("sizeof(long)           = %d\n", sizeof(long));


	latest_row = -1; //Global
	x_step = (2.0 * AREA)/(WIDTH - 1.0); //Global
	y_step = (2.0 * AREA)/(HEIGHT - 1.0); //Global

	OpenWindow(WIDTH, HEIGHT);


// Initialize the mutex (mutual exclusion lock). 
  pthread_mutex_init(&mutexrowcount, NULL);
  pthread_mutex_init(&mutexdrawrow, NULL); 

// Create threads to perform the dotproduct 
// NUll implies default properties.        

  for(i = 0; i < N_THREADS; i++)
    if( ret = pthread_create(&thread_id[i], NULL,
                         newton, (void *) (long) i)) {
      printf ("Error in thread create\n");
      exit(1);
    }

// Wait for the other threads. If the main thread
// exits all the slave threads will exit as well.

  for(i = 0; i < N_THREADS; i++)
     if( ret = pthread_join(thread_id[i], NULL) ) {
       printf ("Error in thread join %d \n", ret);
       exit(1);
     }


  pthread_mutex_destroy(&mutexrowcount); 
  pthread_mutex_destroy(&mutexdrawrow); 

  FlushWindow();  /* To make sure that everything has been plotted. */
  CloseWindow();  /* Wait for user to type q in window.             */

  return 0;
}
