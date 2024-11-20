with FirstTable as (
  select [Key], [Name], Created, Updated, Counterparty, Reader, Report_Name as ReportName, Analyst_Name as AnalystName, CounterpartyKey, ReaderKey, ReportKey
  from
  EmailsOpenedLegacy), 
  SecondTable as (
  select [Key], [Name], Date_2 as Created, Updated, Counterparty, Reader, Report_Name as ReportName, Analyst_Name as AnalystName, CounterpartyKey, ReaderKey, ReportKey
  from EmailsOpenedLegacy 
  where date_2 is not null),
  ThirdTable as (
  select [Key], [Name], Date_3 as Created, Updated, Counterparty, Reader, Report_Name as ReportName, Analyst_Name as AnalystName, CounterpartyKey, ReaderKey, ReportKey
  from EmailsOpenedLegacy 
  where date_3 is not null
  ),
   FourthTable as (
  select [Key], [Name], Date_4 as Created, Updated, Counterparty, Reader, Report_Name as ReportName, Analyst_Name as AnalystName, CounterpartyKey, ReaderKey, ReportKey
  from EmailsOpenedLegacy 
  where date_4 is not null
  ),
   FifthTable as (
  select [Key], [Name], Date_5 as Created, Updated, Counterparty, Reader, Report_Name as ReportName, Analyst_Name as AnalystName, CounterpartyKey, ReaderKey, ReportKey
  from EmailsOpenedLegacy 
  where date_5 is not null
  ),
   SixthTable as (
  select [Key], [Name], Date_6 as Created, Updated, Counterparty, Reader, Report_Name as ReportName, Analyst_Name as AnalystName, CounterpartyKey, ReaderKey, ReportKey
  from EmailsOpenedLegacy 
  where date_6 is not null
  ),
  SeventhTable as (
  select [Key], [Name], Date_7 as Created, Updated, Counterparty, Reader, Report_Name as ReportName, Analyst_Name as AnalystName, CounterpartyKey, ReaderKey, ReportKey
  from EmailsOpenedLegacy 
  where date_7 is not null
  ),
  EighthTable as (
  select [Key], [Name], Date_8 as Created, Updated, Counterparty, Reader, Report_Name as ReportName, Analyst_Name as AnalystName, CounterpartyKey, ReaderKey, ReportKey
  from EmailsOpenedLegacy 
  where date_8 is not null
  ),
  NinethTable as (
  select [Key], [Name], Date_9 as Created, Updated, Counterparty, Reader, Report_Name as ReportName, Analyst_Name as AnalystName, CounterpartyKey, ReaderKey, ReportKey
  from EmailsOpenedLegacy 
  where date_9 is not null
  ),
  TenthTable as (
  select [Key], [Name], Date_10 as Created, Updated, Counterparty, Reader, Report_Name as ReportName, Analyst_Name as AnalystName, CounterpartyKey, ReaderKey, ReportKey
  from EmailsOpenedLegacy 
  where date_10 is not null
  ),
  FinalTable as (
  select * from FirstTable
  Union 
  select * from SecondTable
  Union 
  select * from ThirdTable
  Union 
  select * from FourthTable
  Union 
  select * from FifthTable
  Union 
  select * from SixthTable
  Union 
  select * from SeventhTable
  Union 
  select * from EighthTable
  Union 
  select * from NinethTable
  Union 
  select * from TenthTable)
  Insert into EmailsOpened ([Key], Name, Created, Updated, Counterparty, Reader, ReportName, AnalystName, CounterpartyKey, ReaderKey, ReportKey)
  select [Key], Name, Created, Updated, Counterparty, Reader, ReportName, AnalystName, CounterpartyKey, ReaderKey, ReportKey
  from FinalTable