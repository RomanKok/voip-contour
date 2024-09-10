#!/bin/bash

/usr/local/bin/sipp -sf /sipp_scenario/sip_option.xml -i 10.11.1.5 -mi 10.11.1.5 -s 2011 -m 1 10.11.1.6
RESULT=$?
if [[ $RESULT -ne 0 ]]; then
    echo "**ERROR: SIP session failed, $0 -> code ${RESULT}"
    exit $RESULT
else
    echo "Test 'SIP OPTION' passed"
    exit 0
fi
