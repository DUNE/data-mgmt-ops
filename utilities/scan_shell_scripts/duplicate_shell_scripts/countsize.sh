#!/bin/bash
 while read line ; 
  do 
      contname=$(echo $line | cut -f1 -d ' ') 
      locname=$(echo $line | cut -f2 -d ' ') 

      size=`rucio list-files $contname | tail -1 | cut -f4 -d' '`
      echo $contname $locname $size
#      case locname in
#        DUNE_FR_CCIN2P3_DISK)
#            let DUNE_FR_CCIN2P3_DISK+=$size
#            ;;
#        DUNE_US_BNL_SDCC)
#            let DUNE_US_BNL_SDCC+=$size
#            ;;
#        LANCASTER)
#            let LANCASTER+=$size
#            ;;
#        MANCHESTER)
#            let MANCHESTER+=$size
#            ;;
#        NIKHEF)
#            let NIKHEF+=$size
#            ;;
#        
#        PRAGUE)
#            let PRAGUE+=$size
#            ;;
#        QMUL)
#            let QMUL+=$size
#            ;;
#        RAL_ECHO)
#            let RAL_ECHO+=$size
#            ;;
#        RAL-PP)
#            let RALPP+=$size
#            ;;
#        esac
     done
#      echo "DUNE_FR_CCIN2P3_DISK" $DUNE_FR_CCIN2P3_DISK      
#      echo "DUNE_US_BNL_SDCC" $DUNE_US_BNL_SDCC
#      echo "LANCASTER" $LANCASTER          
#      echo "MANCHESTER" $MANCHESTER
#      echo "NIKHEF" $NIKHEF
#      echo "PRAGUE" $PRAGUE
#      echo "QMUL" $QMUL
#      echo "RAL_ECHO" ${RAL_ECHO}
#      echo "RAL-PP" ${RALPP}
