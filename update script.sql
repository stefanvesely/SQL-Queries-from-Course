/****** Script for SelectTopNRows command from SSMS  ******/

with CTE as (
SELECT [Key]
  FROM [dbo].[Assets_Content Viewed]
  Except 
SELECT ObjectKey
  FROM [dbo].[ContentViews]
),
buildTable as (
select 
cte.[Key] as ObjectKey,
[Assets_Research Report].[Key] as ReportKey,
[Assets_Research Report].[Title] as ReportName,
[Assets_Enterprise].[Key] as CounterpartyKey,
[Assets_Contact].[Key] as ReaderKey,
[Assets_Content Viewed].Created as Created,
[Assets_Contact].[Name] as ReaderName,
[Assets_Contact].Email as ReaderEmail,
LEFT([Assets_Enterprise].[Name], 50) as CounterpartyName
from CTE
left join [Assets_Content Viewed] on CTE.[Key] = [Assets_Content Viewed].[Key]
left join [Assets_Contact] on [Assets_Content Viewed].Reader = [Assets_Contact].[Key]
left join [Assets_Enterprise] on [Assets_Content Viewed].Counterparty = [Assets_Enterprise].[Key]
left join [Assets_Research Report] on [Assets_Content Viewed].Report_Name = [Assets_Research Report].[Key])

MERGE INTO ContentViews AS target
USING buildTable AS source
ON target.ObjectKey = source.ObjectKey
WHEN MATCHED THEN
    UPDATE SET 
        target.ReportKey = source.ReportKey,
        target.Created = source.Created,
        target.ReaderKey = source.ReaderKey,
        target.CounterpartyKey = source.CounterpartyKey,
        target.ReaderEmail = source.ReaderEmail,
        target.ReaderName = source.ReaderName
        WHEN NOT MATCHED BY TARGET THEN
    INSERT (ObjectKey, ReportKey, Created, ReaderKey, CounterpartyKey, ReaderEmail, ReportName, ReaderName, CounterpartyName )
    VALUES (source.ObjectKey, source.ReportKey, source.Created, source.ReaderKey, source.CounterpartyKey, source.ReaderEmail, source.ReportName, source.ReaderName, source.CounterpartyName);