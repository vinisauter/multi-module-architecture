#!/bin/sh

LIBFOLDER="${PWD}/build"
SUBFOLDER="${LIBFOLDER}/host/outputs/repo"

pushd "modules"

    function build_lib() {
        pushd "${directory}"
            echo "Building ${PWD}"
            echo "Module will be save in: {$LIBFOLDER}"

            flutter build aar --output-dir=${LIBFOLDER}
            #echo "$d"
        popd
    }

    MODULE=$1

    if [ -z "$MODULE" ]
    then
        echo "Building all modules"
        for d in */ ; do
            directory="${d%/}"
            build_lib
        done
    else
        echo "Building module: ${MODULE}"
        directory="${MODULE}_business_module"
        build_lib
    fi

popd

find build/host/outputs/repo -mindepth 1 -maxdepth 1 -type d -exec mv {} build/ \;
rm -rf build/host/