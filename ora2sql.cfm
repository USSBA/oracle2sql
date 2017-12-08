<!---
DESCRIPTION: Migrate Blob data from ORACLE-SQL--->

<cfcontent type="text/html; cht=iso-8859-1">

	<!---Declare Oracle DB details--->
   <!--- 
    <cfset Variables.db="">
    <cfset Variables.username="">
    <cfset Variables.password=""> --->

	<!---Declare SQL DB details--->
    
	<cfparam name="Variables.db" default="oracle_scheduled">
	
    <cfset Variables.sqldb="XXXX">
    <cfset Variables.sqlusername="XXXXXX">
    <cfset Variables.sqlpassword="XXXXXXX">
 <!--- Need to give the SQL Server Deatils here  --->

		<!---Get Records from Oracle database table (Source Database Table)--->
        
        <cfquery name="blob" datasource="#Variables.db#" username="#Variables.username#" password="#Variables.password#">
        SELECT DEPTNO,DNAME,LOC FROM TableName
        </cfquery>

<!---NOTE:Before Inserting I am truncating the target table to make sure the table is empty.If you dont want to truncate please comment the below query.
If you are commenting the below query please run this template only once as it will insert duplicate records.
--->

        <cfquery name="TruncateSQLTable" datasource="#Variables.sqldb#" username="#Variables.sqlusername#" password="#Variables.sqlpassword#">
        	TRUNCATE TABLE TableName 
        </cfquery>

<!---Loop the Oracle table & Insert in SQL table (Target Database Table)--->

<cfloop query="blob">
      	
		<cfquery name="InsertToSQL" datasource="#Variables.sqldb#" username="#Variables.sqlusername#" password="#Variables.sqlpassword#">
          INSERT INTO TableName (
  DEPTNo,DNAME,LOC
  ) 
     VALUES (#blob.DEPTNO#,'#blob.DNAME#','#blob.LOC#'                   
              
         )
  		</cfquery>
</cfloop>

<!---Get Records from SQL database table after Insert--->

    <cfquery name="Sqlblob" datasource="#Variables.sqldb#" username="#Variables.sqlusername#" password="#Variables.sqlpassword#">
        SELECT DEPTNo
        FROM TableName 
    </cfquery>

<!---Dump the above query to check whether the data is inserted
<cfdump var="#Sqlblob#">--->

<cfoutput><strong>#Sqlblob.recordcount# records has been migrated from oracle to sql table successfully...</strong></cfoutput> 
