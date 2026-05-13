clean.fact_orders
  CREATE   VIEW [clean].[fact_orders] AS
SELECT
    o.OrderKey AS order_key,
    o.CustomerKey AS customer_key,
    o.StoreKey AS store_key,

    CAST(o.DT AS date) AS order_date,
    CONVERT(varchar(8), CAST(o.DT AS date), 112) AS order_date_key,

    CAST(o.DeliveryDate AS date) AS delivery_date,
    CONVERT(varchar(8), CAST(o.DeliveryDate AS date), 112) AS delivery_date_key,

    NULLIF(LTRIM(RTRIM(o.CurrencyCode)), '') AS currency_code,

    CONCAT(
        CONVERT(varchar(8), CAST(o.DT AS date), 112),
        '-',
        NULLIF(LTRIM(RTRIM(o.CurrencyCode)), ''),
        '-USD'
    ) AS currency_exchange_key,

    SUM(orows.Quantity) AS total_quantity,
    SUM(orows.Quantity * orows.UnitPrice) AS gross_order_amount,
    SUM(orows.Quantity * orows.NetPrice) AS net_order_amount,
    SUM(orows.Quantity * orows.UnitCost) AS order_cost_amount,
    SUM(orows.Quantity * (orows.NetPrice - orows.UnitCost)) AS order_margin_amount
FROM dbo.orders o
LEFT JOIN dbo.orderrows orows
    ON o.OrderKey = orows.OrderKey
WHERE o.OrderKey IS NOT NULL
  AND o.CustomerKey IS NOT NULL
  AND o.StoreKey IS NOT NULL
GROUP BY
    o.OrderKey,
    o.CustomerKey,
    o.StoreKey,
    CAST(o.DT AS date),
    CONVERT(varchar(8), CAST(o.DT AS date), 112),
    CAST(o.DeliveryDate AS date),
    CONVERT(varchar(8), CAST(o.DeliveryDate AS date), 112),
    NULLIF(LTRIM(RTRIM(o.CurrencyCode)), ''),
    CONCAT(
        CONVERT(varchar(8), CAST(o.DT AS date), 112),
        '-',
        NULLIF(LTRIM(RTRIM(o.CurrencyCode)), ''),
        '-USD'
    );


clean.fact_sales
  CREATE   VIEW [clean].[fact_sales] AS
SELECT
    CONCAT(
        CAST(OrderKey AS varchar(30)),
        '-',
        CAST(LineNumber AS varchar(10))
    ) AS sales_key,

    OrderKey AS order_key,
    LineNumber AS line_number,

    CustomerKey AS customer_key,
    StoreKey AS store_key,
    ProductKey AS product_key,

    CAST(OrderDate AS date) AS order_date,
    CONVERT(varchar(8), CAST(OrderDate AS date), 112) AS order_date_key,

    CAST(DeliveryDate AS date) AS delivery_date,
    CONVERT(varchar(8), CAST(DeliveryDate AS date), 112) AS delivery_date_key,

    NULLIF(LTRIM(RTRIM(CurrencyCode)), '') AS currency_code,

    CONCAT(
        CONVERT(varchar(8), CAST(OrderDate AS date), 112),
        '-',
        NULLIF(LTRIM(RTRIM(CurrencyCode)), ''),
        '-USD'
    ) AS currency_exchange_key,

    ExchangeRate AS exchange_rate,

    Quantity AS quantity,
    UnitPrice AS unit_price,
    NetPrice AS net_price,
    UnitCost AS unit_cost,

    Quantity * UnitPrice AS gross_sales_amount,
    Quantity * NetPrice AS net_sales_amount,
    Quantity * UnitCost AS cost_amount,
    Quantity * (NetPrice - UnitCost) AS margin_amount
FROM dbo.sales
WHERE OrderKey IS NOT NULL
  AND LineNumber IS NOT NULL
  AND CustomerKey IS NOT NULL
  AND StoreKey IS NOT NULL
  AND ProductKey IS NOT NULL;
