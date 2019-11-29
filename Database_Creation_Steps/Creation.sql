--Creating database--
CREATE DATABASE BBMS	--BBMS : Blood bank management system--
GO


USE BBMS
---------------------------------------------------Creating tables-----------------------------------------------------
CREATE TABLE [login]
(
	username varchar(30) PRIMARY KEY,
	user_pass BINARY(64) NOT NULL,
	user_type char(1) NOT NULL CHECK(user_type = 'A' OR user_type = 'U' OR user_type = 'H' OR user_type = 'S')
	
)

CREATE TABLE [donor]
(
	national_id bigint,
	name varchar(30) NOT NULL,
	gender char(1) NOT NULL CHECK (gender = 'M' OR gender = 'F'),
	age tinyint NOT NULL CHECK(age >= 18 AND age <= 65),
	phone bigint NOT NULL,
	city varchar(30)NOT NULL,
	governorate varchar(30) NOT NULL,
	blood_type varchar(3) CHECK (blood_type = 'A+' OR blood_type = 'A-' OR blood_type = 'B+' OR blood_type = 'B-' OR blood_type = 'O+' OR blood_type = 'O-' OR blood_type = 'AB+' OR blood_type = 'AB-'),
	PRIMARY KEY(national_id)

)

CREATE TABLE [user] 
(
	national_id bigint PRIMARY KEY,
	points int NOT NULL DEFAULT 0,
	username varchar(30) NOT NULL UNIQUE,

	FOREIGN KEY ([national_id]) REFERENCES [donor] ON DELETE CASCADE,	--it is the pk (this will never happen)
	FOREIGN KEY (username) REFERENCES [login] ON DELETE CASCADE	--if the user is deleted from log in table then he is no longer in the system
)

--CREATE TABLE [volunteer]
--(
 --NOT IMPLEMENTED!
--)
CREATE TABLE [hospital]
(
	hospital_id int IDENTITY(1,1) PRIMARY KEY,
	username varchar(30) NOT NULL UNIQUE,
	hospital_name varchar(30) NOT NULL,
	phone bigint NOT NULL,
	city varchar(30)NOT NULL,
	governorate varchar(30) NOT NULL,
	
	FOREIGN KEY (username) REFERENCES [login] ON DELETE CASCADE --if the hospital is deleted from log in table then it is no longer in the system
)

CREATE TABLE [donor_health_info]
(
	national_id bigint,
	hospital_id int,
	report_date date,
	blood_pressure varchar(10),
	glucose_level varchar(10),
	notes varchar(500),

	FOREIGN KEY (national_id) REFERENCES [donor] ON DELETE CASCADE, --included in the pk
	FOREIGN KEY (hospital_id) REFERENCES [hospital] ON DELETE CASCADE, --included in pk
	PRIMARY KEY (national_id, hospital_id, report_date)
)



CREATE TABLE [blood_camp]
(
	blood_camp_id int IDENTITY(1,1) PRIMARY KEY,
	hospital_id int NOT NULL,
	driver_name varchar(30),

	FOREIGN KEY (hospital_id) REFERENCES [hospital] ON DELETE CASCADE
)

CREATE TABLE [shift_manager]
(
	username varchar(30) PRIMARY KEY,
	name varchar(30) NOT NULL,

	FOREIGN KEY (username) REFERENCES [login] ON DELETE CASCADE	--if he is deleted from login table then he is no longer on the system
)

CREATE TABLE [shift]
(
	blood_camp_id int,
	shift_date date,
	shift_manager_username varchar(30),
	start_hour tinyint NOT NULL CHECK(start_hour BETWEEN 0 AND 23),
	finish_hour tinyint NOT NULL CHECK(finish_hour BETWEEN 0 AND 23),
	city varchar(30) NOT NULL,
	governorate varchar(30) NOT NULL,

	FOREIGN KEY (blood_camp_id) REFERENCES [blood_camp] ON DELETE CASCADE,  --included in pk
	FOREIGN KEY (shift_manager_username) REFERENCES [shift_manager] ON DELETE NO ACTION, -- VIPPPPPPPP !!!!!
	PRIMARY KEY(blood_camp_id, shift_date)

)


CREATE TABLE [blood_bag]
(
	blood_bag_id int IDENTITY(1,1) PRIMARY KEY,
	national_id bigint,
	blood_bag_date date,
	blood_camp_id int,
	hospital_id int,
	notes varchar(500),

	FOREIGN KEY (national_id) REFERENCES [donor] ON DELETE SET NULL,
	FOREIGN KEY (blood_camp_id, blood_bag_date) REFERENCES [shift] ON DELETE SET NULL,
	FOREIGN KEY (hospital_id) REFERENCES [hospital] ON DELETE NO ACTION -- VIPPPPPP!!!
	--PRIMARY KEY (national_id, blood_camp_id, blood_bag_date, hospital_id)
)

