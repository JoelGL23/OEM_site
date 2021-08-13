# Librerias para el correcto funcionamiento del script
library(DBI)
library(RPostgres)

dvr <- RPostgres::Postgres() #Función
db <- 'OpenEyesMex' # Basde de datos
host_db <- '172.17.0.1'
db_port <- '5432'
db_user <- 'postgres' # Usuario
db_password <- '123456' # Contraseña

# Conexión a la base de datos
con <- dbConnect(dvr, dbname = db, host = host_db, port = db_port,
                 user = db_user, password = db_password)

source("2_r_scripts/funciones.R")

query <- dbSendQuery(con, "CREATE SCHEMA IF NOT EXISTS control")

if(dbExistsTable(con, Id(schema = "control", table = "archivos_semanales")) &
   dbExistsTable(con, Id(schema = "control", table = "archivos_mensuales"))){
  
  fila <- 1
  
  resultado_consulta <- dbSendQuery(con, "SELECT * FROM control.archivos_semanales")
  consulta_semanal <- dbFetch(resultado_consulta) # Obtener los nelementos (filas) del conjunto de resultados
  dbClearResult(resultado_consulta) # Limpiar los resultados obtenidos de una consulta
  
  resultado_consulta <- dbSendQuery(con, "SELECT * FROM control.archivos_mensuales ORDER BY id_mensual DESC LIMIT 1")
  consulta_mensual <- dbFetch(resultado_consulta) # Obtener los nelementos (filas) del conjunto de resultados
  dbClearResult(resultado_consulta) # Limpiar los resultados obtenidos de una consulta
  
  resultado_consulta <- dbSendQuery(con, "SELECT ROW_NUMBER() OVER ( ORDER BY id_mensual ) FROM control.archivos_mensuales")
  num_fila_mes <- dbFetch(resultado_consulta) # Obtener los nelementos (filas) del conjunto de resultados
  num_fila_mes <- as.integer(tail(num_fila_mes$row_number,1))
  dbClearResult(resultado_consulta) # Limpiar los resultados obtenidos de una consulta
  
  resultado_consulta <- dbSendQuery(con, "SELECT ROW_NUMBER() OVER ( ORDER BY id_semanal ) FROM control.archivos_semanales")
  num_fila_sem <- dbFetch(resultado_consulta) # Obtener los nelementos (filas) del conjunto de resultados
  num_fila_sem <- as.integer(tail(num_fila_sem$row_number,1))
  dbClearResult(resultado_consulta) # Limpiar los resultados obtenidos de una consulta
  
  aux <- consulta_semanal
  aux <- aux[order(aux$dia),]
  
  primera_fila <- head(aux, 1)
  ultima_fila <- tail(aux, 1)
  
  rm(resultado_consulta)
  
  source("2_r_scripts/carga_mapa.R")
  
}else{
  
  source("2_r_scripts/valores_iniciales.R")
  
  table_id <- Id(schema = "control", table = "archivos_semanales")
  
  dbWriteTable(con, name = table_id, value = archivos_semanales, row.names = F)
  
  source("2_r_scripts/valores_semanales.R")
  
  table_id <- Id(schema = "control", table = "archivos_mensuales")
  
  dbWriteTable(con, name = table_id, value = archivos_mensuales, row.names = F)
  
  rm(list = ls())
  
  source("2_r_scripts/creacion_estructura.R")
  
}

query <- dbSendQuery(con, "CREATE SCHEMA IF NOT EXISTS originales")
query <- dbSendQuery(con, "CREATE SCHEMA IF NOT EXISTS preprocesamiento")
query <- dbSendQuery(con, "CREATE SCHEMA IF NOT EXISTS resultado_semanal")
query <- dbSendQuery(con, "CREATE SCHEMA IF NOT EXISTS resultado_mensual")

dbClearResult(query)
rm(query)