#!/bin/sh

if [ $# -eq 0 ]; then
    echo "Usage: $0 [prefixes...]"
fi

for p in "$@"; do
    if [ ! -d "$prefix" ]; then
        echo "Prefix $prefix doesn't exist!" 1>&2
        echo "Aborting" 1>&2
        exit 1
    fi
done

for p in "$@"; do
    prefix=$(readlink -f "$p")  # resolve the full path
    export PATH="$prefix/bin:$PATH"
    export LD_LIBRARY_PATH="$prefix/lib:$LD_LIBRARY_PATH"
    export LIBRARY_PATH="$prefix/lib:$LIBRARY_PATH"
    export INCLUDEPATH="$prefix/include:$INCLUDEPATH"
    export MANPATH="$prefix/share/man:$MANPATH"
    echo "Added prefix $prefix..."
done
