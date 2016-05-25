sudo ns simple.tcl 
exec awk -f throughput.awk out.tr > throughput.txt
exec awk -f delay.awk out.tr > delay.txt
exec awk -f pkt.awk out.tr > pkt.txt

