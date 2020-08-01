#!/bin/sh

echoInfo () {
	echo "[INF] $1"
}

echoError () {
	echo "[ERR] $1"
}

execute_test()
{
    TEST_TITLE=$1
    EXPECTED_VALUE=$2
    ACTUAL_VALUE=$3
    
    echo
    echo TEST: $TEST_TITLE
    echo "Expected value: $EXPECTED_VALUE"
    echo "Actual value: $ACTUAL_VALUE"
    if [ "$ACTUAL_VALUE" = "$EXPECTED_VALUE" ]; then 
        echoInfo "Test result: SUCCESS"
    else
        echoError "Test result: FAILED"
        exit 1
    fi
}

echo
echo ------------------
echo INITIALIZE TESTING
echo ------------------

NIX_TITLE="INSTALLED_OS"
NIX_OS="alpine"
RESULT_OS=$(cat /etc/os-release | grep '^ID=' | sed -e 's/^ID=//' )
execute_test $NIX_TITLE $NIX_OS $RESULT_OS 

exit 0