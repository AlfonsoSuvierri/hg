#!/bin/bash
clear;

allOptions() {
  echo "Test!";
}

doSearch() {
  echo "Test -- $1";
}

# If nothing is specified, just list out all domains.
if [ "${#}" == 0 ]
then
  echo "Nothing picked up. Listing all options.. ";
  allOptions
else
  doSearch $1
fi
