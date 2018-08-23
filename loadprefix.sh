#!/bin/sh

if [ $# -eq 0 ]; then
    echo "Usage: $0 [-l64|-l32] [prefixes...]"
fi

ENABLE_LIB32=false
ENABLE_LIB64=false

while true; do
    case "$1" in
    "-l64")
        ENABLE_LIB64=true
        shift
        ;;
    "-l32")
        ENABLE_LIB32=true
        shift
        ;;
    *)
        break
        ;;
    esac
done

for p in "$@"; do
    if [ ! -d "$p" ]; then
        echo "Prefix $p doesn't exist! Skipping it..."
    else
        prefix=$(readlink -f "$p") # resolve the full path
        export PATH="$prefix/bin:$PATH"
        export LD_LIBRARY_PATH="$prefix/lib:$LD_LIBRARY_PATH"
        export LIBRARY_PATH="$prefix/lib:$LIBRARY_PATH"
        if $ENABLE_LIB32; then
            export LIBRARY_PATH="$prefix/lib32:$LIBRARY_PATH"
            export LD_LIBRARY_PATH="$prefix/lib32:$LD_LIBRARY_PATH"
        fi
        if $ENABLE_LIB64; then
            export LIBRARY_PATH="$prefix/lib64:$LIBRARY_PATH"
            export LD_LIBRARY_PATH="$prefix/lib64:$LD_LIBRARY_PATH"
        fi
        export CPATH="$prefix/include:$CPATH"
        export MANPATH="$prefix/share/man:$MANPATH"
        echo "Added prefix $prefix..."
    fi
done
