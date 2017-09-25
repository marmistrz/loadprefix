#!/bin/sh

if [ $# -eq 0 ]; then
    echo "Usage: $0 [prefixes...]"
fi

for p in "$@"; do
    if [ ! -d "$p" ]; then
        echo "Prefix $p doesn't exist! Skipping it..."
    else
        prefix=$(readlink -f "$p")  # resolve the full path
        export PATH="$prefix/bin:$PATH"
        export LD_LIBRARY_PATH="$prefix/lib:$LD_LIBRARY_PATH"
        export LIBRARY_PATH="$prefix/lib:$LIBRARY_PATH"
        export INCLUDEPATH="$prefix/include:$INCLUDEPATH"
        export MANPATH="$prefix/share/man:$MANPATH"
        echo "Added prefix $prefix..."
    fi
done
