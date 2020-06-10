/* 1. Quantitat de registres de la taula de vols: */
SELECT COUNT(*) FROM usairlineflights2.flights;

/*2. Retard promig de sortida i arribada segons l’aeroport origen.*/
SELECT DISTINCT(A.IATA) AS Origin, AVG(B.ArrDelay) AS prom_arribades, AVG(B.DepDelay) AS prom_sortides 
  FROM usairlineflights2.flights B,
       usairlineflights2.usairports A
WHERE A.IATA = B.Origin
GROUP BY A.IATA
ORDER BY A.IATA;

/*3. Retard promig d’arribada dels vols, per mesos, anys i segons l’aeroport origen.
A més, volen que els resultat es mostrin de la següent forma (fixa’t en l’ordre de les files):*/
SELECT DISTINCT(A.IATA) AS Origin, B.colYear AS Any, B.colMonth AS Mes, AVG(B.ArrDelay) AS Prom_arribades 
  FROM usairlineflights2.flights B,
       usairlineflights2.usairports A
WHERE A.IATA = B.Origin
GROUP BY A.IATA, b.colYear, b.colMonth
ORDER BY A.IATA;

/*4. Retard promig d’arribada dels vols, per mesos, anys i segons l’aeroport origen (mateixa consulta que abans 
i amb el mateix ordre). Però a més, ara volen que en comptes del codi de l’aeroport es mostri el nom de la ciutat*/
SELECT DISTINCT(A.City) AS Ciutat, B.colYear AS Any, B.colMonth AS Mes, AVG(B.ArrDelay) AS Prom_arribades 
  FROM usairlineflights2.flights B,
       usairlineflights2.usairports A
WHERE A.IATA = B.Origin
GROUP BY A.City, b.colYear, b.colMonth
ORDER BY A.City;

/*5. Les companyies amb més vols cancelats, per mesos i any. A més, han d’estar ordenades de forma que les companyies 
amb més cancel·lacions apareguin les primeres.*/
SELECT DISTINCT(UniqueCarrier) AS Companyia, colYear AS Any, colMonth AS Mes, sum(Cancelled) AS Total_cancelacions 
  FROM usairlineflights2.flights
GROUP BY UniqueCarrier, colYear, colMonth
ORDER BY Total_cancelacions desc;

/*6. L’identificador dels 10 avions que més distància han recorregut fent vols. (Ojo que hay compañías que no tienen informado
el campo TailNum)*/
SELECT TailNum, sum(Distance) as Total_distance 
  FROM usairlineflights2.flights
  group by TailNum
ORDER BY Total_distance desc
LIMIT 10;

/* 7. Companyies amb el seu retard promig només d’aquelles les quals els seus vols arriben
 al seu destí amb un retràs promig major de 10 minuts.*/
 SELECT UniqueCarrier, avg(ArrDelay) as Media_Retard
  FROM usairlineflights2.flights
  GROUP BY UniqueCarrier
  HAVING Media_Retard > 10
ORDER BY Media_Retard desc;
 

