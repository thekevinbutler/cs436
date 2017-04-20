#create a simulator object
set ns [new Simulator]
$ns rtproto DV
set tracefd [open project_butler_jaymes.tr w]

$ns trace-all $tracefd
#create six nodes
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]
set n6 [$ns node]
set n7 [$ns node]
set n8 [$ns node]
set n9 [$ns node]
set n10 [$ns node]
set n11 [$ns node]
set n12 [$ns node]
set n13 [$ns node]
set n14 [$ns node]
set n15 [$ns node]
set n16 [$ns node]
set n17 [$ns node]
set n18 [$ns node]
set n19 [$ns node]
set n20 [$ns node]
set n21 [$ns node]
set n22 [$ns node]
set n23 [$ns node]
set n24 [$ns node]
set n25 [$ns node]
set n26 [$ns node]
set n27 [$ns node]



#Create links between the n1 and endpoints
$ns duplex-link $n1 $n12 1Mb 20ms DropTail
$ns queue-limit $n1 $n12 10
$ns duplex-link $n1 $n11 1Mb 20ms DropTail
$ns queue-limit $n1 $n11 10
$ns duplex-link $n1 $n10 1Mb 20ms DropTail
$ns queue-limit $n1 $n10 10
$ns duplex-link $n1 $n9 1Mb 20ms DropTail
$ns queue-limit $n1 $n9 10
$ns duplex-link $n1 $n8 1Mb 20ms DropTail
$ns queue-limit $n1 $n8 10
$ns duplex-link $n1 $n7 1Mb 20ms DropTail
$ns queue-limit $n1 $n7 10

#Create links between n4 the end points
$ns duplex-link $n4 $n17 1Mb 20ms DropTail
$ns queue-limit $n4 $n17 10
$ns duplex-link $n4 $n18 1Mb 20ms DropTail
$ns queue-limit $n4 $n18 10
$ns duplex-link $n4 $n19 1Mb 20ms DropTail
$ns queue-limit $n4 $n19 10
$ns duplex-link $n4 $n20 1Mb 20ms DropTail
$ns queue-limit $n4 $n20 10

#create links between n6 and end points
$ns duplex-link $n6 $n25 1Mb 20ms DropTail
$ns queue-limit $n6 $n25 10
$ns duplex-link $n6 $n26 1Mb 20ms DropTail
$ns queue-limit $n6 $n26 10
$ns duplex-link $n6 $n27 1Mb 20ms DropTail
$ns queue-limit $n6 $n27 10


#Create links between n0  the end point nodes
$ns duplex-link $n0 $n13 1Mb 10ms DropTail
$ns duplex-link $n0 $n14 1Mb 10ms DropTail
$ns duplex-link $n0 $n15 1Mb 10ms DropTail
$ns duplex-link $n0 $n16 1Mb 10ms DropTail

#Set Queue Size of link (n0-to end points) to
$ns queue-limit $n0 $n13 10
$ns queue-limit $n0 $n14 10
$ns queue-limit $n0 $n15 10
$ns queue-limit $n0 $n16 10

#Create links between n5  the end point nodes
$ns duplex-link $n5 $n21 1Mb 10ms DropTail
$ns duplex-link $n5 $n22 1Mb 10ms DropTail
$ns duplex-link $n5 $n23 1Mb 10ms DropTail
$ns duplex-link $n5 $n24 1Mb 10ms DropTail

#Set Queue Size of link (n5-to end points) to
$ns queue-limit $n5 $n21 10
$ns queue-limit $n5 $n22 10
$ns queue-limit $n5 $n23 10
$ns queue-limit $n5 $n24 10

#PURPLE CONNECTIONS
$ns duplex-link $n4 $n2 2Mb 40ms DropTail
$ns queue-limit $n4 $n2 15
$ns duplex-link $n3 $n5 2Mb 40ms DropTail
$ns queue-limit $n3 $n5 15
$ns duplex-link $n6 $n3 2Mb 40ms DropTail
$ns queue-limit $n6 $n3 15

#Create links between n0  the n2
$ns duplex-link $n0 $n2 2Mb 40ms DropTail

#Set Queue Size of link (n0-n2) to 15
$ns queue-limit $n0 $n2 15

# BLACK CONNECTIONS
#Create links between n1  the n2 and n3
$ns duplex-link $n1 $n2 8Mb 50ms DropTail
$ns duplex-link $n1 $n3 8Mb 50ms DropTail
$ns duplex-link $n2 $n3 8Mb 50ms DropTail
#Set Queue Size of link (n1-n2) to 20
$ns queue-limit $n0 $n2 20
#Set Queue Size of link (n1-n3) to 20
$ns queue-limit $n1 $n3 20
#Set Queue Size of link (n2-n3) to 20
$ns queue-limit $n2 $n3 20


#####Traffic setup

#$ns trace-queue $n1 $n3 $tracefd


