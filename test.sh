#!/bin/bash
domlogs='/usr/local/apache/domlogs/'$USER; # Just to declare the domlog path.

## Start off by initializing the functions
searchLogs() {
  if [ ! "$search_term" ]
  then
    echo "Variable is empty. Continue w/ all.";
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
