# Pilot Printing Program (please)

This script takes a pilot dropbox submission download in zip format as input and performs the following:

* extracts it to a temp directory in `/tmp`
* deletes the `index.html` file pilot includes
* creates a `.md` cover page from the student name and unique submission fields in the file name
* converts that `.md` to a `.pdf`
* merges the two documents to a single `.pdf`
* prints that resulting PDF file to `UNIX_SECURE_PRINT` (linux only)

Usage: `./print-pilot.sh /path/to/pilot/dropbox.zip`

