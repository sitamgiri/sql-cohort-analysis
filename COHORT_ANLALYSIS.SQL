--CREATE TABLE CALLED COH_SALES
DROP TABLE IF EXISTS COH_SALES;

CREATE TABLE COH_SALES(
		ORDER_ID INT ,
		ORDER_DATE DATE,
		STATUS VARCHAR(50),
		ITEM_ID INT,
		SKU VARCHAR(150),
		QUANTITY_ORDERED INT,
		PRICE NUMERIC(10,2),
		DISCOUNT_ANOUMT NUMERIC(10,2),
		CATEGORY VARCHAR(50),
		PAYMENT_METHOD VARCHAR(50),
		BI_ST VARCHAR(20),
		CUST_ID INT,
		YEAR INT,
		MONTH VARCHAR(10),
		REF_NUM INT,
		NAME_PREFIX VARCHAR(10),
		FIRST_NAME VARCHAR(20),
		MIDDLE_INITIAL VARCHAR(2),
		LAST_NAME VARCHAR(20),
		GENDER VARCHAR(2),
		AGE INT,
		FULL_NAME VARCHAR(30),
		EMAIL VARCHAR(50),
		CUSTOMER_SINCE TEXT,
		SSN VARCHAR(50),
		PHONE_NO VARCHAR(20),
		NAME_OF_PLACE VARCHAR(60),
		COUNTRY VARCHAR(50),
		CITY VARCHAR(50),
		STTE VARCHAR(10),
		ZIP INT,
		REGION VARCHAR(10),
		USER_NAME VARCHAR(20)
);
-------------------------------------------------------------------
--***************************************************************--
-------------------------------------------------------------------
ALTER TABLE COH_SALES
RENAME COLUMN DISCOUNT_ANOUMT TO DISCOUNT_AMOUNT;
--```````````````````````````````````````````````````````````````--
ALTER TABLE COH_SALES
RENAME COLUMN STTE TO STATE;
--***************************************************************--
-------------------------------------------------------------------
--***************************************************************--
SELECT * FROM COH_SALES;

---CONVERT THE TEXT DATATYPE OF CUSTOMER_SINCE TO DATE TYP
WHEN CUSTOMER_SINCE ~ '^\d{4}-\d{2}-\d{2}$'
				THEN CUSTOMER_SINCE::DATE


ALTER TABLE coh_sales
ALTER COLUMN CUSTOMER_SINCE TYPE DATE
USING (
    CASE 
        -- YYYY-MM-DD
        WHEN CUSTOMER_SINCE ~ '^\d{4}-\d{2}-\d{2}$'   
            THEN CUSTOMER_SINCE::DATE

        -- DD-MM-YYYY or D-M-YYYY
        WHEN CUSTOMER_SINCE ~ '^\d{1,2}-\d{1,2}-\d{4}$' 
            THEN TO_DATE(CUSTOMER_SINCE, 'DD-MM-YYYY')

        -- Slash format → need logic
        WHEN CUSTOMER_SINCE ~ '^\d{1,2}/\d{1,2}/\d{4}$' 
            THEN 
                CASE 
                    -- If first part > 12 → DD/MM/YYYY
                    WHEN SPLIT_PART(CUSTOMER_SINCE, '/', 1)::INT > 12
                        THEN TO_DATE(CUSTOMER_SINCE, 'DD/MM/YYYY')

                    -- Else → MM/DD/YYYY
                    ELSE TO_DATE(CUSTOMER_SINCE, 'MM/DD/YYYY')
                END

        ELSE NULL
    END
);


--NOW CHECKING FOR THE NULL VALUES IF ANY PRESENT IN THE TABLE;

SELECT 
	COUNT(*) FILTER (WHERE ORDER_ID IS NULL)  AS ORDER_ID_COUNT,
	COUNT(*) FILTER (WHERE ORDER_DATE IS NULL) AS ORDER_DATE_COUNT,
	COUNT(*) FILTER (WHERE STATUS IS NULL) AS STATUS_COUNT,
	COUNT(*) FILTER (WHERE ITEM_ID IS NULL) AS ITEM_ID_COUNT,
	COUNT(*) FILTER (WHERE SKU IS NULL) AS SKU_COUNT,
	COUNT(*) FILTER (WHERE QUANTITY_ORDERED IS NULL) AS QUANTITY_ORDERED_COUNT,
	COUNT(*) FILTER (WHERE PRICE IS NULL) AS PRICE_COUNT,
	COUNT(*) FILTER (WHERE DISCOUNT_AMOUNT IS NULL) AS DISCOUNT_COUNT,
	COUNT(*) FILTER (WHERE CATEGORY IS NULL) AS CATEGORY_COUNT,
	COUNT(*) FILTER (WHERE PAYMENT_METHOD IS NULL) AS PAYMENT_MODE_COUNT,
	COUNT(*) FILTER (WHERE BI_ST IS NULL) AS BI_ST_COUNT,
	COUNT(*) FILTER (WHERE CUST_ID IS NULL) AS CUST_ID_COUNT,
	COUNT(*) FILTER (WHERE YEAR IS NULL) AS YEAR_COUNT,
	COUNT(*) FILTER (WHERE REF_NUM IS NULL) AS REFERENCE_COUNT,
	COUNT(*) FILTER (WHERE NAME_PREFIX IS NULL) AS PREFIX_COUNT,
	COUNT(*) FILTER (WHERE FIRST_NAME IS NULL) AS FN_COUNT,
	COUNT(*) FILTER (WHERE LAST_NAME IS NULL) AS LN_COUNT,
	COUNT(*) FILTER (WHERE GENDER IS NULL) AS GENDER_COUNT,
	COUNT(*) FILTER (WHERE AGE IS NULL) AS AGE_COUNT,
	COUNT(*) FILTER (WHERE FULL_NAME IS NULL) AS FULL_NAME_COUNT,
	COUNT(*) FILTER (WHERE EMAIL IS NULL) AS EMAIL_COUNT,
	COUNT(*) FILTER (WHERE CUSTOMER_SINCE IS NULL) AS DATE_COUNT,
	COUNT(*) FILTER (WHERE SSN IS NULL) AS SSN_COUNT,
	COUNT(*) FILTER (WHERE PHONE_NO IS NULL) AS PHONE_NUM_COUNT,
	COUNT(*) FILTER (WHERE NAME_OF_PLACE IS NULL) AS NAME_OF_PLACE_COUNT,
	COUNT(*) FILTER (WHERE COUNTRY IS NULL) AS COUNTRY_COUNT,
	COUNT(*) FILTER (WHERE CITY IS NULL) AS CITY_COUNT,
	COUNT(*) FILTER (WHERE STATE IS NULL) AS STATE_COUNT,
	COUNT(*) FILTER (WHERE ZIP IS NULL) AS ZIP_COUNT,
	COUNT(*) FILTER (WHERE REGION IS NULL) AS REGION_COUNT,
	COUNT(*) FILTER (WHERE USER_NAME IS NULL) AS USER_NAME_COUNT
	
FROM
COH_SALES;

--NOTE:- NO NULL VALUES PRESENT IN THE TABLE


--CHECKING FOR DUPLICATE DATA--

SELECT * FROM COH_SALES;

SELECT 
ORDER_ID,ORDER_DATE,STATUS,ITEM_ID,SKU,QUANTITY_ORDERED,PRICE,DISCOUNT_AMOUNT,
CATEGORY,PAYMENT_METHOD,BI_ST,CUST_ID,YEAR,MONTH,REF_NUM,NAME_PREFIX,FIRST_NAME,
MIDDLE_INITIAL,LAST_NAME,GENDER,AGE,FULL_NAME,EMAIL,CUSTOMER_SINCE,SSN,PHONE_NO,NAME_OF_PLACE,COUNTRY,
CITY,STATE,ZIP,REGION,USER_NAME,COUNT(*) AS CNT
FROM
COH_SALES
GROUP BY 
ORDER_ID,ORDER_DATE,STATUS,ITEM_ID,SKU,QUANTITY_ORDERED,PRICE,DISCOUNT_AMOUNT,
CATEGORY,PAYMENT_METHOD,BI_ST,CUST_ID,YEAR,MONTH,REF_NUM,NAME_PREFIX,FIRST_NAME,
MIDDLE_INITIAL,LAST_NAME,GENDER,AGE,FULL_NAME,EMAIL,CUSTOMER_SINCE,SSN,PHONE_NO,NAME_OF_PLACE,COUNTRY,
CITY,STATE,ZIP,REGION,USER_NAME
HAVING COUNT(*)>1;

--NOTE:- THERE ARE NO FULL DUPLICATE ROWS PRESENT IN THE TABLE



--CHECKING FOR DUPLICATE EXCLUDING ITEM_ID
SELECT 
ORDER_ID,ORDER_DATE,STATUS,SKU,QUANTITY_ORDERED,PRICE,DISCOUNT_AMOUNT,
CATEGORY,PAYMENT_METHOD,BI_ST,CUST_ID,YEAR,MONTH,REF_NUM,NAME_PREFIX,FIRST_NAME,
MIDDLE_INITIAL,LAST_NAME,GENDER,AGE,FULL_NAME,EMAIL,CUSTOMER_SINCE,SSN,PHONE_NO,NAME_OF_PLACE,COUNTRY,
CITY,STATE,ZIP,REGION,USER_NAME,COUNT(*) AS CNT
FROM
COH_SALES
GROUP BY 
ORDER_ID,ORDER_DATE,STATUS,SKU,QUANTITY_ORDERED,PRICE,DISCOUNT_AMOUNT,
CATEGORY,PAYMENT_METHOD,BI_ST,CUST_ID,YEAR,MONTH,REF_NUM,NAME_PREFIX,FIRST_NAME,
MIDDLE_INITIAL,LAST_NAME,GENDER,AGE,FULL_NAME,EMAIL,CUSTOMER_SINCE,SSN,PHONE_NO,NAME_OF_PLACE,COUNTRY,
CITY,STATE,ZIP,REGION,USER_NAME
HAVING COUNT(*)>1;

--NOTE MULTIPLE DUPLICATE DATAS HAVE BEEN FOUND



--NOW SINCE THE DATA CANNOT BE DELETED RANDOMLY SO LET US CREATE A CLEAN TABLE FROM THE ABOVE TABLE

DROP TABLE IF EXISTS COH_CLEAN_SALES;


CREATE TABLE COH_CLEAN_SALES AS 
SELECT
	ORDER_ID,
	SKU,
	MIN(ORDER_DATE) AS ORDER_DATE,
	MIN(STATUS) AS STATUS,
	SUM(QUANTITY_ORDERED) AS QUANTITY_ORDERED,
	AVG(PRICE) AS PRICE,
	SUM(DISCOUNT_AMOUNT) AS DISCOUNT_AMOUNT,
	MIN(CATEGORY) AS CATEGORY,
	MIN(PAYMENT_METHOD) AS PAYMENT_METHOD,
	MIN(BI_ST) AS BI_ST,
	MIN(CUST_ID) AS CUST_ID,
	MIN(YEAR) AS YEAR,
	MIN(MONTH) AS MONTH,
	MIN(FULL_NAME) AS FULL_NAME,
	MIN(EMAIL) AS EMAIL,
	MIN(CUSTOMER_SINCE) AS CUSTOMER_SINCE,
	MIN(COUNTRY) AS COUNTRY,
	MIN(CITY) AS CITY,
	MIN(STATE) AS STATE
FROM
	COH_SALES
GROUP BY
	ORDER_ID, SKU;


SELECT * FROM COH_CLEAN_SALES;

--CHECKING IF DUPLICATE ROWS STILL EXISTS OR NOT
SELECT 
	ORDER_ID,
	SKU,
	COUNT(*) AS cnt
FROM COH_CLEAN_SALES
GROUP BY ORDER_ID, SKU
HAVING COUNT(*) > 1;

--NOTE:- NO DUPLICATE ROWS EXISTS;



--LET US VALIDATE IF ANY NULL VALUES ARE PRESENT

SELECT
COUNT(*) FILTER (WHERE ORDER_ID IS NULL) AS ORDER_ID_NULL,
COUNT(*) FILTER (WHERE ORDER_DATE IS NULL) AS ORDER_DATE_NULL
FROM
COH_CLEAN_SALES;

--NOTE:- NO NULL VALUES PRESENT

--THE COHORT ANALYSIS--

SELECT * FROM COH_CLEAN_SALES;

SELECT 
CUST_ID,MIN(ORDER_DATE) AS FIRST_PURCHASE
FROM 
COH_CLEAN_SALES
GROUP BY
CUST_ID
ORDER BY MIN(ORDER_DATE)
;

--NOTE:-This block of code identifies the first purchase date for each customer, 
--as every customer can have only one initial purchase.Since cohort analysis is customer-centric, 
--the data must be grouped at the customer level using CUST_ID, which uniquely represents each customer.
--By grouping on CUST_ID, we ensure that each customer appears only once in the result. 
--The use of MIN(ORDER_DATE) helps in determining the earliest transaction date, 
--which represents the customer’s entry point into the system. 
--This first purchase date forms the foundation for cohort analysis, 
--as customers will later be grouped and analyzed based on this starting point.

----MONTLY COHORT ANALYSIS----

WITH MONTHLY_COHORT AS
					( SELECT CUST_ID,
						MIN(ORDER_DATE) AS ORDER_DATES
						FROM COH_CLEAN_SALES
						GROUP BY CUST_ID
						),
MONTHLY_ANALYSIS AS(
					SELECT
					DATE_TRUNC('MONTH', ORDER_DATES) AS MONTHS,
					COUNT(CUST_ID) AS CUSTOMERS
					FROM
					MONTHLY_COHORT
					GROUP BY MONTHS)
SELECT 
MONTHS,CUSTOMERS
FROM 
MONTHLY_ANALYSIS
ORDER BY MONTHS;

--NOTE:-This step builds upon the previous code by grouping customers into cohorts based on their first purchase month.
--While the earlier step identified the first entry or transaction date for each unique customer, 
--this step converts those dates into a standardized month-level time bucket, 
--allowing multiple customers who entered the system within the same month to be grouped together.
--Since many customers can join on different days within a month, 
--this approach helps in consolidating them into a single cohort. 
--The result shows how many unique customers, each identified by a distinct CUST_ID, entered the system in each month. 
--It is important to note that each customer appears only once, as this is based on their first purchase, 
--so no retention or repeat behavior is captured at this stage.
--This step provides the cohort size,
--which represents monthly customer acquisition and serves as the baseline for further retention analysis.
--***************************************************************************************************************************--

--***************************************************************************************************************************--
--*************************************Customer Cohort Mapping with Time Index***********************************************--
--***************************************************************************************************************************--

WITH COHORT AS(
				SELECT 
				CUST_ID,
				DATE_TRUNC('MONTH',MIN(ORDER_DATE)) AS COHORT_MONTH
				FROM
				COH_CLEAN_SALES
				GROUP BY CUST_ID
				),
COHORT_DATA AS(
				SELECT
				S.CUST_ID,
				S.ORDER_DATE,
				C.COHORT_MONTH,
				(DATE_PART('YEAR',S.ORDER_DATE)-DATE_PART('YEAR',C.COHORT_MONTH))*12+
				(DATE_PART('MONTH',S.ORDER_DATE)-DATE_PART('MONTH',C.COHORT_MONTH))
				AS COHORT_INDEX
				FROM
				COH_CLEAN_SALES S
				JOIN
				COHORT C
				ON
				S.CUST_ID=C.CUST_ID
				ORDER BY S.CUST_ID,S.ORDER_DATE
				
)
SELECT CUST_ID,ORDER_DATE,COHORT_MONTH,COHORT_INDEX
FROM
COHORT_DATA;
				
-- NOTE:
-- This step links each customer’s transactions with their cohort month 
-- (first purchase month).

-- The COHORT CTE identifies the first purchase month using MIN(ORDER_DATE), 
-- while COHORT_DATA joins it back to all transactions using CUST_ID.

-- COHORT_INDEX calculates the number of months between the transaction date 
-- and the cohort month:
-- 0 = same month, 1 = next month, and so on.

-- This structure enables time-based tracking of customer behavior 
-- and forms the basis for retention analysis.
--**************************************************************************************************************************--

--performing cohort retention analysis per customers--

WITH COHORT AS(
				SELECT 
				CUST_ID,
				DATE_TRUNC('MONTH',MIN(ORDER_DATE)) AS COHORT_MONTH
				FROM
				COH_CLEAN_SALES
				GROUP BY CUST_ID
				),
COHORT_DATA AS(
				SELECT
				S.CUST_ID,
				S.ORDER_DATE,
				C.COHORT_MONTH,
				(DATE_PART('YEAR',S.ORDER_DATE)-DATE_PART('YEAR',C.COHORT_MONTH))*12+
				(DATE_PART('MONTH',S.ORDER_DATE)-DATE_PART('MONTH',C.COHORT_MONTH))
				AS COHORT_INDEX
				FROM
				COH_CLEAN_SALES S
				JOIN
				COHORT C
				ON
				S.CUST_ID=C.CUST_ID
				ORDER BY S.CUST_ID,S.ORDER_DATE
				
),
COH_RETENTION AS(
			SELECT 
			COHORT_MONTH,
			COHORT_INDEX,
			COUNT(DISTINCT CUST_ID) AS CUST_COUNT
			FROM
			COHORT_DATA
			GROUP BY COHORT_MONTH,COHORT_INDEX
)
SELECT 
	* FROM 
	COH_RETENTION;

-- NOTE:
-- This step calculates the raw retention count by grouping customers 
-- based on their cohort month (first purchase month) and cohort index 
-- (number of months since first purchase). 
-- It counts the number of unique customers active in each time period, 
-- showing how many customers returned in subsequent months.
--***************************************************************************************************************************--

--GETTING THE RETENTION PERCENTAGE--

WITH COHORT AS(
				SELECT 
				CUST_ID,
				DATE_TRUNC('MONTH',MIN(ORDER_DATE)) AS COHORT_MONTH
				FROM
				COH_CLEAN_SALES
				GROUP BY CUST_ID
				),
COHORT_DATA AS(
				SELECT
				S.CUST_ID,
				S.ORDER_DATE,
				C.COHORT_MONTH,
				(DATE_PART('YEAR',S.ORDER_DATE)-DATE_PART('YEAR',C.COHORT_MONTH))*12+
				(DATE_PART('MONTH',S.ORDER_DATE)-DATE_PART('MONTH',C.COHORT_MONTH))
				AS COHORT_INDEX
				FROM
				COH_CLEAN_SALES S
				JOIN
				COHORT C
				ON
				S.CUST_ID=C.CUST_ID
				ORDER BY S.CUST_ID,S.ORDER_DATE
				
),
COH_RETENTION AS(
			SELECT 
			COHORT_MONTH,
			COHORT_INDEX,
			COUNT(DISTINCT CUST_ID) AS CUST_COUNT
			FROM
			COHORT_DATA
			GROUP BY COHORT_MONTH,COHORT_INDEX
),
COH_SIZE AS (
			SELECT 
			COHORT_MONTH,
			CUST_COUNT AS TOTAL_CUSTOMER
			FROM 
			COH_RETENTION 
			WHERE
			COHORT_INDEX=0
			
)
SELECT 
		R.COHORT_MONTH,
		R.COHORT_INDEX,
		R.CUST_COUNT,
		S.TOTAL_CUSTOMER,
		ROUND((R.CUST_COUNT*100.0/S.TOTAL_CUSTOMER),2) AS RETENTION_PERCENTAGE
		FROM
		COH_RETENTION R
		JOIN
		COH_SIZE S
		ON
		R.COHORT_MONTH=S.COHORT_MONTH
		ORDER BY
		R.COHORT_MONTH,R.COHORT_INDEX;
		
-- NOTE:
-- This step calculates the retention percentage by dividing the number 
-- of customers active in each cohort period by the total number of customers 
-- in the cohort (cohort_index = 0). 
-- It converts raw counts into percentages, making it easier to compare 
-- retention performance across different cohorts over time.	
--****************************************************************************************************************************--

--PERFORMING COHORT_MATRIX ANALYSIS--

WITH COHORT AS(
				SELECT 
				CUST_ID,
				DATE_TRUNC('MONTH',MIN(ORDER_DATE)) AS COHORT_MONTH
				FROM
				COH_CLEAN_SALES
				GROUP BY CUST_ID
				),
COHORT_DATA AS(
				SELECT
				S.CUST_ID,
				S.ORDER_DATE,
				C.COHORT_MONTH,
				(DATE_PART('YEAR',S.ORDER_DATE)-DATE_PART('YEAR',C.COHORT_MONTH))*12+
				(DATE_PART('MONTH',S.ORDER_DATE)-DATE_PART('MONTH',C.COHORT_MONTH))
				AS COHORT_INDEX
				FROM
				COH_CLEAN_SALES S
				JOIN
				COHORT C
				ON
				S.CUST_ID=C.CUST_ID
				ORDER BY S.CUST_ID,S.ORDER_DATE
				
),
COH_RETENTION AS(
			SELECT 
			COHORT_MONTH,
			COHORT_INDEX,
			COUNT(DISTINCT CUST_ID) AS CUST_COUNT
			FROM
			COHORT_DATA
			GROUP BY COHORT_MONTH,COHORT_INDEX
),
COH_SIZE AS (
			SELECT 
			COHORT_MONTH,
			CUST_COUNT AS TOTAL_CUSTOMER
			FROM 
			COH_RETENTION 
			WHERE
			COHORT_INDEX=0
			
),
RET_PCT AS (SELECT 
		R.COHORT_MONTH,
		R.COHORT_INDEX,
		R.CUST_COUNT,
		S.TOTAL_CUSTOMER,
		ROUND((R.CUST_COUNT*100.0/S.TOTAL_CUSTOMER),2) AS RETENTION_PERCENTAGE
		FROM
		COH_RETENTION R
		JOIN
		COH_SIZE S
		ON
		R.COHORT_MONTH=S.COHORT_MONTH
		)
SELECT
	COHORT_MONTH,
	ROUND(MAX(CASE WHEN COHORT_INDEX = 0 THEN RETENTION_PERCENTAGE END), 2) AS M0,
    ROUND(MAX(CASE WHEN COHORT_INDEX = 1 THEN RETENTION_PERCENTAGE END), 2) AS M1,
    ROUND(MAX(CASE WHEN COHORT_INDEX = 2 THEN RETENTION_PERCENTAGE END), 2) AS M2,
    ROUND(MAX(CASE WHEN COHORT_INDEX = 3 THEN RETENTION_PERCENTAGE END), 2) AS M3,
    ROUND(MAX(CASE WHEN COHORT_INDEX = 4 THEN RETENTION_PERCENTAGE END), 2) AS M4,
    ROUND(MAX(CASE WHEN COHORT_INDEX = 5 THEN RETENTION_PERCENTAGE END), 2) AS M5,
    ROUND(MAX(CASE WHEN COHORT_INDEX = 6 THEN RETENTION_PERCENTAGE END), 2) AS M6,
    ROUND(MAX(CASE WHEN COHORT_INDEX = 7 THEN RETENTION_PERCENTAGE END), 2) AS M7,
    ROUND(MAX(CASE WHEN COHORT_INDEX = 8 THEN RETENTION_PERCENTAGE END), 2) AS M8,
    ROUND(MAX(CASE WHEN COHORT_INDEX = 9 THEN RETENTION_PERCENTAGE END), 2) AS M9,
    ROUND(MAX(CASE WHEN COHORT_INDEX = 10 THEN RETENTION_PERCENTAGE END), 2) AS M10,
    ROUND(MAX(CASE WHEN COHORT_INDEX = 11 THEN RETENTION_PERCENTAGE END), 2) AS M11

FROM RET_PCT
GROUP BY COHORT_MONTH
ORDER BY COHORT_MONTH;
	
/*
COHORT MATRIX – EXPLANATION

1. The cohort matrix is the final output of cohort analysis where customer data is transformed into a time-based retention table.

2. Each row represents a COHORT_MONTH, which is the month in which customers made their first purchase.

3. Each column (M0, M1, M2 ... M11) represents COHORT_INDEX, which measures the number of months passed since the first purchase.

4. M0 represents the first purchase month for each cohort and is always 100% (baseline customers).

5. M1, M2, M3 ... represent the percentage of customers from the same cohort who returned or were active after 1, 2, 3 ... months.

6. Values are derived from retention percentage calculated earlier and reshaped using:
   - CASE WHEN COHORT_INDEX = X
   - MAX() to convert multiple rows into a single value per cohort-month-cell

7. The matrix converts long transactional data into a wide format for analysis.

8. It is used to analyze:
   - Customer retention trends
   - Churn patterns over time
   - Cohort-wise performance comparison
*/