USE [DemoRcAuto]
GO
/****** Object:  Table [dbo].[Assicurazioni]    Script Date: 15/03/2021 15:53:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Assicurazioni](
	[Codice] [varchar](50) NOT NULL,
	[Nome] [varchar](50) NOT NULL,
	[Sede] [varchar](100) NOT NULL,
 CONSTRAINT [PK_Assicurazioni] PRIMARY KEY CLUSTERED 
(
	[Codice] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Auto]    Script Date: 15/03/2021 15:53:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Auto](
	[Targa] [char](7) NOT NULL,
	[Marca] [varchar](100) NOT NULL,
	[Cilindrata] [int] NOT NULL,
	[Potenza] [int] NOT NULL,
	[CodiceFiscaleProprietario] [char](16) NOT NULL,
	[CodiceAssicurazione] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Auto] PRIMARY KEY CLUSTERED 
(
	[Targa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AutoCoinvolte]    Script Date: 15/03/2021 15:53:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AutoCoinvolte](
	[CodiceSinistro] [varchar](50) NOT NULL,
	[Targa] [char](7) NOT NULL,
	[ImportoDelDanno] [money] NOT NULL,
 CONSTRAINT [PK_AutoCoinvolte] PRIMARY KEY CLUSTERED 
(
	[CodiceSinistro] ASC,
	[Targa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Proprietari]    Script Date: 15/03/2021 15:53:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Proprietari](
	[CodiceFiscale] [char](16) NOT NULL,
	[Nome] [varchar](50) NOT NULL,
	[Residenza] [text] NOT NULL,
 CONSTRAINT [PK_Proprietari] PRIMARY KEY CLUSTERED 
(
	[CodiceFiscale] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Sinistri]    Script Date: 15/03/2021 15:53:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sinistri](
	[Codice] [varchar](50) NOT NULL,
	[Localita] [text] NOT NULL,
	[Data] [date] NOT NULL,
 CONSTRAINT [PK_Sinistri] PRIMARY KEY CLUSTERED 
(
	[Codice] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[Auto]  WITH CHECK ADD  CONSTRAINT [FK_Auto_Assicurazioni] FOREIGN KEY([CodiceAssicurazione])
REFERENCES [dbo].[Assicurazioni] ([Codice])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Auto] CHECK CONSTRAINT [FK_Auto_Assicurazioni]
GO
ALTER TABLE [dbo].[Auto]  WITH CHECK ADD  CONSTRAINT [FK_Auto_Proprietari] FOREIGN KEY([CodiceFiscaleProprietario])
REFERENCES [dbo].[Proprietari] ([CodiceFiscale])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Auto] CHECK CONSTRAINT [FK_Auto_Proprietari]
GO
ALTER TABLE [dbo].[AutoCoinvolte]  WITH CHECK ADD  CONSTRAINT [FK_AutoCoinvolte_Auto] FOREIGN KEY([Targa])
REFERENCES [dbo].[Auto] ([Targa])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AutoCoinvolte] CHECK CONSTRAINT [FK_AutoCoinvolte_Auto]
GO
ALTER TABLE [dbo].[AutoCoinvolte]  WITH CHECK ADD  CONSTRAINT [FK_AutoCoinvolte_Sinistri] FOREIGN KEY([CodiceSinistro])
REFERENCES [dbo].[Sinistri] ([Codice])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AutoCoinvolte] CHECK CONSTRAINT [FK_AutoCoinvolte_Sinistri]
GO
