/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
===============================================================================
*/

CREATE OR AlTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time datetime, @end_time datetime,
	@Spstart_time datetime, @Spend_time datetime;
	BEGIN TRY
		set @Spstart_time= GETDATE()
	
		PRINT '====================================';
		PRINT '		   loading bronze layer		   ';
		PRINT '====================================';
		
		
		PRINT '====================================';
		PRINT '		   loading crm TABLES		   ';
		PRINT '====================================';
			--<----UNDERSTANDING THE BUlK INSERT-------->

		set @start_time = GetDate();
		PRINT '>> Truncating Table: bronze.crm_cust_info ';
			TRUNCATE TABLE bronze.crm_cust_info --GOOD PRACTICE (FULL LOAD) || HOW INC LOAD WOULD FIT IN HERE?
		PRINT '>> Inserting Data Into: bronze.crm_cust_info ';
			BUlK INSERT bronze.crm_cust_info
			FROM 'C:\Users\Mesum\Downloads\Compressed\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv' 
			WITH (
				FIRSTROW = 2,                -- Skip header row if present
				FIELDTERMINATOR = ',',       -- CSV field separator
				ROWTERMINATOR = '\n',        -- Row delimiter
				TABLOCK                      -- Improves performance
			);
		set @end_time = GetDate();
		PRINT '>> LOAD DURATION:' + CAST (DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+ ' seconds';
			--QUESTION ? WHAT IF THERE IS A COMMA IN ONE OF THE FIELDS? THEN HOW SEPARTOR WORKS?
		PRINT '------------';
		
		set @start_time = GetDate();
		PRINT '>> Truncating Table: bronze.crm_prd_info ';
			TRUNCATE TABLE bronze.crm_prd_info --GOOD PRACTICE (FULL LOAD)
		
		PRINT '>> Inserting Data Into: bronze.crm_prd_info ';	
			BULK insert bronze.crm_prd_info  
			FROM 'C:\Users\Mesum\Downloads\Compressed\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv' 
			WITH (
				FIRSTROW = 2,                -- Skip header row if present
				FIELDTERMINATOR = ',',       -- CSV field separator
				ROWTERMINATOR = '\n',        -- Row delimiter
				TABLOCK                      -- Improves performance
			)
				set @end_time = GetDate();
		PRINT '>> LOAD DURATION:' + CAST (DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+ ' seconds';
				PRINT '------------';
				
		set @start_time = GetDate();
		PRINT '>> Truncating Table: bronze.crm_sales_details ';
			TRUNCATE TABLE bronze.crm_sales_details--GOOD PRACTICE (FULL LOAD)
			
		PRINT '>> Inserting Data Into: bronze.crm_sales_details ';
			BULK insert bronze.crm_sales_details 
			
			FROM 'C:\Users\Mesum\Downloads\Compressed\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv' 
			WITH (
				FIRSTROW = 2,                -- Skip header row if present
				FIELDTERMINATOR = ',',       -- CSV field separator
				ROWTERMINATOR = '\n',        -- Row delimiter
				TABLOCK                      -- Improves performance
			)
				set @end_time = GetDate();
		PRINT '>> LOAD DURATION:' + CAST (DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+ ' seconds';
				PRINT '------------';
		
		PRINT '====================================';
		PRINT '		   loading ERP TABLES		   ';
		PRINT '====================================';
			--ERP 
		set @start_time = GetDate();
		PRINT '>> Truncating Table: bronze.erp_cust_az12 ';	
			TRUNCATE TABLE bronze.erp_cust_az12--GOOD PRACTICE (FULL LOAD)
		
		PRINT '>> Inserting Data Into: bronze.erp_cust_az12 ';
				BULK insert bronze.erp_cust_az12 
				FROM 'C:\Users\Mesum\Downloads\Compressed\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\cust_az12.csv' 
			WITH (
				FIRSTROW = 2,                -- Skip header row if present
				FIELDTERMINATOR = ',',       -- CSV field separator
				ROWTERMINATOR = '\n',        -- Row delimiter
				TABLOCK                      -- Improves performance
			)
				set @end_time = GetDate();
		PRINT '>> LOAD DURATION:' + CAST (DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+ ' seconds';
				PRINT '------------';
				
		set @start_time = GetDate();		
		PRINT '>> Truncating Table: bronze.erp_loc_a101 ';
			TRUNCATE TABLE bronze.erp_loc_a101--GOOD PRACTICE (FULL LOAD)
		
		PRINT '>> Inserting Data Into: bronze.erp_loc_a101 ';
			BULK insert bronze.erp_loc_a101
			FROM 'C:\Users\Mesum\Downloads\Compressed\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv' 
			WITH (
				FIRSTROW = 2,                -- Skip header row if present
				FIELDTERMINATOR = ',',       -- CSV field separator
				ROWTERMINATOR = '\n',        -- Row delimiter
				TABLOCK                      -- Improves performance
			)
			
					set @end_time = GetDate();
		PRINT '>> LOAD DURATION:' + CAST (DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+ ' seconds';
				PRINT '------------';

		set @start_time = GetDate();		
		PRINT '>> Truncating Table: bronze.erp_px_cat_g1v2 ';
			TRUNCATE TABLE bronze.erp_px_cat_g1v2--GOOD PRACTICE (FULL LOAD)
		
		PRINT '>> Inserting Data Into: bronze.erp_px_cat_g1v2 ';
			BULK insert bronze.erp_px_cat_g1v2
			FROM 'C:\Users\Mesum\Downloads\Compressed\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv' 
			WITH (
				FIRSTROW = 2,                -- Skip header row if present
				FIELDTERMINATOR = ',',       -- CSV field separator
				ROWTERMINATOR = '\n',        -- Row delimiter
				TABLOCK                      -- Improves performance
			)
				set @end_time = GetDate();
		PRINT '>> LOAD DURATION:' + CAST (DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+ ' seconds';
				PRINT '------------';

		SET @Spend_time = GetDate()
		PRINT '>> Bronze layer load duration:' + CAST (DATEDIFF(second,@Spstart_time,@Spend_time) AS NVARCHAR)+ ' seconds';
	END TRY
	BEGIN CATCH 
		PRINT '==============================================='
		PRINT 'Error Occurred During loading Bronze layer'
		PRINT 'ERROR MESSAGE' + ERROR_MESSAGE();
		PRINT 'ERROR MESSAGE' + ERROR_NUMBER();
		PRINT 'ERROR MESSAGE' + ERROR_STATE();
		PRINT '==============================================='

	END CATCH

END



		------------------------TIPS-----------------		
		--PRO TIP - Save frequetnly used sql code in stored PROCEDUREs in database.
		--TIP++ - Always keep on Adding print stmts to track execution, debug issues and understand flows // quite handy for etl workflows
		--Pro Tip++ -ADD Try-Catch to ensure Error-Handling, data integrity, and issue logging for easier debugging
		-- PRINT ERROR_MESSAGE()
		-- PRINT ERROR_NUMBER()
		-- PRINT ERROR_STATE()
		--TRACKING ETL DURATION		
		--IN CATCH WE CAN DO LOTS OF STUFF LIKE CREATING LOGGING TABLES // ADD MESSAGES
		------------------------TIPS-----------------
