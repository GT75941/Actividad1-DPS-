echo Instalador de la base de datos Universidad
echo Autor: Victor Hugo
echo 10 de agosto de 2022
sqlcmd -S. -E -i BDUniversidad.sql
sqlcmd -S. -E -i BDUniversidadPA.sql
echo Se ejecuto correctamente la base de datos
pause