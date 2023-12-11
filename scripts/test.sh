#!/bin/bash 

SCRIPT_DIR="$( dirname -- "$BASH_SOURCE"; )";

# for c in bullseye; do
for c in alpine314 alpine318 bullseye busybox; do
    rm -f ${c}.output
    echo "testing ${c} with output in ${c}.output..."

    ${SCRIPT_DIR}/init.sh
    echo -e "\n\n### command: wget --timeout=1 long.hello.local" >> ${c}.output
    docker-compose run --rm ${c} wget --timeout=1 long.hello.local >> ${c}.output 2>&1
    echo -e "\n\n### coredns logs:" >> ${c}.output
    docker-compose logs coredns >> ${c}.output 2>&1

    ${SCRIPT_DIR}/init.sh
    echo -e "\n\n### command: ping -c 1 -w 1 long.hello.local" >> ${c}.output
    docker-compose run --rm ${c} ping -c 1 -w 1 long.hello.local >> ${c}.output 2>&1
    echo -e "\n\n### coredns logs:" >> ${c}.output
    docker-compose logs coredns >> ${c}.output 2>&1

    ${SCRIPT_DIR}/init.sh
    echo -e "\n\n### command: nslookup long.hello.local" >> ${c}.output
    docker-compose run --rm ${c} nslookup long.hello.local >> ${c}.output 2>&1
    echo -e "\n\n### coredns logs:" >> ${c}.output
    docker-compose logs coredns >> ${c}.output 2>&1

    ${SCRIPT_DIR}/init.sh
    echo -e "\n\n### command: dig long.hello.local" >> ${c}.output
    docker-compose run --rm ${c} dig long.hello.local >> ${c}.output 2>&1
    echo -e "\n\n### coredns logs:" >> ${c}.output
    docker-compose logs coredns >> ${c}.output 2>&1
done
