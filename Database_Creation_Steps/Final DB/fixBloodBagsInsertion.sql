USE [BBMS2]
GO
/****** Object:  StoredProcedure [dbo].[AddBloodBag]    Script Date: 22-Dec-19 1:15:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER Procedure [dbo].[AddBloodBag] 	-- Add the parameters for the stored procedure here


@national_id bigint,
@blood_bag_date date,
@blood_camp_id int,
@hospital_id int,
@notes varchar(500),
@blood_type varchar(3)




AS
BEGIN
	
	insert into blood_bag values(@national_id,@blood_bag_date,@blood_camp_id,@hospital_id,@notes,@blood_type)
	if (@@ROWCOUNT > 0)	/*If the insertion is successful*/
	BEGIN
		UPDATE [donor]
		SET blood_type = @blood_type
		WHERE national_id = @national_id
	END
END
