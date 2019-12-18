T1=1.0
T2=1.0
mkdir corridas_anteriores
echo $T1 >> T1.txt
echo $T2 >> T2.txt
echo $z_space_wall>>z_space_wall.txt
echo ¿iniciar o continuar\?
read comando
if [ $comando == 'iniciar' ]
then
	echo ¿Guardaste los resultados de la corrida anterior\?\(si\/no\)
	read respuesta1
	if [ $respuesta1 == 'no' ]
	then
		echo ¿Querés guardarlos\?\(si\/no\)
		read respuesta2
		if [ $respuesta2 == 'si' ]
		then
			echo ¿Cómo se llama\?
			read nombre
			mv $nombre corridas_anteriores/.
			echo Listo. Se los guardó en corridas_anteriores
		else
			rm posiciones.txt
			rm velocidades.txt
			rm ultimo_tiempo.txt
			echo Ok
		fi
	fi
	echo Ahora sí
	echo Elija nombre de la corrida
	read nombre
	mkdir $nombre
	echo ¿Con qué dt\?
	read dt
	mkdir dt=$dt
	rm dt.txt
	echo $dt >> dt.txt
	./simple
	mv mediciones.txt dt=$dt/.
	mv movie1.vtf dt=$dt/.
	mv movie2.vtf dt=$dt/.
	mv T.txt dt=$dt/.
	mv test.txt dt=$dt/.
	mv posiciones.txt $nombre/.
	mv velocidades.txt $nombre/.
	mv ultimo_tiempo.txt $nombre/.
	cp plot.py dt=$dt
	mv dt=$dt $nombre/.
else
	echo ¿Qué corrida continuar\?
	read nombre
	cp ~/Descargas/Paredes_Termicas/$nombre/ultimo_tiempo.txt ~/Descargas/Paredes_Termicas
	cp ~/Descargas/Paredes_Termicas/$nombre/posiciones.txt ~/Descargas/Paredes_Termicas
	cp ~/Descargas/Paredes_Termicas/$nombre/velocidades.txt ~/Descargas/Paredes_Termicas
	echo ¿Con qué dt\?
	read dt
	echo ¿Estás repitiendo dt\?\(si\/no\)
	read respuesta3
	if [ $respuesta3 == 'si' ]
	then
		echo ¿Cúantas corridas anteriores con este dt hay\?
		read n
		default=1
		sum=`expr $n + $default`
		mkdir $sum\_dt=$dt
		echo Se guardará todo en $sum\_dt=$dt
		rm dt.txt
		echo $dt >> dt.txt
		./simple
		mv mediciones.txt $sum_dt=$dt/.
		mv movie1.vtf $sum_dt=$dt/.
		mv movie2.vtf $sum_dt=$dt/.
		mv T.txt $sum_dt=$dt/.
		mv test.txt $sum_dt=$dt/.
		mv posiciones.txt $nombre/.
		mv velocidades.txt $nombre/.
		mv ultimo_tiempo.txt $nombre/.
		cp plot.py $sum_dt=$dt
		mv $sum_dt=$dt $nombre/.
	else
		mkdir dt=$dt
		rm dt.txt
		echo $dt >> dt.txt
		./simple
		mv mediciones.txt dt=$dt/.
		mv movie1.vtf dt=$dt/.
		mv movie2.vtf dt=$dt/.
		mv T.txt dt=$dt/.
		mv test.txt dt=$dt/.
		mv posiciones.txt $nombre/.
		mv velocidades.txt $nombre/.
		mv ultimo_tiempo.txt $nombre/.
		cp plot.py dt=$dt
		mv dt=$dt $nombre/.
	fi
fi