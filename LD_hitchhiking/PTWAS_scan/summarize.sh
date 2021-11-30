grep Muscle PTWAS_scan/PTWAS_before.stratified_out.txt | sed 's/OK//g' | sort -gk8 > PTWAS_scan/PTWAS_scan.before.rst
grep Muscle PTWAS_scan/PTWAS_after.stratified_out.txt | sed 's/OK//g' | sort -gk8 > PTWAS_scan/PTWAS_scan.after.rst
