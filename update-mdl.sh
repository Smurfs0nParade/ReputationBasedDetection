#!/bin/bash

# Gets a fresh copy of ip.txt
#curl https://gitlab.cs.wwu.edu/tsikerm/assignment-files/raw/master/ip.txt > ip.txt

# Gets a fresh copy of mdl.csv
#curl https://gitlab.cs.wwu.edu/tsikerm/assignment-files/raw/master/mdl.csv > mdl.csv

# cat ip.txt|grep -f mdl.csv > output.txt

# Function to output rating
getScore () {
	case $1 in
		'1') echo '26' ;;
		'2') echo '51' ;;
		'3') echo '76' ;;
		'4') echo '101' ;;
		'5') echo '127' ;;
	esac
}

# Variables for use in setting up mdl.list
declare -a myArray=" "
space=" "
comma=","
catagory="1"

# Compares ip.txt and mdl.csv, returns any address in ip.txt found in mdl.csv and its how many times it occurs.
# A score is given based based on how often it occurs. 
while IFS= read -r ipAddress
do
	frequency="$(grep -o $ipAddress mdl.csv | wc -l)"
	if [ $frequency -ge 1 ] && [ $frequency -le 5 ]; then
		score="$(getScore $frequency)"
		ipRep="$ipAddress$comma$catagory$comma$score"
		myArray+="${ipRep}"$'\n'
	else [ $frequency -ge 6 ]
		score='127'
		ipRep="$ipAddress$comma$catagory$comma$score"
		myArray+="${ipRep}"$'\n'
	fi
done < ip.txt

# Tests to see if mdl.list exists, if it does it deletes it as it will be replaced
if test -f "mdl.list"; then
	rm 'mdl.list'
fi

# Puts results in mdl.list
for p in $myArray
do
	echo "${p}" >> mdl.list
done

