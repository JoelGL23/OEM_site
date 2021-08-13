resultado_consulta <- dbSendQuery(con, "SELECT * FROM control.archivos_semanales")
consulta_semanal <- dbFetch(resultado_consulta) # Obtener los nelementos (filas) del conjunto de resultados
dbClearResult(resultado_consulta) # Limpiar los resultados obtenidos de una consulta

rm(resultado_consulta)

while(consulta_semanal$dia_semana != "Sunday"){
  
  consulta_semanal$fecha_inicial <- update(consulta_semanal$fecha_inicial,
                                           mday = day(consulta_semanal$fecha_inicial)+1)
  
  valores_fecha <- obtener_valores_fecha(consulta_semanal$fecha_inicial)
  
  consulta_semanal$id_semanal <- paste("CAS", valores_fecha$dia, sep = "")
  
  consulta_semanal$anio <- valores_fecha$anio
  consulta_semanal$anio_ab <- valores_fecha$anio_ab
  consulta_semanal$mes <- valores_fecha$mes
  consulta_semanal$dia <- valores_fecha$dia
  consulta_semanal$dia_semana <- valores_fecha$dia_semana
  
  consulta_semanal$nombre_tabla_semanal <- paste("covid19mexico",valores_fecha$anio_ab, valores_fecha$mes, valores_fecha$dia, sep = "")
  
  dbWriteTable(con, name = table_id, value = consulta_semanal, row.names = F, append = T)
}

resultado_consulta <- dbSendQuery(con, "SELECT * FROM control.archivos_semanales")
consulta_semanal <- dbFetch(resultado_consulta) # Obtener los nelementos (filas) del conjunto de resultados
dbClearResult(resultado_consulta) # Limpiar los resultados obtenidos de una consulta

resultado_consulta <- dbSendQuery(con, "SELECT ROW_NUMBER() OVER ( ORDER BY id_semanal ) FROM control.archivos_semanales")
num_fila_sem <- dbFetch(resultado_consulta) # Obtener los nelementos (filas) del conjunto de resultados
num_fila_sem <- as.integer(tail(num_fila_sem$row_number,1))
dbClearResult(resultado_consulta) # Limpiar los resultados obtenidos de una consulta

rm(resultado_consulta)