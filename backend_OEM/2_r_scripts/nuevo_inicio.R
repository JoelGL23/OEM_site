consulta_semanal$fecha_inicial[[fila]] <- update(consulta_semanal$fecha_inicial[[fila]], 
                                                 year = year(consulta_semanal$fecha_inicial[[fila]]), 
                                                 month = month(consulta_semanal$fecha_inicial[[fila]]), 
                                                 mday = day(consulta_semanal$fecha_inicial[[fila]])+1)

descarga_semanal <- 2
descripcion_archivo_semanal <- "pendiente"

valores_fecha <- obtener_valores_fecha(consulta_semanal$fecha_inicial[[fila]])

consulta_semanal$id_semanal[[fila]] <- paste("CAS", valores_fecha$dia, sep = "")

nombre_tabla_semanal <- paste("covid19mexico",valores_fecha$anio_ab, valores_fecha$mes, valores_fecha$dia, sep = "")

archivos_semanales <- data.frame(consulta_semanal$id_semanal[[fila]],
                                 consulta_semanal$fecha_inicial[[fila]],
                                 valores_fecha[,],
                                 descarga_semanal,
                                 descripcion_archivo_semanal,
                                 nombre_tabla_semanal)
colnames(archivos_semanales)[1] <- "id_semanal"
colnames(archivos_semanales)[2] <- "fecha_inicial"

table_id <- Id(schema = "control", table = "archivos_semanales")

dbWriteTable(con, name = table_id, value = archivos_semanales, row.names = F, overwrite = T)