--2 Todos los vuelos realizados por 'Garcia' BIEN
select distinct C.nombre, E.vid
from Cliente C, Embarque E
where C.cid=E.cid and C.nombre like 'García%';

--3 Numero de vuelos de la compañia 'Quantas' BIEN
select AL.nombre, count(*)
from Aerolinea AL, Vuelo V
where AL.alid=V.alid and AL.nombre like 'Qantas%'
group by Al.nombre;

--4 Compañia (alid) con el maximo numero de vuelos BIEN

select V.alid, count(*) as nvu
from Vuelo V
group by V.alid
having count(*) >= ALL
	(select count(*) as nvu
	from Vuelo V
	group by V.alid);

with NVuelos as (select V.alid, count(*) as nvu
				from Vuelo V
				group by V.alid)
select NV.alid, NV.nvu
from NVuelos NV
where NV.nvu >= ALL (select NV2.nvu from Nvuelos NV2);

--5 5 compañias con el mayor numero de vuelos BIEN

with NVuelos as (select V.alid, count(*) as nvu
				from Vuelo V
				group by V.alid)
select NV.alid, NV.nvu
from NVuelos NV
where 5 > (select count(*)
			from Nvuelos NV2
			where NV2.nvu > NV.nvu);

--6 Pares de origen-destino (apids) con al menos 2 vuelos, ordenado por nº de vuelos BIEN

select V.origen, V.destino, count(*) as nvu
from Vuelo V
group by V.origen, V.destino
having count(*)>=2
order by nvu desc

--7 Encontrar todos los vuelos (vuelos-dia) vacios BIEN

select V.vid, F.fecha
from Vuelo V,
	(select distinct E.fecha from Embarque E) F
where (V.vid,F.fecha) NOT IN (select E.vid, E.fecha
								from Embarque E)

--8 Personas (cid, nombre) que han viajado en su cumpleaños
--  Pista: utilizar extract(<day|month|year> from c.fdn)  BIEN

select distinct C.cid, C.nombre
from Cliente C, Embarque E
where E.cid=C.cid and
	extract(day from E.fecha) = extract(day from C.fdn) and
	extract(month from E.fecha) = extract(month from C.fdn)

--9 Compañia con el maximo numero de viajeros BIEN

with Nviajeros as (
	select V.alid, count(distinct E.cid) as nvi
	from Vuelo V, Embarque E
	where V.vid=E.vid
	group by V.alid )
select NV.alid, NV.nvi
from Nviajeros NV
where NV.nvi >= ALL (select NV2.nvi from NViajeros NV2);

--10 Personas (cid,nombre) que no tienen tarjeta de Quantas,
--   pero que es en la que mas han viajado CREO QUE BIEN

with NVuelos as (
	select E.cid, V.alid, count(*) as nvu
	from Vuelo V NATURAL JOIN Embarque E
	group by E.cid, V.alid )

select C.cid, C.nombre
from Cliente C, NVuelos NV
where C.cid=NV.cid and
	NV.nvu >= ALL (select NV2.nvu
					from NVuelos NV2
					where NV2.cid = NV.cid) and
	NV.alid = 'QFA' and
	C.tarjAlid <> 'QFA';
	
--11 Personas que visitaron mas ciudades en un periodo(fini,ffin) MAL

with APVisitados as (
	select distinct E.cid, AP.ciudad
	from Embarque E, Vuelo V, Aeropuerto AP
	where E.vid=V.vid and E.fecha>=fini and
		E.fecha<=ffin and
		(V.origen=AP.apid OR
		V.destino=AP.apid) )
	
With NCiudades as (
	select APV.cid, count(*) as nciu
	from APVisitados APV
	group by APV.cid)

select NC.cid, NC.nciu
from NCiudades NC
where NC.nciu >= ALL (select NC2.nciu from NCiudades NC2);


--12 Lista ordenada de aeropuertos y su rango; rango=nº total de vuelos
--   con origen en el aeropuerto; si dos empatan deben tener el mismo rango, y el siguiente numero
--   no aparecer  MAL

with NVuelos as (
	select V.origen, count(*) as nvu
	from Vuelo V
	group by V.origen )
	
select NV.apid, NV.nvu, (select count(*)+1
						from NVuelos NV2
						where NV2.nvu > NV.nvu) as rank
from NVuelos NV
order by rank desc;