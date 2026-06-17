/*
===============================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================

Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files.
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None.CREATE OR ALTER PROCEDURE bronze.load_bronze AS

BEGIN

DECLARE @batch_start_time Datetime, @batch_end_time DateTime;
DECLARE @start_time Datetime, @end_time DateTime;
 BEGIN TRY
     SET @batch_start_time= getdate();
    PRINT '==============================='
    PRINT 'Loading Bronze Layer'
    PRINT '==============================='

    PRINT '-----------------------------------------------------------'
    PRINT 'Loading CRM Tables'
    PRINT '-----------------------------------------------------------'
 
 SET @start_time= getdate();
PRINT '>> Truncating Table: bronze.crm_cust_info';
Truncate table bronze.crm_cust_info;
PRINT '>> Inserting Into: bronze.crm_cust_info';
BULK INSERT bronze.crm_cust_info
FROM 'C:\Users\MADHURIMA\Desktop\SQL\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
With (
Firstrow=2,
Fieldterminator = ',',
TABLOCK
);
 SET @end_time= getdate();
 PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
 PRINT '>> -----------';
--Loading into bronze.crm_prd_info

 SET @start_time= getdate();
PRINT '>> Truncating Table: bronze.crm_prd_info';
Truncate table bronze.crm_prd_info;
PRINT '>> Inserting Into: bronze.crm_prd_info';
BULK INSERT bronze.crm_prd_info
FROM 'C:\Users\MADHURIMA\Desktop\SQL\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
With (
Firstrow=2,
Fieldterminator = ',',
TABLOCK
);
 SET @end_time= getdate();
 PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
 PRINT '>> -----------';

--Loading into bronze.crm_sales_details

 SET @start_time= getdate();
PRINT '>> Truncating Table: bronze.crm_sales_details';
Truncate table bronze.crm_sales_details;
PRINT '>> Inserting Into: bronze.crm_sales_details';
BULK INSERT bronze.crm_sales_details
FROM 'C:\Users\MADHURIMA\Desktop\SQL\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
With (
Firstrow=2,
Fieldterminator = ',',
TABLOCK
);
 SET @end_time= getdate();
 PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
 PRINT '>> -----------';

--Loading into bronze.erp_cust_az12

PRINT '-----------------------------------------------------------'
PRINT 'Loading ERP Tables'
PRINT '-----------------------------------------------------------'

SET @start_time= getdate();
PRINT '>> Truncating Table: bronze.erp_cust_az12';
Truncate table bronze.erp_cust_az12;
PRINT '>> Inserting Into: bronze.erp_cust_az12';
BULK INSERT bronze.erp_cust_az12
FROM 'C:\Users\MADHURIMA\Desktop\SQL\sql-data-warehouse-project\datasets\source_erp\cust_az12.csv'
With (
Firstrow=2,
Fieldterminator = ',',
TABLOCK
);
 SET @end_time= getdate();
 PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
 PRINT '>> -----------';

--Loading into bronze.erp_loc_a101

SET @start_time= getdate();
PRINT '>> Truncating Table: bronze.erp_loc_a101';
Truncate table bronze.erp_loc_a101;
PRINT '>> Inserting Into: bronze.erp_loc_a101';
BULK INSERT bronze.erp_loc_a101
FROM 'C:\Users\MADHURIMA\Desktop\SQL\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
With (
Firstrow=2,
Fieldterminator = ',',
TABLOCK
);

 SET @end_time= getdate();
 PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
 PRINT '>> -----------';

--Loading into bronze.erp_px_cat_g1v2

SET @start_time= getdate();
PRINT '>> Truncating Table: bronze.erp_px_cat_g1v2';
Truncate table bronze.erp_px_cat_g1v2;
PRINT '>> Inserting Into: bronze.erp_px_cat_g1v2';
BULK INSERT bronze.erp_px_cat_g1v2
FROM 'C:\Users\MADHURIMA\Desktop\SQL\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
With (
Firstrow=2,
Fieldterminator = ',',
TABLOCK
);
 SET @end_time= getdate();
 PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
 PRINT '>> -----------';

SET @batch_end_time= getdate();
PRINT '=============================='
PRINT 'Loading Bronze Layer is Completed';
PRINT '    - Total Load Duration: ' 
      + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR) 
      + ' seconds';
PRINT '=============================='
END TRY

BEGIN CATCH
        PRINT '==============================='
        PRINT 'ERROR OCCURRED DURING LOADING BRONZE LAYER'
        PRINT 'Error Message: ' + ERROR_MESSAGE();
        PRINT 'Error Number: ' + CAST(ERROR_NUMBER() AS NVARCHAR(10));
        PRINT 'Error State: ' + CAST(ERROR_STATE() AS NVARCHAR(10));
        PRINT '==============================='
    END CATCH
  
END;
    This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
*/



