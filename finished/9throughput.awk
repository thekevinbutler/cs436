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
      printf("%f\t%f\n", time2, throughput) > "9throughput.xls";
     bytes_counter = 0.0;
	 time1 = $2;
   }

   if ($1 == "r" && $4 == 27 && $5 == "cbr") {
      bytes_counter += $6;
   }

}

END {
   print("********");
   printf("done with 9 throughput \n\n");
   print("********");
}

