#!/bin/sh

for prefix in "$@"; do
    if [ ! -d "$prefix" ]; then
        echo "Prefix $prefix doesn't exist!" 1>&2
        echo "Aborting" 1>&2
    fi
done

for prefix in "$@"; do
    export PATH="$prefix/bin:$PATH"
    export LD_LIBRARY_PATH="$prefix/lib:$LD_LIBRARY_PATH"
    export LIBRARY_PATH="$prefix/lib:$LIBRARY_PATH"
    export INCLUDEPATH="$prefix/include:$INCLUDEPATH"
    export MANPATH="$prefix/share/man:$MANPATH"
    echo "Added prefix $prefix..."
done
