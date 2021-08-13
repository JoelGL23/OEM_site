id_mensual <- paste("CAM", num_fila_mes+1, sep = "")
primer_dia <- format(as.Date(consulta_semanal$fecha_inicial[[1]],"%Y-%m-%d"),'%d')
anio_mes <- as.Date(consulta_semanal$fecha_inicial[[1]],"%Y-%m-%d")
anio_mes <- substring(anio_mes,1,8)
primer_dia_fecha <- as.Date(paste(anio_mes,primer_dia,sep = ""))
dia_intermerdio <- as.integer(days_in_month(consulta_semanal$fecha_inicial[[1]])/2)
dia_intermerdio <- as.character(dia_intermerdio)
dia_intermerdio_fecha <- as.Date(paste(anio_mes,dia_intermerdio,sep = ""))
ultimo_dia <- as.character(days_in_month(consulta_semanal$fecha_inicial[[1]]))
ultimo_dia_fecha  <- as.Date(paste(anio_mes,ultimo_dia,sep = ""))

archivos_mensuales <- data.frame(id_mensual,
                                 primer_dia,
                                 primer_dia_fecha,
                                 dia_intermerdio,
                                 dia_intermerdio_fecha,
                                 ultimo_dia,
                                 ultimo_dia_fecha)

table_id <- Id(schema = "control", table = "archivos_mensuales")

dbWriteTable(con, name = table_id, value = archivos_mensuales, row.names = F, append = T)

resultado_consulta <- dbSendQuery(con, "SELECT * FROM control.archivos_mensuales ORDER BY id_mensual DESC LIMIT 1")
consulta_mensual <- dbFetch(resultado_consulta) # Obtener los nelementos (filas) del conjunto de resultados
dbClearResult(resultado_consulta) # Limpiar los resultados obtenidos de una consulta

resultado_consulta <- dbSendQuery(con, "SELECT ROW_NUMBER() OVER ( ORDER BY id_mensual ) FROM control.archivos_mensuales")
num_fila_mes <- dbFetch(resultado_consulta) # Obtener los nelementos (filas) del conjunto de resultados
num_fila_mes <- as.integer(tail(num_fila_mes$row_number,1))
dbClearResult(resultado_consulta) # Limpiar los resultados obtenidos de una consulta

rm(id_mensual, primer_dia, primer_dia_fecha, dia_intermerdio, dia_intermerdio_fecha, 
   ultimo_dia, ultimo_dia_fecha, table_id, resultado_consulta)