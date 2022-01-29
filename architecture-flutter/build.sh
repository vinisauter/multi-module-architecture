#!/bin/sh

LIBFOLDER="${PWD}/build"
SUBFOLDER="${LIBFOLDER}/host/outputs/repo"

pushd "modules" > /dev/null

    function build_lib() {
        pushd "${directory}" > /dev/null
            echo "Building ${PWD}"
            echo "Module will be save in: {$LIBFOLDER}"

            flutter build aar --output-dir=${LIBFOLDER}
        popd > /dev/null
    }

    for i in "$@"; do
        case $i in
            -h|--help)
                echo "Usage: build.sh [MODULE] --separate-flutter"
                echo "Builds the specified module and copies it to the build folder."
                echo "If --separate-flutter is specified, the flutter pom will be split in a separate folder."
                exit 0
                ;;
            --separate-flutter)
                SEPARATE_FLUTTER=true
                ;;
            *)
                if [ -n "$MODULE_DEFINED" ]; then
                    echo "Unknown option ${i}"
                    exit 1
                fi
        
                MODULE=$i
                ;;
        esac
        MODULE_DEFINED=true
    done

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

popd > /dev/null

if [ "${SEPARATE_FLUTTER}" = "true" ]; then
    pushd "${SUBFOLDER}" > /dev/null
        echo "POMS in ${PWD}"
        if [ -z "$MODULE" ]
        then
            find . -iname "*.pom" -not -path "*/flutter_module/*" -exec sed -i '' -e '/<dependency>/,/<\/dependency>/d' {} \;
        else
            find . -iname "*.pom" -path "*/${MODULE}_business_module/*" -exec sed -i '' -e '/<dependency>/,/<\/dependency>/d' {} \;
        fi
    popd > /dev/null
fi

find build/host/outputs/repo -mindepth 1 -maxdepth 1 -type d -exec rsync -a {} build/ \;
rm -rf build/host/