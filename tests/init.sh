#!/bin/bash

function exec_test() {
    docker exec -i voip-contour_sipp_ua_1 bash /tests/$@
    RESULT=$?
    echo "*************************************"
    echo "Test $1 result $RESULT"
    echo "*************************************"
    if [[ $RESULT -ne 0 ]]; then
        exit $RESULT
    fi
}

exec_test sip_option.sh

echo "TESTS SUCCESS"