USE [TierTaxi]
GO

ALTER TABLE [dbo].[tb_Auftraege] ADD  DEFAULT (getdate()) FOR [DatumUhrzeitStart]
GO


