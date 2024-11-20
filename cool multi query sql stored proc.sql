IF OBJECT_ID('InsertUserTrackingShareDownloadPrintView', 'P') IS NOT NULL
    DROP PROCEDURE InsertUserTrackingShareDownloadPrintView;
GO

CREATE PROCEDURE InsertUserTrackingShareDownloadPrintView
    @json NVARCHAR(MAX)
AS
BEGIN
    DECLARE @TableName NVARCHAR(255)
    DECLARE @sql NVARCHAR(MAX)

    -- Extract the table name from the JSON
    SELECT @TableName = TableName
    FROM OPENJSON(@json, '$')
    WITH (TableName NVARCHAR(255) '$.TableName');

    -- Construct the SQL insert statement based on the table name
    IF @TableName = 'ContentShares'
    BEGIN
        SET @sql = '
            ;WITH parsedJson AS
            (
                SELECT 
                    ReportKey,
                    ReportName,
                    ObjectKey,
                    ReaderName,
                    ReaderKey,
                    ReaderEmail,
                    CounterpartyName,
                    CounterpartyKey,
                    SharedWithIndividualKey,
                    SharedWithIndividualName,
                    SharedWithIndividualEmail
                FROM OPENJSON(@json, ''$'')
                WITH
                (
                    ReportKey NVARCHAR(255) ''$.ReportKey'',
                    ReportName NVARCHAR(255) ''$.ReportName'',
                    ObjectKey NVARCHAR(255) ''$.ObjectKey'',
                    ReaderName NVARCHAR(255) ''$.ReaderName'',
                    ReaderKey NVARCHAR(255) ''$.ReaderKey'',
                    ReaderEmail NVARCHAR(255) ''$.ReaderEmail'',
                    CounterpartyName NVARCHAR(255) ''$.CounterpartyName'',
                    CounterpartyKey NVARCHAR(255) ''$.CounterpartyKey'',
                    SharedWithIndividualKey NVARCHAR(255) ''$.SharedWithIndividualKey'',
                    SharedWithIndividualName NVARCHAR(255) ''$.SharedWithIndividualName'',
                    SharedWithIndividualEmail NVARCHAR(255) ''$.SharedWithIndividualEmail''
                )
            )
            INSERT INTO ' + @TableName + ' (
                ReportKey, ReportName, Created, ObjectKey, ReaderName, ReaderKey, ReaderEmail, CounterpartyName, CounterpartyKey, SharedWithIndividualKey, SharedWithIndividualName, SharedWithIndividualEmail
            )
            SELECT 
                ReportKey, ReportName, GETDATE() AS Created, ObjectKey, ReaderName, ReaderKey, ReaderEmail, CounterpartyName, CounterpartyKey, SharedWithIndividualKey, SharedWithIndividualName, SharedWithIndividualEmail
            FROM parsedJson'
    END
    ELSE
    BEGIN
        SET @sql = '
            ;WITH parsedJson AS
            (
                SELECT 
                    ReportKey,
                    ReportName,
                    ObjectKey,
                    ReaderName,
                    ReaderKey,
                    ReaderEmail,
                    CounterpartyName,
                    CounterpartyKey
                FROM OPENJSON(@json, ''$'')
                WITH
                (
                    ReportKey NVARCHAR(255) ''$.ReportKey'',
                    ReportName NVARCHAR(255) ''$.ReportName'',
                    ObjectKey NVARCHAR(255) ''$.ObjectKey'',
                    ReaderName NVARCHAR(255) ''$.ReaderName'',
                    ReaderKey NVARCHAR(255) ''$.ReaderKey'',
                    ReaderEmail NVARCHAR(255) ''$.ReaderEmail'',
                    CounterpartyName NVARCHAR(255) ''$.CounterpartyName'',
                    CounterpartyKey NVARCHAR(255) ''$.CounterpartyKey''
                )
            )
            INSERT INTO ' + @TableName + ' (
                ReportKey, ReportName, Created, ObjectKey, ReaderName, ReaderKey, ReaderEmail, CounterpartyName, CounterpartyKey
            )
            SELECT 
                ReportKey, ReportName, GETDATE() AS Created, ObjectKey, ReaderName, ReaderKey, ReaderEmail, CounterpartyName, CounterpartyKey
            FROM parsedJson'
    END

    -- Execute the constructed SQL statement
    EXEC sp_executesql @sql, N'@json NVARCHAR(MAX)', @json
END
