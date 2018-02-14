
#===================================
#     Simulation parameters setup
#===================================
set val(chan)   Channel/WirelessChannel    ;# channel type
set val(prop)   Propagation/TwoRayGround   ;# radio-propagation model
set val(netif)  Phy/WirelessPhy            ;# network interface type
set val(mac)    Mac/802_11                 ;# MAC type
set val(ifq)    Queue/DropTail/PriQueue    ;# interface queue type
set val(ll)     LL                         ;# link layer type
set val(ant)    Antenna/OmniAntenna        ;# antenna model
set val(ifqlen) 50                         ;# max packet in ifq
set val(nn)     50                         ;# number of mobilenodes
set val(rp)     AODV                       ;# routing protocol
set val(x)      1000                      ;# X dimension of topography
set val(y)      1000                      ;# Y dimension of topography
set val(stop)   20.0                         ;# time of simulation end
set val(energymodel)    EnergyModel           ;
set val(initialenergy)  1000          ;

#===================================
#        Initialization        
#===================================
#Create a ns simulator
set ns [new Simulator]

#Setup topography object
set topo       [new Topography]
$topo load_flatgrid $val(x) $val(y)
create-god $val(nn)

#Open the NS trace file
set tracefile [open out.tr w]
$ns trace-all $tracefile

#Open the NAM trace file
set namfile [open out.nam w]
$ns namtrace-all $namfile
$ns namtrace-all-wireless $namfile $val(x) $val(y)
set chan [new $val(chan)];#Create wireless channel

$ns color fid magenta

#===================================
#     Mobile node parameter setup
#===================================
$ns node-config -adhocRouting  $val(rp) \
                -llType        $val(ll) \
                -macType       $val(mac) \
                -ifqType       $val(ifq) \
                -ifqLen        $val(ifqlen) \
                -antType       $val(ant) \
                -propType      $val(prop) \
                -phyType       $val(netif) \
                -channel       $chan \
                -topoInstance  $topo \
                -agentTrace    ON \
                -routerTrace   ON \
                -macTrace      ON \
                -movementTrace ON \
			-energyModel   $val(energymodel) \
		-initialEnergy $val(initialenergy) \
		-rxPower 0.5 \
		-txPower 1.0 \
		-idlePower 0.0 \
		-sensePower 0.3 	

#===================================
#        Nodes Definition        
#===================================


for {set i 0} {$i < $val(nn) } { incr i } {
     set n($i) [$ns node]             
	set xx [expr rand()*1000]
     set yy [expr rand()*1000]
     $n($i) set X_ $xx
     $n($i) set Y_ $yy
     $n($i) set Z_ 0.0            
  }


for {set i 5} {$i < 25 } { incr i } {
     set xx [expr rand()*1000]
     set yy [expr rand()*1000]
     $ns at 0.5 "$n($i) setdest $xx $yy 20.0"
}

for {set i 25} {$i < 40 } { incr i } {
     set xx [expr rand()*1000]
     set yy [expr rand()*1000]
     $ns at 0.5 "$n($i) setdest $xx $yy 10.0"
}

for {set i 40} {$i < $val(nn) } { incr i } {
     set xx [expr rand()*1000]
     set yy [expr rand()*1000]
     $ns at 0.5 "$n($i) setdest $xx $yy 35.0"
}

for {set i 5} {$i < 40 } { incr i } {
     set xx [expr rand()*1000]
     set yy [expr rand()*1000]
     $ns at 10.0 "$n($i) setdest $xx $yy 5.0"
}

for {set i 40} {$i < $val(nn) } { incr i } {
     set xx [expr rand()*1000]
     set yy [expr rand()*1000]
     $ns at 5.0 "$n($i) setdest $xx $yy 2.0"
}

for {set i 0} {$i < 5 } { incr i } {
     set xx [expr rand()*1000]
     set yy [expr rand()*1000]
     $ns at 0.5 "$n($i) setdest $xx $yy 1.0"
}

for {set i 0} {$i < $val(nn) } { incr i } {
    $ns initial_node_pos $n($i) 30
}

#===================================
#        Agents Definition        
#===================================
#Setup a TCP connection
set tcp0 [new Agent/TCP]
$ns attach-agent $n(4) $tcp0
set sink1 [new Agent/TCPSink]
$ns attach-agent $n(3) $sink1
$ns connect $tcp0 $sink1
$tcp0 set packetSize_ 1500

#Setup a TCP connection
set tcp2 [new Agent/TCP]
$ns attach-agent $n(12) $tcp2
set sink3 [new Agent/TCPSink]
$ns attach-agent $n(23) $sink3
$ns connect $tcp2 $sink3
$tcp2 set packetSize_ 1500

