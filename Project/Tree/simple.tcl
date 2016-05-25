set ns [new Simulator]
set nt [open out.tr w]
$ns trace-all $nt
set nf [open out.nam w]
$ns namtrace-all $nf


set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]
set n6 [$ns node]

$ns duplex-link $n0 $n1 1Mb 2ms DropTail
$ns duplex-link-op $n0 $n1 orient left-down

$ns duplex-link $n0 $n2 1Mb 2ms DropTail
$ns duplex-link-op $n0 $n2 orient right-down

$ns duplex-link $n1 $n3 1Mb 2ms DropTail
$ns duplex-link-op $n1 $n3 orient left-down

$ns duplex-link $n1 $n4 1Mb 2ms DropTail
$ns duplex-link-op $n1 $n4 orient right-down

$ns duplex-link $n2 $n5 1Mb 2ms DropTail
$ns duplex-link-op $n2 $n5 orient left-down

$ns duplex-link $n2 $n6 1Mb 2ms DropTail
$ns duplex-link-op $n2 $n6 orient right-down

##UDP
set udp [new Agent/UDP]
$ns attach-agent $n0 $udp

set null [new Agent/Null]
$ns attach-agent $n1 $null

$ns connect $udp $null
$udp set fid_ 0
$ns color 0 blue

##UDP1
set udp1 [new Agent/UDP]
$ns attach-agent $n1 $udp1

set null [new Agent/Null]
$ns attach-agent $n3 $null

$ns connect $udp1 $null
$udp1 set fid_ 0
$ns color 0 blue

##UDP2
set udp2 [new Agent/UDP]
$ns attach-agent $n1 $udp2

set null [new Agent/Null]
$ns attach-agent $n4 $null

$ns connect $udp2 $null
$udp2 set fid_ 0
$ns color 0 blue

##TCP
set tcp [new Agent/TCP]
$ns attach-agent $n0 $tcp

set sink [new Agent/TCPSink]
$ns attach-agent $n2 $sink

$ns connect $tcp $sink
$tcp set fid_ 1
$ns color 1 red


##TCP1
set tcp1 [new Agent/TCP]
$ns attach-agent $n2 $tcp1

set sink [new Agent/TCPSink]
$ns attach-agent $n5 $sink

$ns connect $tcp1 $sink
$tcp1 set fid_ 1
$ns color 1 red

##TCP2
set tcp2 [new Agent/TCP]
$ns attach-agent $n2 $tcp2

set sink [new Agent/TCPSink]
$ns attach-agent $n6 $sink

$ns connect $tcp2 $sink
$tcp2 set fid_ 1
$ns color 1 red

##UDP
set cbr [new Application/Traffic/CBR]
$cbr attach-agent $udp

set cbr1 [new Application/Traffic/CBR]
$cbr1 attach-agent $udp1

set cbr2 [new Application/Traffic/CBR]
$cbr2 attach-agent $udp2

##TCP
set ftp [new Application/FTP]
$ftp attach-agent $tcp

set ftp1 [new Application/FTP]
$ftp1 attach-agent $tcp1

set ftp2 [new Application/FTP]
$ftp2 attach-agent $tcp2

$ns at 1.0 "$cbr start"
$ns at 1.1 "$cbr1 start"
$ns at 1.1 "$cbr2 start"
$ns at 1.0 "$ftp start"
$ns at 1.1 "$ftp1 start"
$ns at 1.1 "$ftp2 start"
$ns at 6.0 "$ftp stop"
$ns at 6.0 "$ftp1 stop"
$ns at 6.0 "$ftp2 stop"
$ns at 6.0 "$cbr1 stop"
$ns at 6.0 "$cbr2 stop"
$ns at 6.0 "$cbr stop"
$ns at 7.0 "finish"

proc finish { } {
	global ns nf nt
	$ns flush-trace
	close $nf
	close $nt
	exec nam out.nam &
	exit 0
}

$ns run
