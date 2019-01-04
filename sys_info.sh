echo 
sudo dmidecode | grep -A3 'System Information'
echo 
free -h
echo 
lscpu |sed -n '4P'
echo 
echo -n OS Version:  ; uname -a
echo 
