if [ $ACTION == "indexbuild" ]; then
  echo "Not running Cuckoo generator during indexing."
  exit 0
fi

# Skip for preview builds
if [ "${ENABLE_PREVIEWS}" = "YES" ]; then
  echo "Not running Cuckoo generator during preview builds."
  exit 0
fi

# Define output file. Change "${PROJECT_DIR}/${PROJECT_NAME}Tests" to your test's root source folder, if it's not the default name.
OUTPUT_FILE="${PROJECT_DIR}/${PROJECT_NAME}Tests/Generated/GeneratedMocks.swift"
echo "Generated Mocks File = ${OUTPUT_FILE}"

# Define input directory. Change "${PROJECT_DIR}/${PROJECT_NAME}" to your project's root source folder, if it's not the default name.
INPUT_DIR="${PROJECT_DIR}/${PROJECT_NAME}"
echo "Mocks Input Directory = ${INPUT_DIR}"

# Generate mock files, include as many input files as you'd like to create mocks for.
"${PODS_ROOT}/Cuckoo/run" generate --testable "${PROJECT_NAME}" \
--output "${OUTPUT_FILE}" \
"${INPUT_DIR}/AnalyticsAdapters/LoginAnalyticsProfileAdapter.swift"
# ... and so forth, the last line should never end with a backslash
echo "Successfull !! Created"
# After running once, locate `GeneratedMocks.swift` and drag it into your Xcode test target group.
