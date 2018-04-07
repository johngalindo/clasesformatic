#!/bin/bash
# case example
#ask ram
#ask ram
TOTALMEM=$(free -m | grep Mem | awk '{print $2}')
dialog --backtitle "Seleccion de RAM"  --radiolist "Que cantidad de porcentaje para la memoria RAM:" 11 40 4     1 10% on    2 25% off     3 50% off   4 70% off 2> memoria
SELMEM=$(cat memoria)
case "$SELMEM" in
        1)
        echo "10%"
        VMEM=$(( $TOTALMEM*10/100 ))
        ;;
        2)
        echo "25%"
        VMEM=$(( $TOTALMEM*25/100 ))
        ;;
        3)
        echo "50%"
        VMEM=$(( $TOTALMEM*50/100 ))
        ;;
        4)
        echo "70%"
        VMEM=$(( $TOTALMEM*70/100 ))
        ;;
esac

echo $VMEM
