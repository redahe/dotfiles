#!/bin/bash

acidview_dir="~/scene/soft/acid"

if [ $# -eq 0 ]
  then
    dosbox -noconsole -c "mount X $PWD" -c "mount T $acidview_dir" -c "x:" -c "T:\acidview.exe *.ans *.asc *.diz *.jpg"
 else

    dr=$(dirname $1)
    fl=$(~/.utils/filename2dos.py $1)
    dosbox -noconsole -c "mount X $dr" -c "mount T $acidview_dir" -c "x:" -c "T:\acidview.exe $fl" -c "exit"
fi

