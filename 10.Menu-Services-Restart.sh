#!/bin/bash
# Manager services restart Menu: vsftpd, apache2 and smbd
clear
while :
do
echo
echo "1.  Estado servicios y puertos"
echo
echo "2.  Reiniciar vsftpd"
echo "3.  Reiniciar apache2"
echo "4.  Reinicar smbd"
echo
echo "5.  Iniciar vsftpd"
echo "6.  Iniciar apache2"
echo "7.  Iniciar smbd"
echo
echo "8.  Parar vsftpd"
echo "9.  Parar apache2"
echo "10. Parar smbd"
echo
echo "11. Salir"
echo
echo -n "Selecciona una opcion [1 - 11]"
read opcion
case $opcion in
1) echo "1. Estado servicios y puertos"
systemctl status vsftpd.service
systemctl status apache2.service
systemctl status smbd.service
echo
echo "--- Puertos ---"
echo
netstat -paton | grep vsftpd
netstat -paton | grep apache2
netstat -paton | grep smbd
;;
2) echo "2. Reiniciar vsftpd"
systemctl restart vsftpd.service
;;
3) echo "3. Reiniciar apache2"
systemctl restart apache2.service
;;
4) echo "4. Reinicar smbd"
systemctl restart smbd.service
;;
5) echo "5. Iniciar vsftpd"
systemctl start vsftpd.service
;;
6) echo "6. Iniciar apache2"
systemctl start apache2.service
;;
7) echo "7. Iniciar smbd"
systemctl start smbd.service
;;
8) echo "8. Parar vsftpd"
systemctl stop vsftpd.service
;;
9) echo "9. Parar apache2"
systemctl restart apache2.service
;;
4) echo "4. Reinicar smbd"
systemctl restart smbd.service
;;
5) echo "5. Iniciar vsftpd"
systemctl start vsftpd.service
;;
6) echo "6. Iniciar apache2"
systemctl start apache2.service
;;
7) echo "7. Iniciar smbd"
systemctl start smbd.service
;;
8) echo "8. Parar vsftpd"
systemctl stop vsftpd.service
;;
9) echo "9. Parar apache2"
systemctl stop apache2.service
;;
10) echo "10. Parar smbd"
systemctl stop smbd.service
;;
11) echo Salir...
exit 1;;
*) echo "$opc no es una opcion válida.";
echo "Presiona una tecla para continuar...";
read foo;;
esac
done