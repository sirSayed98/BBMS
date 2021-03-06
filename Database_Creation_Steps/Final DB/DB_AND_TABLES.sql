CREATE DATABASE BBMS2
GO

USE [BBMS2]
GO
/****** Object:  Table [dbo].[blood_bag]    Script Date: 22-Dec-19 2:34:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[blood_bag](
	[blood_bag_id] [int] IDENTITY(1,1) NOT NULL,
	[national_id] [bigint] NULL,
	[blood_bag_date] [date] NULL,
	[blood_camp_id] [int] NULL,
	[hospital_id] [int] NULL,
	[notes] [varchar](500) NULL,
	[blood_type] [varchar](3) NULL,
PRIMARY KEY CLUSTERED 
(
	[blood_bag_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[blood_camp]    Script Date: 22-Dec-19 2:34:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[blood_camp](
	[blood_camp_id] [int] IDENTITY(1,1) NOT NULL,
	[hospital_id] [int] NOT NULL,
	[driver_name] [varchar](30) NULL,
PRIMARY KEY CLUSTERED 
(
	[blood_camp_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[donor]    Script Date: 22-Dec-19 2:34:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[donor](
	[national_id] [bigint] NOT NULL,
	[name] [varchar](30) NOT NULL,
	[gender] [char](1) NOT NULL,
	[age] [tinyint] NOT NULL,
	[phone] [bigint] NOT NULL,
	[city] [varchar](30) NOT NULL,
	[governorate] [varchar](30) NOT NULL,
	[blood_type] [varchar](3) NULL,
PRIMARY KEY CLUSTERED 
(
	[national_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[donor_health_info]    Script Date: 22-Dec-19 2:34:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[donor_health_info](
	[national_id] [bigint] NOT NULL,
	[hospital_id] [int] NOT NULL,
	[report_date] [date] NOT NULL,
	[blood_pressure] [varchar](10) NULL,
	[glucose_level] [varchar](10) NULL,
	[notes] [varchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[national_id] ASC,
	[hospital_id] ASC,
	[report_date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[hospital]    Script Date: 22-Dec-19 2:34:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[hospital](
	[hospital_id] [int] IDENTITY(1,1) NOT NULL,
	[username] [varchar](30) NOT NULL,
	[hospital_name] [varchar](30) NOT NULL,
	[phone] [bigint] NOT NULL,
	[city] [varchar](30) NOT NULL,
	[governorate] [varchar](30) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[hospital_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[hospital_provides_service]    Script Date: 22-Dec-19 2:34:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[hospital_provides_service](
	[hospital_id] [int] NOT NULL,
	[service_id_p] [int] NOT NULL,
	[value] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[hospital_id] ASC,
	[service_id_p] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[login]    Script Date: 22-Dec-19 2:34:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[login](
	[username] [varchar](30) NOT NULL,
	[user_pass] [binary](64) NOT NULL,
	[user_type] [char](1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[notifications]    Script Date: 22-Dec-19 2:34:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[notifications](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[username] [varchar](30) NOT NULL,
	[info] [varchar](500) NULL,
	[date] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[service]    Script Date: 22-Dec-19 2:34:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[service](
	[name] [varchar](30) NOT NULL,
	[service_id] [int] IDENTITY(1,1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[service_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[shift]    Script Date: 22-Dec-19 2:34:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[shift](
	[blood_camp_id] [int] NOT NULL,
	[shift_date] [date] NOT NULL,
	[shift_manager_username] [varchar](30) NULL,
	[start_hour] [time](7) NULL,
	[finish_hour] [time](7) NULL,
	[city] [varchar](30) NOT NULL,
	[governorate] [varchar](30) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[blood_camp_id] ASC,
	[shift_date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[shift_manager]    Script Date: 22-Dec-19 2:34:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[shift_manager](
	[username] [varchar](30) NOT NULL,
	[name] [varchar](30) NOT NULL,
	[hospital_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[user]    Script Date: 22-Dec-19 2:34:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[user](
	[national_id] [bigint] NOT NULL,
	[points] [int] NOT NULL DEFAULT ((0)),
	[username] [varchar](30) NOT NULL,
	[donation_count] [int] NULL CONSTRAINT [df_donation_cnt]  DEFAULT ((0)),
PRIMARY KEY CLUSTERED 
(
	[national_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[user_uses_service]    Script Date: 22-Dec-19 2:34:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[user_uses_service](
	[user_service_id] [int] IDENTITY(1,1) NOT NULL,
	[national_id] [bigint] NULL,
	[hospital_id] [int] NULL,
	[service_id_s] [int] NULL,
	[service_use_date] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[user_service_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[hospital_provides_service] ADD  DEFAULT ((0)) FOR [value]
GO
ALTER TABLE [dbo].[blood_bag]  WITH CHECK ADD FOREIGN KEY([blood_camp_id], [blood_bag_date])
REFERENCES [dbo].[shift] ([blood_camp_id], [shift_date])
GO
ALTER TABLE [dbo].[blood_bag]  WITH CHECK ADD FOREIGN KEY([hospital_id])
REFERENCES [dbo].[hospital] ([hospital_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[blood_bag]  WITH CHECK ADD FOREIGN KEY([national_id])
REFERENCES [dbo].[donor] ([national_id])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[blood_camp]  WITH CHECK ADD FOREIGN KEY([hospital_id])
REFERENCES [dbo].[hospital] ([hospital_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[donor_health_info]  WITH CHECK ADD FOREIGN KEY([hospital_id])
REFERENCES [dbo].[hospital] ([hospital_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[donor_health_info]  WITH CHECK ADD FOREIGN KEY([national_id])
REFERENCES [dbo].[donor] ([national_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[hospital]  WITH CHECK ADD FOREIGN KEY([username])
REFERENCES [dbo].[login] ([username])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[hospital_provides_service]  WITH CHECK ADD FOREIGN KEY([hospital_id])
REFERENCES [dbo].[hospital] ([hospital_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[hospital_provides_service]  WITH CHECK ADD FOREIGN KEY([service_id_p])
REFERENCES [dbo].[service] ([service_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[notifications]  WITH CHECK ADD FOREIGN KEY([username])
REFERENCES [dbo].[user] ([username])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[shift]  WITH CHECK ADD FOREIGN KEY([blood_camp_id])
REFERENCES [dbo].[blood_camp] ([blood_camp_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[shift]  WITH CHECK ADD  CONSTRAINT [shft_mgr_FK_1] FOREIGN KEY([shift_manager_username])
REFERENCES [dbo].[shift_manager] ([username])
GO
ALTER TABLE [dbo].[shift] CHECK CONSTRAINT [shft_mgr_FK_1]
GO
ALTER TABLE [dbo].[shift_manager]  WITH CHECK ADD FOREIGN KEY([username])
REFERENCES [dbo].[login] ([username])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[shift_manager]  WITH CHECK ADD  CONSTRAINT [hospital_id_FK] FOREIGN KEY([hospital_id])
REFERENCES [dbo].[hospital] ([hospital_id])
GO
ALTER TABLE [dbo].[shift_manager] CHECK CONSTRAINT [hospital_id_FK]
GO
ALTER TABLE [dbo].[user]  WITH CHECK ADD FOREIGN KEY([national_id])
REFERENCES [dbo].[donor] ([national_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[user]  WITH CHECK ADD FOREIGN KEY([username])
REFERENCES [dbo].[login] ([username])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[user_uses_service]  WITH CHECK ADD FOREIGN KEY([national_id])
REFERENCES [dbo].[user] ([national_id])
GO
ALTER TABLE [dbo].[user_uses_service]  WITH CHECK ADD FOREIGN KEY([hospital_id], [service_id_s])
REFERENCES [dbo].[hospital_provides_service] ([hospital_id], [service_id_p])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[blood_bag]  WITH CHECK ADD CHECK  (([blood_type]='A+' OR [blood_type]='A-' OR [blood_type]='B+' OR [blood_type]='B-' OR [blood_type]='O+' OR [blood_type]='O-' OR [blood_type]='AB+' OR [blood_type]='AB-'))
GO
ALTER TABLE [dbo].[donor]  WITH CHECK ADD CHECK  (([age]>=(18) AND [age]<=(65)))
GO
ALTER TABLE [dbo].[donor]  WITH CHECK ADD CHECK  (([blood_type]='A+' OR [blood_type]='A-' OR [blood_type]='B+' OR [blood_type]='B-' OR [blood_type]='O+' OR [blood_type]='O-' OR [blood_type]='AB+' OR [blood_type]='AB-'))
GO
ALTER TABLE [dbo].[donor]  WITH CHECK ADD CHECK  (([gender]='M' OR [gender]='F'))
GO
ALTER TABLE [dbo].[login]  WITH CHECK ADD CHECK  (([user_type]='A' OR [user_type]='U' OR [user_type]='H' OR [user_type]='S'))
GO
EXEC sys.sp_addextendedproperty @name=N'DEFAULT', @value=N'0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'user', @level2type=N'COLUMN',@level2name=N'donation_count'
GO
