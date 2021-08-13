consulta <- paste("SELECT clasificacion_final,
                    COUNT (clasificacion_final) as resultado_covid
                    FROM preprocesamiento.", consulta_semanal$nombre_tabla_semanal[[fila]],
                  " GROUP BY clasificacion_final",sep = "")

reqD <- dbSendQuery(con, consulta)
dfD <- dbFetch(reqD) # Obtener los nelementos (filas) del conjunto de resultados
dbClearResult(reqD) # Limpiar los resultados obtenidos de una consulta

# Creación de data frame
requisito_diario_covid <- as.data.frame(dfD)
requisito_diario_covid <- cbind(fecha = consulta_semanal$fecha_inicial[[fila]], requisito_diario_covid)

table_id <- Id(schema = "resultado_semanal", table = "df12")

dbWriteTable(con, name = table_id, value = requisito_diario_covid, row.names = F, append = T)

table_id <- Id(schema = "resultado_mensual", table = "df12")

dbWriteTable(con, name = table_id, value = requisito_diario_covid, row.names = F, append = T)

consulta <- paste("SELECT clasificacion_final,
                    COUNT (clasificacion_final) as resultado_covid
                    FROM preprocesamiento.", consulta_semanal$nombre_tabla_semanal[[fila]],
                  " WHERE (clasificacion_final = 'caso de covid-19 confirmado por asociación clínica epidemiológica'
                    OR clasificacion_final = 'caso de covid-19 confirmado por comité de  dictaminación')
                     AND fecha_def != '9999-99-99'
                    GROUP BY clasificacion_final",sep = "")

reqD <- dbSendQuery(con, consulta)
dfD <- dbFetch(reqD) # Obtener los nelementos (filas) del conjunto de resultados
dbClearResult(reqD) # Limpiar los resultados obtenidos de una consulta

# Creación de data frame
requisito_diario_m_covid <- as.data.frame(dfD)
requisito_diario_m_covid <- cbind(fecha = consulta_semanal$fecha_inicial[[fila]], requisito_diario_m_covid)

table_id <- Id(schema = "resultado_semanal", table = "df13")

dbWriteTable(con, name = table_id, value = requisito_diario_m_covid, row.names = F, append = T)

table_id <- Id(schema = "resultado_mensual", table = "df13")

dbWriteTable(con, name = table_id, value = requisito_diario_m_covid, row.names = F, append = T)

rm(reqD)
