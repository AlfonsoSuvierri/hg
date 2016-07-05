#!/bin/bash
domlogs='/usr/local/apache/domlogs/'$USER; # Just to declare the domlog path.

## Start off by initializing the functions
searchLogs() {
  echo "Testing -- " $search_term;
}

## Start the actual code (after picking up parameters and what not)
## If something is picked up, it will declare the value and search for it. Otherwise, just list all options.

if [ "${#}" == 0 ]
then
  echo "Nothing picked up. Listing all options.. ";
  search_term=$1
  searchLogs $search_term
else
  search_term=null
  searchLogs $search_term
fi
