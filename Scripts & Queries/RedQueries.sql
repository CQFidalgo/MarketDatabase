--2Devolver el numero de amigos de cada persona (nombre)  BIEN
select P.nombre,count(*)
from Persona P, Amistad A
where P.pid=A.pid1
group by P.pid;

--3Seleccionar a la(s) persona(s) con mas numero de amigos  MAL
with NAmigos as
	(select A.pid1 as pid, count(*) as nam
	from Amistad A
	group by A.pid1)

select P.nombre, NA.nam
from Persona P, Namigos NA
	where P.pid = NA.pid and
	NA.nam = select max(NA2.nam)
		from NAmigos NA2;
		
--4Obtener los nombres de las personas que no han realizado ninguna entrada de estado BIEN
select P.nombre
from Persona P
where P.pid not in (select E.pid
				from Estado E);

--5Para cada persona que haya actualizado al menos dos veces el estado, determinar el tiempo 
--en que han ocurrido estas actualizaciones  BIEN
select T.pid, (T.fult-T.fpri) as tiempo
from ( select E.pid,max(E.f_modif) as fult,
					min(E.f_modif) as fpri
		from Estado E
		group by E.pid
		having count(*)>1
	) T;

--6Contar el numero de amigos de 'nivel dos' (amigos, y amigos de amigos)de la persona 'x'
--(cuidado con no contar a la misma persona dos veces)
select count(*)-1
from (
	(select P.pid, A2.pid2
	from Persona P, Amistad A1, Amistad A2
	where P.pid=A1.pid1 and A1.pid2=A2.pid1 and
	P.nombre like 'X%'
	)
union
	(select P.pid, A1.pid2
	from Persona P, Amistad A1
	where P.pid=A1.pid1 and
	P.nombre like 'X%'
	)
	) red1y2;

--7Encontrar a las 5 personas con mayor numero de amigos BIEN
with NAmigos as (
select P.nombre, count(*) as nam
	from Persona P, Amistad A
	where P.pid=A.pid1
	group by P.pid )
	
select NA.nombre,NA.nam
from NAmigos NA
where 5 > ( select count(*)
	from NAmigos NA2
	where NA2.nam > NA.nam
	);

--8Obtener el ratio de cohesion de cada grupo (nro de enlaces entre miembros / nro maximo de
--enlaces posibles entre los miembros) MAL

select GE.gid, GE.ne/(GM.nme*(GM.nme-1)/2)
from ( select M1.gid,count(*)/2 as ne
	from Miembro M1, Miembro M2
	where M1.gid=M2.gid and
		(M1.pid,M2.pid) in ( select * from Amistad)
	group by M1.gid
	) GE,
	( select M.gid,count(*) as nme
		from Miembro M
		group by M.gid
	) GM
where GE.gid=GM.gid
order by GE.gid;

--9Encontrar a las dos personas que hayan nacido con fechas mas cercanas (sin contar las que han
--nacido en la misma fecha) BIEN

with Difs as (
	select P1.nombre as nom1, P2.nombre as nom2,
		abs(P1.f_nacim - P2.f_nacim) as dif
	from Persona P1, Persona P2
	where P1.pid<>P2.pid and abs(P1.f_nacim - P2.f_nacim)>0 )

select DF.nom1,DF.nom2
from Difs DF
where DF.dif = ( select min(DF2.dif)
				from Difs DF2
				);