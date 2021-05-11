#!/bin/sh

IDENTIFIER=com.toplessbanana.pkg.Resolved
PRODUCT=Resolved.app
PACKAGE=Resolved.pkg
CERTIFICATE="Developer ID Installer: Jayson Kish (Z375TYY86Z)"
USERNAME="$1"
PROVIDER="Z375TYY86Z"

#

createProductArchive() {
	/usr/bin/productbuild --component ./$1 /Applications $2 --scripts ./Scripts --sign $3
}

createProductArchive $PRODUCT $PACKAGE $CERTIFICATE

#

notarizeProductArchive() {
	/usr/bin/xcrun altool --notarize-app --primary-bundle-id "$1" --username "$2" --password "@keychain:AC_PASSWORD" --asc-provider "$3" --file ./$4
}

# notarizeProductArchive $IDENTIFIER $USERNAME $PROVIDER $PACKAGE

#