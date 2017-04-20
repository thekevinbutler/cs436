BEGIN {
	
	timeInterval = 0.5;
   time1 = 0.0;
   time2 = 0.0;
   bytes_counter = 0.0;

}

{
   time2 = $2;

   if (time2 - time1 > timeInterval) {
      throughput = bytes_counter / (time2 - time1);
      printf("%f\t%f\n", time2, throughput) > "13throughput.xls";
     bytes_counter = 0.0;
	 time1 = $2;
   }

   if ($1 == "r" && $4 == 21 && $5 == "exp") {
      bytes_counter += $6;
   }

}

END {
   print("********");
   printf("done with 13 throughput \n\n");
   print("********");
}

