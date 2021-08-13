consulta <- paste("SELECT fecha_def, diabetes, intubado, sexo, entidad_res 
                    FROM preprocesamiento." , consulta_semanal$nombre_tabla_semanal[[fila]],
                  " WHERE fecha_def != '9999-99-99'", sep = "")
# Querys
req <- dbSendQuery(con, consulta)
df7 <- dbFetch(req) # Obtener los nelementos (filas) del conjunto de resultados
dbClearResult(req) # Limpiar los resultados obtenidos de una consulta

# Creación de data frame
df7 <- as.data.frame(df7)

# Querys
consulta <- paste("SELECT clasificacion_final, diabetes, epoc, asma, hipertension, obesidad, 
                  inmusupr, renal_cronica, tabaquismo, sexo, entidad_res FROM  preprocesamiento.", 
                  consulta_semanal$nombre_tabla_semanal[[fila]],
                  " WHERE clasificacion_final = 'caso de covid-19 confirmado por asociación clínica epidemiológica'
                    OR clasificacion_final = 'caso de covid-19 confirmado por comité de  dictaminación'", sep = "")

req <- dbSendQuery(con, consulta)
df8 <- dbFetch(req) # Obtener los nelementos (filas) del conjunto de resultados
dbClearResult(req) # Limpiar los resultados obtenidos de una consulta

# Creación de data frame
df8 <- as.data.frame(df8)

consulta <- paste("SELECT sexo, fecha_ingreso, fecha_sintomas, fecha_def, edad 
                    FROM preprocesamiento.",consulta_semanal$nombre_tabla_semanal[[fila]],
                  " WHERE (clasificacion_final = 'caso de covid-19 confirmado por asociación clínica epidemiológica'
                    OR clasificacion_final = 'caso de covid-19 confirmado por comité de  dictaminación') 
                    AND fecha_def != '9999-99-99'", sep = "")

# Querys
req <- dbSendQuery(con, consulta)
df9 <- dbFetch(req) # Obtener los nelementos (filas) del conjunto de resultados
dbClearResult(req) # Limpiar los resultados obtenidos de una consulta

# Creación de data frame
df9 <- as.data.frame(df9)


consulta <- paste("SELECT intubado, sexo, fecha_def 
                     FROM preprocesamiento.",consulta_semanal$nombre_tabla_semanal[[fila]],
                  " WHERE clasificacion_final = 'caso de covid-19 confirmado por asociación clínica epidemiológica'
                    OR clasificacion_final = 'caso de covid-19 confirmado por comité de  dictaminación'", sep = "")

# Querys
req <- dbSendQuery(con, consulta)
df10 <- dbFetch(req) # Obtener los nelementos (filas) del conjunto de resultados
dbClearResult(req) # Limpiar los resultados obtenidos de una consulta

# Creación de data frame
df10 <- as.data.frame(df10)

consulta <- paste("SELECT cardiovascular, clasificacion_final 
                    FROM preprocesamiento.",consulta_semanal$nombre_tabla_semanal[[fila]],
                  " WHERE (clasificacion_final = 'caso de covid-19 confirmado por asociación clínica epidemiológica'
                    OR clasificacion_final = 'caso de covid-19 confirmado por comité de  dictaminación') 
                    AND fecha_def != '9999-99-99'", sep = "")


req <- dbSendQuery(con, consulta)
df11 <- dbFetch(req) # Obtener los nelementos (filas) del conjunto de resultados
dbClearResult(req) # Limpiar los resultados obtenidos de una consulta

# Creación de data frame
df11 <- as.data.frame(df11)