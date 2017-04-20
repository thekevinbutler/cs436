BEGIN {
	
	timeInterval = 0.5;
   time1 = 0.0;
   time2 = 0.0;
   numPackets = 0;
   totPackets = 0;
}

{
   time2 = $2;

   if (time2 - time1 > timeInterval) {
      printf("%f\t%d\t%d\n", time2, numPackets , totPackets) > "13drop.xls";
	 time1 = $2;
	 numPackets = 0;
   }

   if ($1 == "d" && int($10) == 21) {
      numPackets++;
	  totPackets++;
   }

}

END {
   print("********");
   printf("done with finding packets dropped for 13-21\n");
   print("********");
}

