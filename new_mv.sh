#!/bin/bash
#1. Nombre
#2. Ram
#3. Num cores
#4. Disco duro
#5. PORCETANJE PROCESADOR

######### nombre ###############3
while  [ 1 ]; do
dialog --inputbox "Nombre de la maquinae:" 8 40 2> nombre
VARNOMBRE=$(cat nombre)
vboxmanage list vms | grep $VARNOMBRE
if [ $? -eq  1 ]; then 
break
fi
done

#crea la MV
VBoxManage createvm --name $VARNOMBRE --ostype Linux26_64 --register

################### RAM ###############
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
VBoxManage modifyvm $VARNOMBRE --memory $VMEM

######### NUM CORES #############
NUMCORES=$(cat /proc/cpuinfo | grep processor | wc -l) 
NUMTHREAD=$(cat /proc/cpuinfo | grep "cpu cores" | uniq | awk '{print $4}')
NUMCORES=$(( NUMCORES*NUMTHREAD/2 ))
NCORE="dialog --backtitle \"Num CPU\" --radiolist \"Seleccion num cpus:\" 10 40 4 1 1 on" 
for i in $(seq 2 1 ${NUMCORES}); do
	NCORE="${NCORE} ${i} ${i} off"
done
NCORE="${NCORE} 2> salida"
NCORETOTAL=$(cat salida)
eval ${NCORE}

VBoxManage modifyvm $VARNOMBRE --cpus $NCORETOTAL

############## disco duro ###############
dialog --backtitle "Seleccion de HD"  --radiolist "Que tamaño de disco duro:" 0 0 0   1 512MB on    2 2048MB off   3 4096MB off 4 8192MB off  2> discoduro

HDTOTAL=$(cat discoduro)
# crear hd
VBoxManage createmedium disk --filename $HOME/VirtualBox\ VMs/$VARNOMBRE/$VARNOMBRE.vdi --size 2048 --format VDI
# pegar controladores
VBoxManage storagectl $VARNOMBRE --name "SATA Controller" --add sata --controller IntelAhci
#pegar disco a la contoladora
VBoxManage storageattach $VARNOMBRE --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium $HOME/VirtualBox\ VMs/$VARNOMBRE/$VARNOMBRE.vdi

