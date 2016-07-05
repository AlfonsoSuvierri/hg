#!/bin/bash
domlogs='/usr/local/apache/domlogs/'$USER; # Just to declare the domlog path.

## Start off by initializing the functions
searchLogs() {
  if [ ! "$search_term" ]
  then ## Start to pull all options for the domlogs
  d_x=1;
  echo "Obtaining options for" $USER; echo;
  
  for option in "$domlogs"/* 
    do
      echo $d_x." $option";
      eval dom$d_x=$option;
      d_x=$((d_x + 1));
    done
  
  #echo; echo -ne "Type the number of the path you wish to review: "; read;
  
  #domain_toread=$(eval echo "\$dom$REPLY");
  
  else
    echo "Picked up variable -- $search_term";
  fi
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
