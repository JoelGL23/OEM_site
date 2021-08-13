table_id <- Id(schema = "originales", table = consulta_semanal$nombre_tabla_semanal[[fila]])

dbWriteTable(con, name = table_id, value = datos, row.names = F)

source("2_r_scripts/carga_archivos_preprocesados.R")

consulta_semanal$descarga_semanal[[fila]] <- 1
consulta_semanal$descripcion_archivo_semanal[[fila]] <- paste("'", 'Base de datos actualizada', "'", sep = "")

actualizar_datos_fecha <- paste("UPDATE control.archivos_semanales SET ","descarga_semanal=",consulta_semanal$descarga_semanal[[fila]],
                                ",descripcion_archivo_semanal=",consulta_semanal$descripcion_archivo_semanal[[fila]],
                                " WHERE id_semanal=", consulta_semanal$id_semanal[[fila]])

actualizar_datos_fecha <- dbSendQuery(con, actualizar_datos_fecha)

dbFetch(actualizar_datos_fecha)
dbClearResult(actualizar_datos_fecha)

rm(actualizar_datos_fecha)