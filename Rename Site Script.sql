-- Fueled: Site rename

DECLARE @new NVARCHAR(50) = 'Caltex Komga'
DECLARE @old NVARCHAR(50) = 'Rudolphs Service Station';
DECLARE @id NVARCHAR(50) = '9F415879-3414-4387-9964-203BA1002BDE';

-- Run on Marketer database, i.e. Fueled_CECM
UPDATE UsersF SET Branch = @new WHERE Branch = @old AND BranchId = @id;
UPDATE Input_Meters SET Branch = @new WHERE Branch = @old AND BranchId = @id;
UPDATE Input_Tanks SET Branch = @new WHERE Branch = @old AND BranchId = @id;
UPDATE Orders SET Branch = @new WHERE Branch = @old AND BranchId = @id;
UPDATE Notification_Settings SET Branch = @new WHERE Branch = @old AND BranchId = @id;
UPDATE BC SET BranchName = @new WHERE BranchName = @old AND SiteId = @id;
UPDATE Mailing_List SET [Site] = @new WHERE [Site] = @old AND SiteId = @id;
UPDATE CompanyDetails SET [SiteName] = @new WHERE [SiteName] = @old AND Id = @id;

-- Run on Fueled_Logins;
UPDATE Sites SET [Name] = @new WHERE [Name] = @old AND Id = @id;
UPDATE Users_LocalClient SET Branch = @new WHERE Branch = @old AND BranchId = @id;