#Setup a TCP connection
set tcp4 [new Agent/TCP]
$ns attach-agent $n(22) $tcp4
set sink5 [new Agent/TCPSink]
$ns attach-agent $n(11) $sink5
$ns connect $tcp4 $sink5
$tcp4 set packetSize_ 1500

#Setup a TCP connection
set tcp6 [new Agent/TCP]
$ns attach-agent $n(14) $tcp6
set sink7 [new Agent/TCPSink]
$ns attach-agent $n(30) $sink7
$ns connect $tcp6 $sink7
$tcp6 set packetSize_ 1500

#Setup a TCP connection
set tcp8 [new Agent/TCP]
$ns attach-agent $n(28) $tcp8
set sink9 [new Agent/TCPSink]
$ns attach-agent $n(30) $sink9
$ns connect $tcp8 $sink9
$tcp8 set packetSize_ 1500

#Setup a TCP connection
set tcp10 [new Agent/TCP]
$ns attach-agent $n(42) $tcp10
set sink11 [new Agent/TCPSink]
$ns attach-agent $n(0) $sink11
$ns connect $tcp10 $sink11
$tcp10 set packetSize_ 1500

#Setup a TCP connection
set tcp12 [new Agent/TCP]
$ns attach-agent $n(43) $tcp12
set sink13 [new Agent/TCPSink]
$ns attach-agent $n(25) $sink13
$ns connect $tcp12 $sink13
$tcp12 set packetSize_ 1500

#Setup a TCP connection
set tcp14 [new Agent/TCP]
$ns attach-agent $n(31) $tcp14
set sink15 [new Agent/TCPSink]
$ns attach-agent $n(17) $sink15
$ns connect $tcp14 $sink15
$tcp14 set packetSize_ 1500

set udp [new Agent/UDP]
$ns attach-agent $n(2) $udp
set null [new Agent/Null]
$ns attach-agent $n(3) $null
$ns connect $udp $null
$udp set fid_ 1

#===================================
#        Applications Definition        
#===================================
#Setup a FTP Application over TCP connection
set ftp0 [new Application/FTP]
$ftp0 attach-agent $tcp0
$ns at 1.0 "$ftp0 start"
$ns at 10.0 "$ftp0 stop"

#Setup a FTP Application over TCP connection
set ftp1 [new Application/FTP]
$ftp1 attach-agent $tcp2
$ns at 3.0 "$ftp1 start"
$ns at 8.0 "$ftp1 stop"

#Setup a FTP Application over TCP connection
set ftp2 [new Application/FTP]
$ftp2 attach-agent $tcp4
$ns at 6.0 "$ftp2 start"
$ns at 10.0 "$ftp2 stop"

#Setup a FTP Application over TCP connection
set ftp3 [new Application/FTP]
$ftp3 attach-agent $tcp6
$ns at 9.0 "$ftp3 start"
$ns at 13.0 "$ftp3 stop"

#Setup a FTP Application over TCP connection
set ftp4 [new Application/FTP]
$ftp4 attach-agent $tcp8
$ns at 12.0 "$ftp4 start"
$ns at 15.0 "$ftp4 stop"

#Setup a FTP Application over TCP connection
set ftp5 [new Application/FTP]
$ftp5 attach-agent $tcp10
$ns at 14.0 "$ftp5 start"
$ns at 19.0 "$ftp5 stop"

#Setup a FTP Application over TCP connection
set ftp6 [new Application/FTP]
$ftp6 attach-agent $tcp12
$ns at 16.0 "$ftp6 start"
$ns at 18.0 "$ftp6 stop"

#Setup a FTP Application over TCP connection
set ftp7 [new Application/FTP]
$ftp7 attach-agent $tcp14
$ns at 8.0 "$ftp7 start"
$ns at 12.0 "$ftp7 stop"

set cbr [new Application/Traffic/CBR]
$cbr attach-agent $udp
$cbr set packetsize_ 1000
$cbr set rate_ 2Mb
$ns at 5.0 "$cbr start" 
$ns at 9.0 "$cbr stop" 

#===================================
#        Termination        
#===================================
#Define a 'finish' procedure
proc finish {} {
    global ns tracefile namfile
    $ns flush-trace
    close $tracefile
    close $namfile
    exec nam out.nam &
    exit 0
}
for {set i 0} {$i < $val(nn) } { incr i } {
    $ns at $val(stop) "\$n($i) reset"
}
$ns at $val(stop) "$ns nam-end-wireless $val(stop)"
$ns at $val(stop) "finish"
$ns at $val(stop) "puts \"done\" ; $ns halt"
$ns run
