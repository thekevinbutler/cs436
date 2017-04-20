BEGIN {
	
	timeInterval = 0.05;
   time1 = 0.0;
   time2 = 0.0;
   num_packets = 0;
   bytes1018 = 0.0;
   bytes1618 = 0.0;
   bytes927 = 0.0;
   bytes1321 = 0.0;

}

{
   time2 = $2;

   if (time2 - time1 > timeInterval) {
      throughput = bytes1018 / (time2 - time1);
      printf("%f\t%f\t", time2, throughput) > "example1.xls";
      throughput = bytes1618 / (time2 - time1);
      printf("%f\t", throughput) > "example1.xls";
      throughput = bytes927 / (time2 - time1);
      printf("%f\t", throughput) > "example1.xls";
      throughput = bytes1321 / (time2 - time1);
      printf("%f\n", throughput) > "example1.xls";
      time1 = $2;
      bytes1018 = 0.0;
	  bytes1618 = 0.0;
	  bytes927 = 0.0;
	  bytes1321 = 0.0;
   }

   if ($1 == "r" && $4 == 18 && $5 == "tcp" && $8 == 1) {
      bytes1018 += $6;
   }
   if ($1 == "r" && $4 == 18 && $5 == "tcp" && $8 == 2) {
      bytes1618 += $6;
   }
   if ($1 == "r" && $4 == 27 && $5 == "cbr") {
      bytes927 += $6;
   }
   if ($1 == "r" && $4 == 21 && $5 == "exp") {
      bytes1321 += $6;
   }

}

END {
   print("********");
   printf("done duuu \n\n");
   print("********");
}

