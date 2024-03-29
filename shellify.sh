 #!/bin/bash
 
 if [ $# -ne 1 ]; then exit; fi
 if ! [[ -f $1 ]]; then exit; fi
 objdump -d $1 |grep '[0-9a-f]:'|grep -v 'file'|cut -f2 -d:|cut -f1-6 -d' '|tr -s ' '|tr '\t' ' '|sed 's/ $//g'|sed 's/ /\\x/g'|paste -d'' -s - |sed 's/^/"/'|sed 's/$/"/g'
 echo
 echo "--------------------------------Format------------------------------------"
 echo
 for i in $(objdump -d $1 | grep "^ " | cut -f1 | cut -d: -f2); do echo -n "\\x$i"; done
