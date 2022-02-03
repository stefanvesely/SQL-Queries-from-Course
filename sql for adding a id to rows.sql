select sum(Pri_Move) as MeterMovement, Fuel, Branch from Input_Meters where Effective_Date Between '2021-06-07 00:00:00' and '2021-06-08 00:00:00' group by Branch, Fuel order by Branch
select Sum(Manual_Movement) as TankMovement, Branch, Fuel from Input_Tanks where Effective_Date Between '2021-06-07 00:00:00' and '2021-06-08 00:00:00' group by Fuel, Branch

with Tanks as (select ROW_NUMBER() over (order by Branch) as Id, Sum(Manual_Movement) as TankMovement, Branch, Fuel
                                   from Input_Tanks
                                   where Effective_Date Between '" + sStartDate + "' and '" + sEndDate + "' " +
                                   " Group by Fuel, Branch), " +
                                   "Meters as (select ROW_NUMBER() over (order by Branch) as Id, sum(Pri_Move) as MeterMovement, Fuel, Branch, BranchId" +
                                   " from Input_Meters " +
                                   "where Effective_Date Between '" + sStartDate + "' and '" + sEndDate + "' group by Fuel, Branch, BranchId) "+
                                   "Select Meters.Id as Id, Meters.Fuel as Fuel, Meters.Branch as Branch, BC.BCName, Meters.MeterMovement as Meter, Tanks.TankMovement as TankMovement from Tanks Left Join Meters on Meters.Id = Tanks.Id left join BC on BC.SiteID = Meters.BranchId