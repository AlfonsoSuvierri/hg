#!/bin/bash
domlogs='/usr/local/apache/domlogs/'$USER; # Just to declare the domlog path.

## Start off by initializing the functions
searchLogs() {
  d_x=1;
  if [ ! "$search_term" ]
  then {
  echo "Obtaining options for" $USER; echo;
  
  for option in "$domlogs"/* 
    do
      echo $d_x." $option";
      eval dom$d_x=$option;
      d_x=$((d_x + 1));
    done
  
  echo; echo -ne "Type the number of the path you wish to review: "; read;
  
  domain_toread=$(eval echo "\$dom$REPLY");
  
  if (( $REPLY > $((d_x - 1)) || $REPLY < 1)); then
    echo "Invalid entry.. exiting"; exit 1;
  fi
  printData $domain_toread
  } else {
    echo "Picked up variable -- $search_term";
    
    ## Call the function to set the return value.
    getSearchOptions $search_term
    
    
    echo; echo -ne "Type the number of the path you wish to review: "; read;
    domain_toread=$(eval echo "\$dom$REPLY");
    
    #echo "DX TEST -- $d_x";
    #echo "READ $REPLY";
    #echo "CUR DOM IS $dom1";
    
    if (( $REPLY > $((d_x - 1)) || $REPLY < 1 )); then
      echo "Invalid entry.. exiting"; exit 1;
    fi
    
    printData $domain_toread
    
  } 
  fi
}

getSearchOptions() {
  #find $domlogs -type f -iname "*$search_term*" -print0 | while IFS= read -r -d $'\0' line;
  
  #Okay, so let's see what we're working with first..
  echo "Searching for.. $search_term";
  
  find $domlogs -type f -iname "*$search_term*" -print0 | while IFS= read -r -d $'\0' line; do
    ((testcount++))
  done < <(grep PATH /etc/profile)
  
  echo "Returned var count -- $testcount";
}

printData() {
  echo "-----------------------------";
  echo "Obtaining data from" $domain_toread; echo;
  echo ">> Last 5 entries:";
  
  awk '{print $1}' $domain_toread |uniq -c |tail -n5;
  echo; echo ">> Top 10:";
  awk '{print $1}' $domain_toread |sort |uniq -c |sort -nr |head -n10;
  echo; echo ">> Top 10 Links:";
  awk '{print $1, $7}' $domain_toread |sort |uniq -c |sort -nr |head -n10;
}

## Start the actual code (after picking up parameters and what not)
## If something is picked up, it will declare the value and search for it. Otherwise, just list all options.

if [ "${#}" == 0 ]
then
  search_term="";
  searchLogs $search_term
else
  search_term=$1;
  searchLogs $search_term
fi
