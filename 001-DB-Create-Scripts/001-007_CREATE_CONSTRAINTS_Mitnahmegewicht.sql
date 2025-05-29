USE [TierTaxi]
GO

ALTER TABLE [dbo].[tb_Tierart]  
ADD  CONSTRAINT [CK_Mitnahmegewicht] 
	CHECK  (([Mitnahmegewicht]>=(1) AND [Mitnahmegewicht]<=(300)))
GO

ALTER TABLE [dbo].[tb_Tierart] CHECK CONSTRAINT [CK_Mitnahmegewicht]
GO


