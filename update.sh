#!/bin/sh
set -e

# Check repo for an update
git -C ~/.bash_config fetch origin
results=$(git log HEAD..origin/master --oneline)
if [ "${results}" != "" ]; then
    # TODO pull update
    echo "A new update is available."
else
    echo "bash_config is up-to-date."
fi

