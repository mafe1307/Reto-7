/*
    RETO 7: FINANCIAL ANALYST PROTOCOL
    Autor: Maria Fernanda Torres
    Fecha: 2026-01-20
    
    Objetivo: Reporte financiero con métricas MoM y YTD
*/

-- 1. CTE DE LIMPIEZA
WITH CleanSales AS (
    SELECT
        ID_Transaccion,
        UPPER(Cliente) AS Cliente_Normalizado,
        Fecha_Venta,
        Cantidad,
        Precio_Unitario,
        Descuento,

        -- Total de venta por línea con descuento
        Cantidad * Precio_Unitario * (1 - Descuento) AS Total_Venta,

        -- Extracción temporal (SQL Server)
        YEAR(Fecha_Venta) AS Anio,
        MONTH(Fecha_Venta) AS Mes
    FROM RawSalesData
),

-- 2. CTE DE AGREGACIÓN MENSUAL
MonthlyMetrics AS (
    SELECT
        Anio,
        Mes,
        SUM(Total_Venta) AS Total_Ventas
    FROM CleanSales
    GROUP BY Anio, Mes
)

-- 3. CONSULTA FINAL (WINDOW FUNCTIONS)
SELECT
    Anio,
    Mes,
    Total_Ventas AS Venta_Mensual,

    -- Ventas del mes anterior
    LAG(Total_Ventas) OVER (
        ORDER BY Anio, Mes
    ) AS Venta_Mes_Anterior,

    -- Crecimiento Month over Month (%)
    ROUND(
        (
            (Total_Ventas - LAG(Total_Ventas) OVER (ORDER BY Anio, Mes))
            / NULLIF(LAG(Total_Ventas) OVER (ORDER BY Anio, Mes), 0)
        ) * 100,
        2
    ) AS Crecimiento_MoM_Porc,

    -- Acumulado Year To Date (se reinicia cada año)
    SUM(Total_Ventas) OVER (
        PARTITION BY Anio
        ORDER BY Mes
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS Acumulado_YTD

FROM MonthlyMetrics
ORDER BY Anio, Mes;
