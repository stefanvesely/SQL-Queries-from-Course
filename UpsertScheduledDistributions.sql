IF OBJECT_ID('UpsertDistribution', 'P') IS NOT NULL
    DROP PROCEDURE UpsertDistribution;
GO

CREATE PROCEDURE UpsertDistribution
    @DistributionId INT,
    @DateOfDistribution DATE
AS
BEGIN
    MERGE INTO ScheduledDistributions AS target
    USING (SELECT @DistributionId AS DistributionId, @DateOfDistribution AS DateOfDistribution) AS source
    ON (target.DistributionId = source.DistributionId)
    WHEN MATCHED THEN
        UPDATE SET DateOfDistribution = source.DateOfDistribution
    WHEN NOT MATCHED THEN
        INSERT (DistributionId, DateOfDistribution)
        VALUES (source.DistributionId, source.DateOfDistribution);
END;
GO
