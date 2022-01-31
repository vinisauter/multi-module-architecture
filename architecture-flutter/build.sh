#!/bin/sh

LIBFOLDER="${PWD}/build"
SUBFOLDER="${LIBFOLDER}/host/outputs/repo"

pushd "modules" > /dev/null

    function build_lib() {
        pushd "${directory}" > /dev/null
            MODULE_NAME="${directory/_business_module/}"
            echo "Module $MODULE_NAME will be save in: {$LIBFOLDER}"

            if [ "$BUILD_ANDROID" = true ]; then
                flutter build aar --output-dir=${LIBFOLDER}
            fi

            if [ "$BUILD_IOS" = true ]; then
                flutter build ios-framework --cocoapods --output="${LIBFOLDER}/ios/${MODULE_NAME}"
            fi
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
            --ios)
                BUILD_IOS=true
                ;;
            --android)
                BUILD_ANDROID=true
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

    if [ -z "$BUILD_IOS" ] && [ -z "$BUILD_ANDROID" ]; then
        BUILD_IOS=true
        BUILD_ANDROID=true
    fi

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

if [ "$BUILD_ANDROID" = true ] && [ "$SEPARATE_FLUTTER" = true ]; then
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