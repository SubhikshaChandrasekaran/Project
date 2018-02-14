#IDS for Grayhole attack  node 2 is  malicious node as mentioned in main.tcl

proc ids {malicious_node} 
{
for {set i 0} {$i < 50} {incr i}
{
     if(n(i).drop_pkt_udp=true)
{
       update_rtable<<next_hop node id_no=24;
       select timer "";
       select node_()malicious_node;
}
  else
{ 
   update rtable "";
}
}
};


