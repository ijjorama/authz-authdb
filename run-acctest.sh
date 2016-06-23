#!/bin/sh

#
# Find the TEST lines in the AuthDB file which describe tests
#

grep '^#TEST' /opt/xrd/etc/Authfile | 
while read line  ; do

  #
  # Split the test description to find the command to run, what it should return, and text describing it
  #

  command=$(echo ${line} | cut -d + -f 2)
  expected=$(echo ${line} | cut -d + -f 3)
  description=$(echo ${line} | cut -d + -f 4)

#  echo Command:		${command}
#  echo Expected:		${expected}
 
  echo -n ${description}
  eval ${command} 2>/dev/null | 	# Run test
  grep --quiet ${expected} && echo  ' OK '	 || 				# Alles gut!
  (echo -n ' F! '; echo ${command})				# Else, print the command which failed

done

