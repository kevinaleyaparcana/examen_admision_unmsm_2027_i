* Distribución de puntajes del Examen de admisión UNMSM 2027-II
* Carrera: Medicina humana
* Fuente: https://admision.unmsm.edu.pe/Website20261025/A/011/results.html
* Fecha de recuperación de datos: 2026-10-26
* Autor: Kevin Aley Aparcana
* Fecha: 2026-10-26
***************************************************************************

global carpeta "D:\MEGA\Publicaciones\1. Artículos\15. Examen de admisión 2027-I"

import excel "$carpeta\bases\Medicina_humana_2027_I.xlsx", sheet("Hoja1") cellrange(A1) firstrow clear

* limpieza
	rename *, lower
	format puntaje %8.3fc
	gsort +méritoep -puntaje

save "$carpeta\temporal\Medicina_humana_2027_I.dta", replace

***************************************************************************
* Puntaje - examen
***************************************************************************
use "$carpeta\temporal\Medicina_humana_2027_I.dta", clear

* test de normalidad
	sum 		puntaje
	ksmirnov 	puntaje=normal((puntaje-r(mean))/r(sd))
	sktest 		puntaje
	sfrancia 	puntaje
	swilk 		puntaje

* frecuencia
	tab puntaje, m
	tab puntaje if puntaje>=1300.00
	tab puntaje if puntaje>=1400.00
	tab puntaje if puntaje>=1500.00
	
* histograma
	hist puntaje, bin(36) freq normal addlabels addlabopts(mlabsize(vsmall)) normopts(lcolor(blue)) kdensity kdenopts(gauss lcolor(red)) xlabel(0"0" 500"500" 1000"1000" 1400"1400" 1600"1600" 1800"1800" 2000"2000")
	graph export "$carpeta\gráficos\Medicina_humana_2027_I.png", as(png) replace
	graph hbox puntaje
	graph export "$carpeta\gráficos\Medicina_humana_2027_I_hbox.png", as(png) replace
	***************************************************************************
* Puntaje estandarizado - examen
***************************************************************************

* generar puntajes estandarizados
	sum puntaje
	gene sd_puntaje=(puntaje-r(mean))/r(sd)
	label var sd_puntaje "Puntaje estandarizado"
	format sd_puntaje %5.3fc

* histograma
	hist sd_puntaje, bin(36) freq normal addlabels addlabopts(mlabsize(vsmall)) normopts(lcolor(blue)) kdensity kdenopts(gauss lcolor(red)) xlabel(-2 "-2" -1 "-1" 0"0" 1"1" 2"2" 3"3" 3.5"3.5" 4"4")
	graph export "$carpeta\gráficos\Medicina_humana_2027_I_estandarizado.png", as(png) replace
