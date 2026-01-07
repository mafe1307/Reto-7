/*
    RETO 7: FINANCIAL ANALYST PROTOCOL
    Autor: [Tu Nombre]
    Fecha: [Fecha]
    
    Objetivo: Reporte MoM (Month over Month) y YTD (Year to Date)
*/

-- 1. CTE DE LIMPIEZA
WITH CleanSales AS (
    SELECT
        ID_Transaccion,
        -- TO-DO: Normalizar nombre cliente (UPPER)
        -- TO-DO: Calcular Total_Linea (Precio * Cantidad)
        -- TO-DO: Extraer Año y Mes
    FROM RawSalesData
),

-- 2. CTE DE AGREGACIÓN MENSUAL
MonthlyMetrics AS (
    SELECT
        -- TO-DO: Agrupar por Año y Mes
        -- TO-DO: Sumar Total_Linea
    FROM CleanSales
    GROUP BY ...
)

-- 3. CONSULTA FINAL (WINDOW FUNCTIONS)
SELECT
    Anio,
    Mes,
    Total_Ventas,
    
    -- TO-DO: Usar LAG() para traer ventas mes anterior
    -- LAG(...) OVER (...) as Ventas_Mes_Anterior,
    
    -- TO-DO: Calcular % Crecimiento
    
    -- TO-DO: Calcular YTD (Running Total) reiniciando cada año
    -- SUM(...) OVER (PARTITION BY ... ORDER BY ...) as Acumulado_YTD

FROM MonthlyMetrics
ORDER BY Anio, Mes;
