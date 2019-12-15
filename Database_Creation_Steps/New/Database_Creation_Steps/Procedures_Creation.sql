USE [BBMS2]
GO
/****** Object:  StoredProcedure [dbo].[checkNationalID]    Script Date: 15-Dec-19 8:01:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE  [dbo].[checkNationalID]
@n_id bigint
AS
BEGIN
		SELECT national_id
		FROM donor
		WHERE national_id = @n_id
    
END

GO
/****** Object:  StoredProcedure [dbo].[checkUser]    Script Date: 15-Dec-19 8:01:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[checkUser]
@password nvarchar(50),
@username varchar(30)
AS
BEGIN
If EXISTS (
			SELECT * 
			FROM [login] 
			WHERE 
			[user_pass] = HASHBYTES('SHA2_512', @password) 
			AND 
			user_type = 'U'
			AND
			[username] = @username
			)
	BEGIN
		SELECT * FROM 
		[login] AS l JOIN [user] AS u ON l.[username] = u.[username] 
		JOIN [donor] AS d ON u.[national_id] = d.[national_id]
		WHERE l.username = @username
	END
END

GO
/****** Object:  StoredProcedure [dbo].[checkUsername]    Script Date: 15-Dec-19 8:01:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE  [dbo].[checkUsername]
@username varchar(30)
AS
BEGIN
		SELECT username
		FROM [login]
		WHERE username = @username

END


GO
/****** Object:  StoredProcedure [dbo].[deleteHospital]    Script Date: 15-Dec-19 8:01:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[deleteHospital] 
	@h_id INT
AS
BEGIN
	DELETE FROM [login] WHERE [login].username = (SELECT username FROM hospital WHERE hospital_id = @h_id)
	/*Then the delete cascade property will delete the hospital*/
END

GO
/****** Object:  StoredProcedure [dbo].[getHospitals]    Script Date: 15-Dec-19 8:01:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[getHospitals]
AS
BEGIN
	
	SELECT * FROM hospital
END

GO
/****** Object:  StoredProcedure [dbo].[getUserDonations]    Script Date: 15-Dec-19 8:01:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[getUserDonations] 
	@national_id bigint
AS
BEGIN
	SELECT bb.blood_bag_date, h.hospital_name
	FROM blood_bag AS bb JOIN hospital AS h ON bb.hospital_id = h.hospital_id
	WHERE bb.national_id = @national_id
END


GO
/****** Object:  StoredProcedure [dbo].[getUserHealthInfo]    Script Date: 15-Dec-19 8:01:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[getUserHealthInfo] 
	@national_id bigint
AS
BEGIN
	SELECT blood_pressure, glucose_level, notes, report_date
	FROM donor_health_info
	WHERE national_id = @national_id
END


GO
/****** Object:  StoredProcedure [dbo].[getUserServices]    Script Date: 15-Dec-19 8:01:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[getUserServices] 
	@national_id bigint
AS
BEGIN
	SELECT s.name, uus.service_use_date, h.hospital_name, hps.value
	FROM user_uses_service AS uus 
		 JOIN hospital AS h ON uus.hospital_id = h.hospital_id
		 JOIN hospital_provides_service AS hps ON (uus.hospital_id = hps.hospital_id AND uus.[service_id_s] = hps.[service_id_p])
		 JOIN [service] AS s ON s.service_id = uus.service_id_s
	WHERE uus.national_id = @national_id
END

GO
/****** Object:  StoredProcedure [dbo].[insert_admin]    Script Date: 15-Dec-19 8:01:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---------------------------------------------------------------

CREATE PROCEDURE [dbo].[insert_admin]
	@username varchar(30),
	@user_pass nvarchar(50)

AS
BEGIN
IF (
	NOT EXISTS (SELECT * FROM [login] WHERE username = @username)
	)
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
	END

END;


GO
/****** Object:  StoredProcedure [dbo].[insert_blood_camp]    Script Date: 15-Dec-19 8:01:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---------------------------------------------------------------

CREATE PROCEDURE [dbo].[insert_blood_camp]
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
/****** Object:  StoredProcedure [dbo].[insert_hospital]    Script Date: 15-Dec-19 8:01:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---------------------------------------------------------------

CREATE PROCEDURE [dbo].[insert_hospital]
	@username varchar(30),
	@user_pass nvarchar(50),
	@hospital_name varchar(30),
	@phone bigint,
	@city varchar(30),
	@governorate varchar(30)

AS
BEGIN
IF(
	NOT EXISTS (SELECT * FROM [login] WHERE username = @username)
	AND NOT EXISTS (SELECT * FROM [hospital] WHERE phone = @phone)
  )
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
		username,
		hospital_name,
		phone,
		city,
		governorate
	)
	VALUES
	(
		@username,
		@hospital_name,
		@phone,
		@city,
		@governorate
	)
   END
END;

GO
/****** Object:  StoredProcedure [dbo].[insert_service]    Script Date: 15-Dec-19 8:01:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------------------------------------

CREATE PROCEDURE [dbo].[insert_service]
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
/****** Object:  StoredProcedure [dbo].[insert_shift_manager]    Script Date: 15-Dec-19 8:01:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------------------------------------

CREATE PROCEDURE [dbo].[insert_shift_manager]
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
		username,
		name
	)
	VALUES
	(
		@username,
		@name
	)

END;
GO
/****** Object:  StoredProcedure [dbo].[insert_user]    Script Date: 15-Dec-19 8:01:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[insert_shift_manager]    Script Date: 15-Dec-19 12:41:09 AM ******/
CREATE PROCEDURE [dbo].[insert_user]
	@username varchar(30),
	@user_pass nvarchar(50),
	@national_id bigint,
	@name varchar(30),
	@gender char(1),
	@age tinyint,
	@phone varchar(11),
	@city varchar(30),
	@governorate varchar(30)

AS
BEGIN
IF (
	NOT EXISTS (SELECT * FROM [login] WHERE username = @username)
	AND NOT EXISTS (SELECT * FROM [donor] WHERE phone = @phone)
	AND NOT EXISTS (SELECT * FROM [donor] WHERE national_id = @national_id)
	)
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
	END
END;
GO
/****** Object:  StoredProcedure [dbo].[insert_volunteer]    Script Date: 15-Dec-19 8:01:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---------------------------------------------------------------

CREATE PROCEDURE [dbo].[insert_volunteer]
	@national_id bigint,
	@name varchar(30),
	@gender char(1),
	@age tinyint,
	@phone varchar(11),
	@city varchar(30),
	@governorate varchar(30)

AS
BEGIN
	IF (
		NOT EXISTS (SELECT * FROM [donor] WHERE phone = @phone)
		AND NOT EXISTS (SELECT * FROM [donor] WHERE national_id = @national_id)
		)
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
	END

END;


GO
