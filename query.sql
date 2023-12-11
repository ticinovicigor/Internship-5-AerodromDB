---ispis imena i modela svih aviona s kapacitetom većim od 100
SELECT Name, Model FROM Planes pl
WHERE pl.EconomyCapacity + pl. BusinessCapacity > 100

---ispis svih karata čija je cijena između 100 i 200 eura
SELECT * FROM Tickets tk
WHERE tk.Price BETWEEN 100 AND 200

---ispis svih pilotkinja s više od 20 odrađenih letova do danas
---SELECT * FROM Pilots pt
---WHERE (SELECT COUNT(*) FROM Flights fl WHERE fl.PilotId = pt.PilotId AND fl.TimeOfArrival <= NOW()) > 20
---TO DO: Composite PilotFlights

---ispis svih domaćina/ca zrakoplova koji su trenutno u zraku

---ispis broja letova u Split/iz Splita 2023. godine
SELECT Count(*) FROM Flights fl
WHERE ((fl.PlaceOfArrival = 'Split' OR fl.PlaceOfDeparture = 'Split')  AND DATE_PART('year', fl.TimeOfArrival) = 2023)

---ispis svih letova za Beč u prosincu 2023.
SELECT * FROM Flights fl
WHERE fl.PlaceOfArrival = 'Vienna' AND DATE_PART('month', fl.TimeOfArrival) = 12

---ispis broj prodanih Economy letova kompanije AirDUMP u 2021.

---ispis prosječne ocjene letova kompanije AirDUMP

---ispis svih aerodroma u Londonu, sortiranih po broju Airbus aviona trenutno na njihovim pistama

---ispis svih aerodroma udaljenih od Splita manje od 1500km

---smanjite cijenu za 20% svim kartama čiji letovi imaju manje od 20 ljudi
UPDATE Tickets
	SET Price = Price * 0.8
	WHERE (SELECT COUNT(*) FROM Tickets tk WHERE FlightId = tk.FlightId) < 20

---povisite plaću za 100 eura svim pilotima koji su ove godine imali više od 10 letova duljih od 10 sati
---UPDATE Pilots
---	SET Paycheck = Paycheck + 100
---	WHERE (SELECT COUNT(*) FROM Flights) > 10
---FLIGHTPILOTS!!!

---razmontirajte avione starije od 20 godina koji nemaju letove pred sobom
UPDATE Planes
	SET PlaneCondition = 'razmontiran'
	WHERE 
---izbrišite sve letove koji nemaju ni jednu prodanu kartu

---izbrišite sve kartice vjernosti putnika čije prezime završava na -ov/a, -in/a
