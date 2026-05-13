clean.dim_customers
  CREATE   VIEW [clean].[dim_customers] AS
SELECT
    CustomerKey AS customer_key,
    GeoAreaKey AS geo_area_key,

    CAST(StartDT AS date) AS start_date,
    CAST(EndDT AS date) AS end_date,

    NULLIF(LTRIM(RTRIM(Continent)), '') AS continent,
    NULLIF(LTRIM(RTRIM(Gender)), '') AS gender,
    NULLIF(LTRIM(RTRIM(Title)), '') AS title,

    NULLIF(LTRIM(RTRIM(GivenName)), '') AS first_name,
    NULLIF(LTRIM(RTRIM(MiddleInitial)), '') AS middle_initial,
    NULLIF(LTRIM(RTRIM(Surname)), '') AS last_name,

    NULLIF(
        LTRIM(RTRIM(
            CONCAT(
                GivenName,
                CASE 
                    WHEN MiddleInitial IS NOT NULL 
                         AND LTRIM(RTRIM(MiddleInitial)) <> ''
                    THEN ' ' + MiddleInitial + '.'
                    ELSE ''
                END,
                ' ',
                Surname
            )
        )),
        ''
    ) AS customer_full_name,

    NULLIF(LTRIM(RTRIM(StreetAddress)), '') AS street_address,
    NULLIF(LTRIM(RTRIM(City)), '') AS city,
    NULLIF(LTRIM(RTRIM(State)), '') AS state_code,
    NULLIF(LTRIM(RTRIM(StateFull)), '') AS state_name,
    NULLIF(LTRIM(RTRIM(ZipCode)), '') AS zip_code,
    NULLIF(LTRIM(RTRIM(Country)), '') AS country_code,
    NULLIF(LTRIM(RTRIM(CountryFull)), '') AS country_name,

    CAST(Birthday AS date) AS birth_date,
    Age AS age,

    NULLIF(LTRIM(RTRIM(Occupation)), '') AS occupation,
    NULLIF(LTRIM(RTRIM(Company)), '') AS company,
    NULLIF(LTRIM(RTRIM(Vehicle)), '') AS vehicle,

    Latitude AS latitude,
    Longitude AS longitude
FROM dbo.customer
WHERE CustomerKey IS NOT NULL;



clean.dim_product
  CREATE   VIEW [clean].[dim_product] AS
SELECT
    ProductKey AS product_key,

    NULLIF(LTRIM(RTRIM(ProductCode)), '') AS product_code,
    NULLIF(LTRIM(RTRIM(ProductName)), '') AS product_name,
    NULLIF(LTRIM(RTRIM(Manufacturer)), '') AS manufacturer,
    NULLIF(LTRIM(RTRIM(Brand)), '') AS brand,
    NULLIF(LTRIM(RTRIM(Color)), '') AS color,

    NULLIF(LTRIM(RTRIM(WeightUnit)), '') AS weight_unit,
    Weight AS weight,

    Cost AS cost,
    Price AS price,

    CategoryKey AS category_key,
    NULLIF(LTRIM(RTRIM(CategoryName)), '') AS category_name,

    SubCategoryKey AS subcategory_key,
    NULLIF(LTRIM(RTRIM(SubCategoryName)), '') AS subcategory_name
FROM dbo.product
WHERE ProductKey IS NOT NULL;



clean.dim_stores
  CREATE   VIEW [clean].[dim_stores] AS
SELECT
    StoreKey AS store_key,
    StoreCode AS store_code,
    GeoAreaKey AS geo_area_key,

    NULLIF(LTRIM(RTRIM(CountryCode)), '') AS country_code,

    CASE
        WHEN UPPER(LTRIM(RTRIM(CountryName))) = 'ONLINE'
        THEN NULL
        ELSE NULLIF(LTRIM(RTRIM(CountryName)), '')
    END AS country_name,

    CASE
        WHEN UPPER(LTRIM(RTRIM(CountryName))) = 'ONLINE'
        THEN 'Online Store'
        ELSE 'Physical Store'
    END AS store_type,

    NULLIF(LTRIM(RTRIM(State)), '') AS state,

    CAST(OpenDate AS date) AS open_date,
    CAST(CloseDate AS date) AS close_date,

    NULLIF(LTRIM(RTRIM(Description)), '') AS store_description,
    SquareMeters AS square_meters,
    NULLIF(LTRIM(RTRIM(Status)), '') AS store_status
FROM dbo.store
WHERE StoreKey IS NOT NULL;



clean.dim_dates
  CREATE   VIEW [clean].[dim_dates] AS
SELECT
    DateKey AS date_key,
    CAST([Date] AS date) AS full_date,

    [Year] AS year_number,
    NULLIF(LTRIM(RTRIM(YearQuarter)), '') AS year_quarter,
    YearQuarterNumber AS year_quarter_number,
    NULLIF(LTRIM(RTRIM([Quarter])), '') AS quarter_name,

    NULLIF(LTRIM(RTRIM(YearMonth)), '') AS year_month,
    NULLIF(LTRIM(RTRIM(YearMonthShort)), '') AS year_month_short,
    YearMonthNumber AS year_month_number,

    NULLIF(LTRIM(RTRIM([Month])), '') AS month_name,
    NULLIF(LTRIM(RTRIM(MonthShort)), '') AS month_short_name,
    MonthNumber AS month_number,

    NULLIF(LTRIM(RTRIM(DayofWeek)), '') AS day_of_week,
    NULLIF(LTRIM(RTRIM(DayofWeekShort)), '') AS day_of_week_short,
    DayofWeekNumber AS day_of_week_number,

    WorkingDay AS is_working_day,
    WorkingDayNumber AS working_day_number
FROM dbo.[date]
WHERE [Date] IS NOT NULL;



clean.dim_currency_exchange
    CREATE   VIEW [clean].[dim_currency_exchange] AS
SELECT
    CONCAT(
        CONVERT(varchar(8), CAST([Date] AS date), 112),
        '-',
        NULLIF(LTRIM(RTRIM(FromCurrency)), ''),
        '-',
        NULLIF(LTRIM(RTRIM(ToCurrency)), '')
    ) AS currency_exchange_key,

    CAST([Date] AS date) AS exchange_date,
    CONVERT(varchar(8), CAST([Date] AS date), 112) AS exchange_date_key,

    NULLIF(LTRIM(RTRIM(FromCurrency)), '') AS from_currency_code,
    NULLIF(LTRIM(RTRIM(ToCurrency)), '') AS to_currency_code,

    Exchange AS exchange_rate
FROM dbo.currencyexchange
WHERE [Date] IS NOT NULL
  AND FromCurrency IS NOT NULL
  AND ToCurrency IS NOT NULL;



clean.dim_order_rows
  CREATE   VIEW [clean].[dim_order_rows] AS
SELECT
    CONCAT(
        CAST(OrderKey AS varchar(30)),
        '-',
        CAST(RowNumber AS varchar(10))
    ) AS order_row_key,

    OrderKey AS order_key,
    RowNumber AS row_number,
    ProductKey AS product_key,

    Quantity AS quantity,
    UnitPrice AS unit_price,
    NetPrice AS net_price,
    UnitCost AS unit_cost,

    Quantity * UnitPrice AS gross_line_amount,
    Quantity * NetPrice AS net_line_amount,
    Quantity * UnitCost AS line_cost_amount,
    Quantity * (NetPrice - UnitCost) AS line_margin_amount
FROM dbo.orderrows
WHERE OrderKey IS NOT NULL
  AND RowNumber IS NOT NULL
  AND ProductKey IS NOT NULL;
