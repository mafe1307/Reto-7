# 📈 Reto 7: The Financial Analyst Protocol

**Diplomado en Gestión de Datos 2026 | Módulo SQL Avanzado (OLAP)**

## 🛑 Situación de Negocio
El CFO (Director Financiero) de la compañía necesita un reporte de **Crecimiento y Acumulados** para la junta directiva de mañana. Excel ha colapsado debido al volumen de datos y las fórmulas se rompen.

Te han entregado un archivo plano (`raw_sales_dump.csv`) con 2 años de historia transaccional.

## 🎯 Tu Misión
Construir una **Consulta SQL Única (Single Query)** utilizando CTEs y Window Functions que transforme los datos crudos en un reporte financiero profesional.

---

## ⚙️ Paso 1: Generar los Datos (Obligatorio)
Este repositorio incluye un generador de datos simulados. Antes de empezar a programar en SQL, debes crear el archivo CSV.

1.  Asegúrate de tener Python instalado.
2.  Abre una terminal en la carpeta `02_scripts_python`.
3.  Ejecuta el script:
    ```bash
    python generador_datos.py
    ```
4.  Verifica que apareció el archivo `raw_sales_dump.csv` en la carpeta `01_data`.

---

## 🛠️ Paso 2: El Reto SQL
Abre el archivo `03_sql_solutions/plantilla_solucion.sql` y completa los siguientes requerimientos usando **una sola estructura de CTEs**:

1.  **CTE de Limpieza (`CleanData`):**
    * Estandariza los nombres de los clientes (ej: `UPPER()`).
    * Calcula el `Total_Venta` (Cantidad * Precio * (1-Descuento)).
    * Extrae `Anio` y `Mes` de la fecha.

2.  **CTE de Agregación (`MonthlySales`):**
    * Agrupa las ventas por `Anio` y `Mes`.
    * Suma el total vendido.

3.  **SELECT Final (Analítica Avanzada):**
    * **Venta Mensual:** El valor del mes actual.
    * **Venta Mes Anterior:** Usa `LAG()` para traer el valor del mes previo.
    * **Crecimiento MoM (%):** Calcula la variación porcentual: `((Actual - Anterior) / Anterior) * 100`.
    * **Acumulado YTD:** Usa `SUM() OVER(PARTITION BY Anio ORDER BY Mes)` para calcular cuánto se lleva vendido en el año hasta ese mes.

## 📦 Entregable
Sube a la plataforma un PDF (`Reporte_Financiero.pdf`) en la carpeta `04_docs_entregables` que contenga:
1.  El código SQL final.
2.  Una captura de pantalla de los resultados donde se vea claramente el **reinicio del acumulado (YTD)** al cambiar de año (Diciembre a Enero).

¡Éxito, Analista!
