import pandas as pd
from sqlalchemy import create_engine

# -----------------------------
# CONFIGURACIÓN DE CONEXIÓN
# -----------------------------
USER = "sa"
PASSWORD = "RETO7CONTRASEÑA123!"
HOST = "localhost"
PORT = "1437"
DB = "master"   # puedes crear otra si quieres

CONNECTION_STRING = (
    f"mssql+pyodbc://{USER}:{PASSWORD}@{HOST}:{PORT}/{DB}"
    "?driver=ODBC+Driver+18+for+SQL+Server"
)

# -----------------------------
# EXTRACT
# -----------------------------
print("📥 Leyendo CSV...")
df=pd.read_csv("../01_data/raw_sales_dump.csv")


print(df.head())
print(f"Filas cargadas: {len(df)}")

# -----------------------------
# LOAD (STAGING)
# -----------------------------
print("🔌 Conectando a SQL Server...")
engine = create_engine(
    "mssql+pyodbc://sa:RETO7CONTRASEÑA123!@localhost:1437/master"
    "?driver=ODBC+Driver+18+for+SQL+Server"
    "&TrustServerCertificate=yes"
)

print("📤 Cargando datos a RawSalesData...")
df.to_sql(
    name="RawSalesData",
    con=engine,
    if_exists="replace",   # borra y vuelve a crear
    index=False
)

print("✅ ETL completado: RawSalesData creada en SQL Server")
