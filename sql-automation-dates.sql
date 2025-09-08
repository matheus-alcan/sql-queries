SELECT *
FROM sandbox.sales_data  
WHERE
    CONVERT(DATE, record_date) -- Caso record_date não seja datetime, use CAST(record_date AS DATE)
    BETWEEN
    CAST(
        CASE
            WHEN DATEPART(WEEKDAY, DATEFROMPARTS(YEAR(GETDATE()), MONTH(GETDATE()), DAY(GETDATE()))) IN (2, 3) -- Caso seja D-1 não inclua terça-feira WEEKDAY = 3
                THEN DATEFROMPARTS(YEAR(DATEADD(DAY, -4, GETDATE())), MONTH(DATEADD(DAY, -4, GETDATE())), 1) -- Caso seja D-1 subtraia 3 dias e pegue o primeiro do mês correspondente
            ELSE DATEFROMPARTS(YEAR(GETDATE()), MONTH(GETDATE()), 1)
        END AS DATE
    )
    AND
    CAST(
        CASE
            WHEN DATEPART(WEEKDAY, GETDATE()) IN (2, 3) -- Caso seja D-1 não inclua terça-feira WEEKDAY = 3
                THEN DATEADD(DAY, -4, GETDATE()) -- Caso seja D-1 subtraia 3 dias
            ELSE DATEADD(DAY, -2, GETDATE()) -- Caso seja D-1 subtraia 1 dias
        END AS DATE

    )