#Define a procedure that attaches a UDP agent to a previously created node
#'node' and attaches an CBR traffic generator to the agent with the
#characteristic values 'size' for packet size 'burst' for burst time,
#'idle' for idle time and 'rate' for burst peak rate. The procedure connects
#the source with the previously defined traffic sink 'sink' and returns the
#source object.
proc attach-cbr-traffic { node sink size} {
	#Get an instance of the simulator
	set ns [Simulator instance]

	#Create a UDP agent and attach it to the node
	set source [new Agent/UDP]
	$ns attach-agent $node $source

	#Create an CBR traffic agent and set its configuration parameters
	set traffic [new Application/Traffic/CBR]
	$traffic set packetSize_ $size
	$traffic set interval_ 0.005
	$traffic set random_ 1
    
    # Attach traffic source to the traffic generator
    $traffic attach-agent $source
	#Connect the source and the sink
	$ns connect $source $sink
	return $traffic
}
#for exp traffic
proc attach-exp-traffic { node sink } {
	#Get an instance of the simulator
	set ns [Simulator instance]

	#Create a UDP agent and attach it to the node
	set source [new Agent/UDP]
	$ns attach-agent $node $source

	#Create an Expoo traffic agent and set its configuration parameters
	set traffic [new Application/Traffic/Exponential]
	$traffic set packetSize_ 200
	$traffic set burst_time_ 0.5s
	$traffic set idle_time_ 0.5s
	$traffic set rate_ 100k
        
        # Attach traffic source to the traffic generator
        $traffic attach-agent $source
	#Connect the source and the sink
	$ns connect $source $sink
	return $traffic
}

#this is for tcp traffic
proc attach-tcp-cbr-traffic { node sink size fid} {
	#Get an instance of the simulator
	set ns [Simulator instance]

	#Create a TCP agent and attach it to the node
	set source [new Agent/TCP]
	$source set class_ 2
	$ns attach-agent $node $source

	#Create an CBR traffic agent and set its configuration parameters
	set traffic [new Application/Traffic/CBR]
	$traffic set packetSize_ $size
	$traffic set interval_ 0.005
	$traffic set random_ 1
    $source set fid_ $fid

    # Attach traffic source to the traffic generator
    $traffic attach-agent $source
	#Connect the source and the sink
	$ns connect $source $sink
	return $traffic
}

#########using the above procedure for CBR setups

#set up lossmonitors (the endpoint)
#for n9
set sink9to12 [new Agent/LossMonitor]
set sink9to14 [new Agent/LossMonitor]
set sink9to15 [new Agent/LossMonitor]
set sink9to20 [new Agent/LossMonitor]
set sink9to23 [new Agent/LossMonitor]
set sink9to27 [new Agent/LossMonitor]
#for n13
set sink13to21 [new Agent/LossMonitor]
#for 10 and 16
set sink10to18 [new Agent/TCPSink]
set sink16to18 [new Agent/TCPSink]

#attach sink to endpoint node
#forn9
$ns attach-agent $n12 $sink9to12
$ns attach-agent $n14 $sink9to14
$ns attach-agent $n15 $sink9to15
$ns attach-agent $n20 $sink9to20
$ns attach-agent $n23 $sink9to23
$ns attach-agent $n27 $sink9to27
#for n13
$ns attach-agent $n21 $sink13to21
#for 10 and 16
$ns attach-agent $n18 $sink10to18
$ns attach-agent $n18 $sink16to18

#create the traffic sources at start
#for n9
set source9to12 [attach-cbr-traffic $n9 $sink9to12 1500]
set source9to14 [attach-cbr-traffic $n9 $sink9to14 1500]
set source9to15 [attach-cbr-traffic $n9 $sink9to15 1500]
set source9to20 [attach-cbr-traffic $n9 $sink9to20 1500]
set source9to23 [attach-cbr-traffic $n9 $sink9to23 1500]
set source9to27 [attach-cbr-traffic $n9 $sink9to27 1500]
#for n13
set source13to21 [attach-exp-traffic $n13 $sink13to21 ]
#for 10 and 16
set source10to18 [attach-tcp-cbr-traffic $n10 $sink10to18 1000 1]
set source16to18 [attach-tcp-cbr-traffic $n16 $sink16to18 1000 2]

#set the start and stop of traffic
#for n9
$ns at 1.0 "$source9to12 start"
$ns at 1.0 "$source9to14 start"
$ns at 1.0 "$source9to15 start"
$ns at 1.0 "$source9to20 start"
$ns at 1.0 "$source9to23 start"
$ns at 1.0 "$source9to27 start"
#for n13
$ns at 2.0 "$source13to21 start"
#for 10 and 16
$ns at 3.0 "$source10to18 start"
$ns at 4.0 "$source16to18 start"

#down and up
$ns rtmodel-at 6.0 down $n1 $n3
$ns rtmodel-at 7.0 up $n1 $n3

proc endsim {} {
global tracefd
	close $tracefd
	exit 0
}
######stop
#for n9
$ns at 10.0 "$source9to12 stop"
$ns at 10.0 "$source9to14 stop"
$ns at 10.0 "$source9to15 stop"
$ns at 10.0 "$source9to20 stop"
$ns at 10.0 "$source9to23 stop"
$ns at 10.0 "$source9to27 stop"
#for n13
$ns at 10.0 "$source13to21 stop"
$ns at 10.0 "$source10to18 stop"
$ns at 10.0 "$source16to18 stop"
$ns at 10.0 "endsim"

#####-----------------NETWORK------------####

$ns run
