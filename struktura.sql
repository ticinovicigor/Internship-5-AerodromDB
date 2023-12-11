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
	Name VARCHAR NOT NULL
);

CREATE TABLE Planes(
	PlaneId SERIAL PRIMARY KEY,
	Name VARCHAR NOT NULL,
	Model VARCHAR NOT NULL,
	PlaneCondition VARCHAR NOT NULL,
	BusinessCapacity INT,
	EconomyCapacity INT,
	AirlineId INT REFERENCES Airlines(AirlineId)
);

CREATE TABLE Flights(
	FlightId SERIAL PRIMARY KEY,
	PlaneId INT REFERENCES Planes(PlaneId),
	TimeOfDeparture TIMESTAMP,
	TimeOfArrival TIMESTAMP,
	PlaceOfDeparture VARCHAR REFERENCES Cities(Name),
	PlaceOfArrival vARCHAR REFERENCES Cities(Name),
	TicketsSold INT
);

CREATE TABLE Users(
	UserId SERIAL PRIMARY KEY,
	Name VARCHAR NOT NULL,
	TicketsPurchased INT,
	HasLoyaltyCard BOOL
);

CREATE TABLE Pilots(
	PilotId SERIAL PRIMARY KEY,
	Name VARCHAR NOT NULL,
	DateOfBirth TIMESTAMP
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
	UserId INT REFERENCES Users(UserId),
	Grade INT
);