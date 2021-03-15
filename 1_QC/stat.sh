for i in *R1*/fastqc_data.txt; do sed -n -e '/>>Per sequence quality/,/>>END_MODULE/p' $i | grep -v ">>"| grep -v "#" |awk '$1>=30' | awk '{sum=sum+$2}END{print sum}' ; done >t1.txt
for i in *R1*/fastqc_data.txt; do sed -n -e '/>>Per sequence quality/,/>>END_MODULE/p' $i | grep -v ">>"| grep -v "#" | awk '{sum=sum+$2}END{print sum}' ; done >t2.txt
for i in *R2*/fastqc_data.txt; do sed -n -e '/>>Per sequence quality/,/>>END_MODULE/p' $i | grep -v ">>"| grep -v "#" |awk '$1>=30' | awk '{sum=sum+$2}END{print sum}' ; done >t3.txt
for i in *R2*/fastqc_data.txt; do sed -n -e '/>>Per sequence quality/,/>>END_MODULE/p' $i | grep -v ">>"| grep -v "#" | awk '{sum=sum+$2}END{print sum}' ; done >t4.txt
for i in *R1*/fastqc_data.txt; do sed -n -e '/>>Per sequence quality/,/>>END_MODULE/p' $i | grep -v ">>"| grep -v "#" | awk '{sum=sum+$2*$1}END{print sum}' ; done >t5.txt
for i in *R2*/fastqc_data.txt; do sed -n -e '/>>Per sequence quality/,/>>END_MODULE/p' $i | grep -v ">>"| grep -v "#" | awk '{sum=sum+$2*$1}END{print sum}' ; done >t6.txt
paste t1.txt t2.txt t3.txt t4.txt t5.txt t6.txt | awk '{print $0"\t"($1+$3)/($2+$4)"\t"($5+$6)/($2+$4)}' >sum_total.txt
rm t*txt
