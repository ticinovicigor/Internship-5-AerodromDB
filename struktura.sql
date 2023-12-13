CREATE TABLE Cities(
	CityId SERIAL PRIMARY KEY,
	Name VARCHAR NOT NULL UNIQUE,
	GeoLocation POINT
);

CREATE TABLE Airports(
	AirportId SERIAL PRIMARY KEY,
	Name VARCHAR NOT NULL,
	HangarCapacity INT,
	RunwayCapacity INT,
	GeoLocation POINT,
	CityId INT REFERENCES Cities(CityId)
);

CREATE TABLE Airlines(
	AirlineId SERIAL PRIMARY KEY,
	Name VARCHAR NOT NULL UNIQUE
);

CREATE TABLE Planes(
	PlaneId SERIAL PRIMARY KEY,
	name VARCHAR NOT NULL,
	Model VARCHAR NOT NULL,
	PlaneCondition VARCHAR NOT NULL,
	BusinessCapacity INT,
	EconomyCapacity INT,
	AirlineId INT REFERENCES Airlines(AirlineId),
	DateOfManufacture TIMESTAMP
);

CREATE TABLE Flights(
	FlightId SERIAL PRIMARY KEY,
	PlaneId INT REFERENCES Planes(PlaneId),
	TimeOfDeparture TIMESTAMP,
	TimeOfArrival TIMESTAMP,
	PlaceOfDeparture INT REFERENCES Airports(AirportId),
	PlaceOfArrival INT REFERENCES Airports(AirportId)
);

---ALTER TABLE Flights
	---ADD CONSTRAINT PlaneActivity CHECK((SELECT COUNT(*) FROM Planes pl WHERE pl.PlaneId = PlaneId AND pl.PlaneCondition = 'aktivan')>0)


CREATE TABLE Users(
	UserId SERIAL PRIMARY KEY,
	Name VARCHAR NOT NULL
);

CREATE TABLE LoyaltyCards(
	LoyaltyCardId SERIAL PRIMARY KEY,
	UserId INT REFERENCES Users(UserId),
	ExpirationDate TIMESTAMP
);

CREATE TABLE Pilots(
	PilotId SERIAL PRIMARY KEY,
	Name VARCHAR NOT NULL,
	DateOfBirth TIMESTAMP,
	Paycheck INT,
	IsFemale BOOL
);

CREATE TABLE Crewmembers(
	CrewmemberId SERIAL PRIMARY KEY,
	Name VARCHAR NOT NULL,
	IsFemale BOOL
);



CREATE TABLE Tickets(
	TicketId SERIAL PRIMARY KEY,
	FlightId INT REFERENCES Flights(FlightId),
	Price FLOAT,
	IsBusiness BOOL,
	UserId INT REFERENCES Users(UserId),
	Grade INT,
	DateOfPurchase TIMESTAMP
);

CREATE TABLE PilotFlights(
	PilotId INT REFERENCES Pilots(PilotId),
	FlightId INT REFERENCES Flights(FlightId),
	
	PRIMARY KEY(PilotId, FlightId)
);

CREATE TABLE CrewmemberFlights(
	CrewmemberId INT REFERENCES Crewmembers(CrewmemberId),
	FlightId INT REFERENCES Flights(FlightId),
	
	PRIMARY KEY(CrewmemberId, FlightId)
);