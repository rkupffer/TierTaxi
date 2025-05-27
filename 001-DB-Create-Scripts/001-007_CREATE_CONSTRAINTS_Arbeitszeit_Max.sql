USE [TierTaxi]
GO

ALTER TABLE [dbo].[tb_Tierart]  WITH CHECK ADD  CONSTRAINT [CK_Arbeitszeit] CHECK  (([Arbeitszeit_Max]>=(1) AND [Arbeitszeit_Max]<=(24)))
GO

ALTER TABLE [dbo].[tb_Tierart] CHECK CONSTRAINT [CK_Arbeitszeit]
GO


