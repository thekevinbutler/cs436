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
      printf("%f\t%d\t%d\n", time2, numPackets , totPackets) > "9sent.xls";
	 time1 = $2;
	 numPackets = 0;
   }

   if ($1 == "r" && $4 == 1 && $3 == 9 &&  int($10) == 27) {
      numPackets++;
	  totPackets++;
   }

}

END {
   print("********");
   printf("done with finding total packets sent from n9\n");
   print("********");
}

