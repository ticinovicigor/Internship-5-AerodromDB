---ispis imena i modela svih aviona s kapacitetom većim od 100
SELECT Name, Model FROM Planes pl
WHERE pl.EconomyCapacity + pl. BusinessCapacity > 100

---ispis svih karata čija je cijena između 100 i 200 eura
SELECT * FROM Tickets tk
WHERE tk.Price BETWEEN 100 AND 200

---ispis svih pilotkinja s više od 20 odrađenih letova do danas
SELECT * FROM Pilots pt
	WHERE (SELECT COUNT(*) FROM Flights ft 
		   WHERE DATE_PART('second', NOW() - ft.TimeOfArrival) > 0 
		   AND (SELECT COUNT(*) FROM PilotFlights pf 
				WHERE (ft.FlightId = pf.FlightId) AND (pt.PilotId = pf.PilotId)) > 0) > 20

---ispis svih domaćina/ca zrakoplova koji su trenutno u zraku
SELECT * FROM Crewmembers cw
	WHERE (SELECT COUNT(*) FROM Flights ft 
		   WHERE (NOW() BETWEEN ft.TimeOfDeparture AND ft.TimeOfArrival) 
		   AND (SELECT COUNT(*) FROM CrewmemberFlights cf 
				WHERE cf.CrewmemberId = cw.CrewmemberId AND cf.FlightId = ft.FlightId)>0) > 0

---ispis broja letova u Split/iz Splita 2023. godine
SELECT Count(*) FROM Flights fl
WHERE ((SELECT COUNT(*) FROM Cities ct
	   WHERE ct.Name = 'Split' 
	   AND(fl.PlaceOfArrival = ct.CityId OR fl.PlaceOfDeparture = ct.CityId))>0  
	   AND DATE_PART('year', fl.TimeOfArrival) = 2023)

---ispis svih letova za Beč u prosincu 2023.
SELECT * FROM Flights fl
WHERE (SELECT COUNT(*) FROM Cities ct
	   WHERE ct.Name = 'Vienna' 
	   AND(fl.PlaceOfArrival = ct.CityId))>0 
	   AND DATE_PART('month', fl.TimeOfArrival) = 12

---ispis broj prodanih Economy letova kompanije AirDUMP u 2021.
SELECT COUNT(*) FROM Tickets tk
WHERE tk.IsBusiness = FALSE 
		AND DATE_PART('year', tk.DateOfPurchase) = 2021 
		AND(SELECT COUNT(*) FROM Flights ft WHERE ft.FlightId = tk.FlightId 
		AND(SELECT COUNT(*) FROM Planes pl WHERE pl.PlaneId = ft.FlightId
		AND(SELECT COUNT(*) FROM Airlines al WHERE 	al.AirlineId = pl.AirlineId AND al.Name = 'DUMPAir')>0)>0)>0

---ispis prosječne ocjene letova kompanije AirDUMP
SELECT AVG(Grade) FROM Tickets tk
WHERE (SELECT COUNT(*) FROM Flights ft WHERE ft.FlightId = tk.FlightId 
	   AND(SELECT COUNT(*) FROM Planes pl WHERE pl.PlaneId = ft.FlightId
	   AND(SELECT COUNT(*) FROM Airlines al WHERE al.AirlineId = pl.AirlineId AND al.Name = 'AirDUMP')>0)>0)>0

---ispis svih aerodroma u Londonu, sortiranih po broju Airbus aviona trenutno na njihovim pistama
SELECT * FROM Airports ap
WHERE (SELECT COUNT(*) FROM Cities ct WHERE ct.Name = 'London' AND ct.CityId = ap.CityId)>0
ORDER BY (SELECT COUNT(*) FROM Flights ft 
		  WHERE DATE_PART('minute', ft.TimeOfDeparture - NOW()) BETWEEN 0 AND 30
		  AND (SELECT COUNT(*) FROM Planes pl WHERE pl.PlaneId = ft.FlightId AND pl.Model = 'Airbus') > 0
		 ) DESC

---smanjite cijenu za 20% svim kartama čiji letovi imaju manje od 20 ljudi
UPDATE Tickets
	SET Price = Price * 0.8
	WHERE (SELECT COUNT(*) FROM Tickets tk WHERE FlightId = tk.FlightId) < 20

---povisite plaću za 100 eura svim pilotima koji su ove godine imali više od 10 letova duljih od 10 sati
UPDATE Pilots
	SET Paycheck = Paycheck + 100
	WHERE (SELECT COUNT(*) FROM Flights ft
		   WHERE (DATE_PART('hour', ft.TimeOfArrival - ft.TimeOfDeparture) >= 10) 
		   AND DATE_PART('year', NOW()) = DATE_PART('year', TimeOfArrival) 
		   AND DATE_PART('second', NOW() - ft.TimeOfArrival) > 0
		   AND (SELECT COUNT(*) FROM PilotFlights pf WHERE pf.PilotId = PilotId AND pf.FlightId = ft.FlightId)>0
		  ) > 10


---razmontirajte avione starije od 20 godina koji nemaju letove pred sobom
UPDATE Planes
	SET PlaneCondition = 'razmontiran'
	WHERE (DATE_PART('year', NOW() - DateOfManufacture) >= 20 AND (SELECT COUNT(*) FROM Flights fl WHERE fl.PlaneId = PlaneId) = 0)

---izbrišite sve letove koji nemaju ni jednu prodanu kartu
DELETE FROM Flights
	WHERE (SELECT COUNT(*) FROM Tickets tk WHERE tk.FlightId = FlightId) = 0

---izbrišite sve kartice vjernosti putnika čije prezime završava na -ov/a, -in/a
DELETE FROM LoyaltyCards
	WHERE (SELECT COUNT(*) FROM Users u 
		   WHERE ((u.Name LIKE '%ov' OR u.Name LIKE '%ova' OR u.Name LIKE '%in' OR u.Name LIKE '%ina') 
				  AND u.UserId = UserId)) > 0
	
	