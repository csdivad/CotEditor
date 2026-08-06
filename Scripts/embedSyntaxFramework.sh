#!/bin/sh

set -eu

sourceFramework="${BUILT_PRODUCTS_DIR}/PackageFrameworks/Syntax.framework"
destinationFramework="${TARGET_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}/Syntax.framework"

if [ ! -d "${sourceFramework}" ]; then
    exit 0
fi

mkdir -p "$(dirname "${destinationFramework}")"
rm -rf "${destinationFramework}"
cp -R "${sourceFramework}" "${destinationFramework}"

if [ "${CODE_SIGNING_ALLOWED:-NO}" = "YES" ] && [ -n "${EXPANDED_CODE_SIGN_IDENTITY:-}" ]; then
    /usr/bin/codesign --force --sign "${EXPANDED_CODE_SIGN_IDENTITY}" \
        --preserve-metadata=identifier,entitlements "${destinationFramework}"
fi