CREATE TABLE [service]
(
	name varchar(30) PRIMARY KEY
)
CREATE TABLE [hospital_provides_service]
(
	hospital_id int,
	[service_name] varchar(30),
	value int NOT NULL DEFAULT 0

	FOREIGN KEY (hospital_id) REFERENCES [hospital] ON DELETE CASCADE, --if the hospital is deleted then its data should be deleted
	FOREIGN KEY ([service_name]) REFERENCES [service] ON DELETE CASCADE, --will not happen but if we wish to delete a service then it should be deleted from all relations
	PRIMARY KEY(hospital_id, [service_name])
)
CREATE TABLE [user_uses_service]
(
	service_id int IDENTITY(1,1) PRIMARY KEY,
	national_id bigint,
	hospital_id int,
	[service_name] varchar(30),
	service_use_date date,

	FOREIGN KEY (hospital_id, [service_name]) REFERENCES [hospital_provides_service] ON DELETE SET NULL,
	FOREIGN KEY (national_id) REFERENCES [user] ON DELETE NO ACTION --VIPPPPP!!!

	--PRIMARY KEY (hospital_id, national_id, [service_name], service_use_date)
)

---------------------------------------------------Creating Procedures-----------------------------------------------------

CREATE PROCEDURE insert_user
	@username varchar(30),
	@user_pass nvarchar(50),
	@national_id bigint,
	@name varchar(30),
	@gender char(1),
	@age tinyint,
	@phone bigint,
	@city varchar(30),
	@governorate varchar(30)

AS
BEGIN
	INSERT INTO [login]
	(
		username,
		user_pass,
		user_type
	)
	VALUES
	(
		@username, 
		HASHBYTES('SHA2_512', @user_pass),
		'U'
	)

	INSERT INTO [donor]
	(
		national_id, 
		name, 
		gender,
		age,
		phone,
		city,
		governorate
	)
	VALUES
	(
		@national_id, 
		@name, 
		@gender,
		@age,
		@phone,
		@city,
		@governorate
	)

	INSERT INTO [user]
	(
		national_id,
		username,
		points
	)
	VALUES
	(
		@national_id,
		@username,
		0
	)

END;

GO
-------------------------------------------------------------

CREATE PROCEDURE insert_volunteer
	@national_id bigint,
	@name varchar(30),
	@gender char(1),
	@age tinyint,
	@phone bigint,
	@city varchar(30),
	@governorate varchar(30)

AS
BEGIN

	INSERT INTO [donor]
	(
		national_id, 
		name, 
		gender,
		age,
		phone,
		city,
		governorate
	)
	VALUES
	(
		@national_id, 
		@name, 
		@gender,
		@age,
		@phone,
		@city,
		@governorate
	)

END;
GO
-------------------------------------------------------------

CREATE PROCEDURE insert_hospital
	@username varchar(30),
	@user_pass nvarchar(50),
	@hospital_name varchar(30),
	@phone bigint,
	@city varchar(30),
	@governorate varchar(30)

AS
BEGIN
	INSERT INTO [login]
	(
		username,
		user_pass,
		user_type
	)
	VALUES
	(
		@username, 
		HASHBYTES('SHA2_512', @user_pass),
		'H'
	)

	INSERT INTO [hospital]
	(
		hospital_name,
		phone,
		city,
		governorate
	)
	VALUES
	(
		@hospital_name,
		@phone,
		@city,
		@governorate
	)

END;
GO
---------------------------------------------------------------

CREATE PROCEDURE insert_admin
	@username varchar(30),
	@user_pass nvarchar(50)

AS
BEGIN
	INSERT INTO [login]
	(
		username,
		user_pass,
		user_type
	)
	VALUES
	(
		@username, 
		HASHBYTES('SHA2_512', @user_pass),
		'A'
	)

END;
GO
---------------------------------------------------------------

CREATE PROCEDURE insert_blood_camp
	@hospital_id int,
	@driver_name varchar(30)

AS
BEGIN
	INSERT INTO [blood_camp]
	(
		hospital_id,
		driver_name
	)
	VALUES
	(
		@hospital_id,
		@driver_name
	)

END;
GO
------------------------------------------------------------------

CREATE PROCEDURE insert_shift_manager
	@username varchar(30),
	@user_pass nvarchar(50),
	@name varchar(30)

AS
BEGIN
	INSERT INTO [login]
	(
		username,
		user_pass,
		user_type
	)
	VALUES
	(
		@username, 
		HASHBYTES('SHA2_512', @user_pass),
		'S'
	)
	INSERT INTO [shift_manager]
	(
		name
	)
	VALUES
	(
		@name
	)

END;
GO
------------------------------------------------------------------

CREATE PROCEDURE [insert_service]
	@name varchar(30)

AS
BEGIN
	INSERT INTO [service]
	(
		name
	)
	VALUES
	(
		@name
	)
	

END;
GO