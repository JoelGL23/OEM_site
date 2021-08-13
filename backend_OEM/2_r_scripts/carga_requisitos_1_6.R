library(dplyr)

consulta <- paste("SELECT entidad_res, 'Confirmados con COVID-19' AS clasificacion,
                    COUNT (clasificacion_final) AS cantidad
                    FROM preprocesamiento.", consulta_semanal$nombre_tabla_semanal[[fila]],
                  " WHERE clasificacion_final = 'caso de covid-19 confirmado por asociación clínica epidemiológica'
                    OR clasificacion_final = 'caso de covid-19 confirmado por comité de  dictaminación'
                    GROUP BY entidad_res",sep = "")

req <- dbSendQuery(con, consulta)
df1 <- dbFetch(req) # Obtener los nelementos (filas) del conjunto de resultados
dbClearResult(req) # Limpiar los resultados obtenidos de una consulta

# Creación de data frame
df1 <- as.data.frame(df1)
df1$entidad_res <- as.factor(df1$entidad_res) # Cambio del tipo de dato
df1 <- cbind(fecha = consulta_semanal$fecha_inicial[[fila]], df1)

nombre_tabla <- "df1"

carga_df(esquema, nombre_tabla, df1)

# ---------------------------------------------------------------------------------

consulta <- paste("SELECT pais_origen, 'Confirmados con COVID-19' AS clasificacion,
                    COUNT (clasificacion_final) AS cantidad
                    FROM preprocesamiento.", consulta_semanal$nombre_tabla_semanal[[fila]],
                  " WHERE (clasificacion_final = 'caso de covid-19 confirmado por asociación clínica epidemiológica'
                    OR clasificacion_final = 'caso de covid-19 confirmado por comité de  dictaminación')
                    AND pais_origen != 'no aplica'
                    GROUP BY pais_origen",sep = "")

req <- dbSendQuery(con, consulta)
df2 <- dbFetch(req) # Obtener los nelementos (filas) del conjunto de resultados
dbClearResult(req) # Limpiar los resultados obtenidos de una consulta
df2 <- cbind(fecha = consulta_semanal$fecha_inicial[[fila]], df2)

nombre_tabla <- "df2"

carga_df(esquema, nombre_tabla, df2)

# ----------------------------------------------------------------------------------------

consulta <- paste("SELECT sexo, 'Niñez' Categoria_edad, 'Menores de 13 años' Rango, 1 Orden,
                    COUNT(sexo) Cantidad_confirmados_COVID
                    FROM preprocesamiento.", consulta_semanal$nombre_tabla_semanal[[fila]],
                  " WHERE (clasificacion_final = 'caso de covid-19 confirmado por asociación clínica epidemiológica'
                    OR clasificacion_final = 'caso de covid-19 confirmado por comité de  dictaminación')
                     AND fecha_def != '9999-99-99'
                     AND edad <=13
                    GROUP BY sexo

                  UNION

                  SELECT sexo, 'Adolescencia' Categoria_edad, 'Entre 14 y 17 años' Rango, 2 Orden,
                  COUNT(sexo) Cantidad_confirmados_COVID
                  FROM preprocesamiento.", consulta_semanal$nombre_tabla_semanal[[fila]],
                  " WHERE (clasificacion_final = 'caso de covid-19 confirmado por asociación clínica epidemiológica'
                    OR clasificacion_final = 'caso de covid-19 confirmado por comité de  dictaminación')
                     AND fecha_def != '9999-99-99'
                     AND edad between 14 AND 17
                     GROUP BY sexo

                  UNION

                  SELECT sexo, 'Adultos' Categoria_edad, 'Entre 18 y 54 años' Rango, 3 Orden,
                  COUNT(sexo) Cantidad_confirmados_COVID
                  FROM preprocesamiento.", consulta_semanal$nombre_tabla_semanal[[fila]],
                  " WHERE (clasificacion_final = 'caso de covid-19 confirmado por asociación clínica epidemiológica'
                    OR clasificacion_final = 'caso de covid-19 confirmado por comité de  dictaminación')
                     AND fecha_def != '9999-99-99'
                     AND edad between 18 AND 54
                     GROUP BY sexo

                  UNION
                  
                  SELECT sexo, 'Tercera Edad' Categoria_edad, 'Mayor de 54 años' Rango, 4 Orden, 
                  COUNT(sexo) Cantidad_confirmados_COVID
                  FROM preprocesamiento.", consulta_semanal$nombre_tabla_semanal[[fila]],
                  " WHERE (clasificacion_final = 'caso de covid-19 confirmado por asociación clínica epidemiológica'
                    OR clasificacion_final = 'caso de covid-19 confirmado por comité de  dictaminación')
                     AND fecha_def != '9999-99-99'
                     AND edad > 54
                  GROUP BY sexo",sep = "")

req <- dbSendQuery(con, consulta)
df3 <- dbFetch(req) # Obtener los nelementos (filas) del conjunto de resultados
dbClearResult(req) # Limpiar los resultados obtenidos de una consulta

df3 <- df3[order(df3$orden),]
df3 <- cbind(fecha = consulta_semanal$fecha_inicial[[fila]], df3)

nombre_tabla <- "df3"

carga_df(esquema, nombre_tabla, df3)

# ---------------------------------------------------------------------------------------------

consulta <- paste("SELECT entidad_res, clasificacion_final,
                    COUNT (clasificacion_final) AS cantidad
                    FROM preprocesamiento.", consulta_semanal$nombre_tabla_semanal[[fila]],
                  " GROUP BY entidad_res, clasificacion_final",sep = "")

req <- dbSendQuery(con, consulta)
df4 <- dbFetch(req) # Obtener los nelementos (filas) del conjunto de resultados
dbClearResult(req) # Limpiar los resultados obtenidos de una consulta

df4 <- mex_map_es %>% left_join(df4, by = c("CODE" = "entidad_res"))
df4$geometry <- NULL
df4 <- cbind(fecha = consulta_semanal$fecha_inicial[[fila]], df4)
names(df4)[names(df4) == "NAME"] <- "entidad"

nombre_tabla <- "df4"

carga_df(esquema, nombre_tabla, df4)

# ------------------------------------------------------------------------------------------------

consulta <- paste("SELECT entidad_res, 'Diabetes' as enfermedad,
                    COUNT (diabetes) cantidad_enfermos
                    FROM preprocesamiento.", consulta_semanal$nombre_tabla_semanal[[fila]],
                  " WHERE diabetes = 'positivo'
                    GROUP BY 1,2
                    
                  UNION
                  
                  SELECT entidad_res, 'Epoc' as enfermedad,
                    COUNT (epoc) cantidad_enfermos
                    FROM preprocesamiento.", consulta_semanal$nombre_tabla_semanal[[fila]],
                  " WHERE epoc = 'positivo'
                    GROUP BY 1,2
                    
                  UNION
                  
                  SELECT entidad_res, 'Asma' as enfermedad,
                    COUNT (asma) cantidad_enfermos
                    FROM preprocesamiento.", consulta_semanal$nombre_tabla_semanal[[fila]],
                  " WHERE asma = 'positivo'
                    GROUP BY 1,2
                    
                  UNION
                  
                  SELECT entidad_res, 'COVID-19' as enfermedad,
                    COUNT (clasificacion_final) cantidad_enfermos
                    FROM preprocesamiento.", consulta_semanal$nombre_tabla_semanal[[fila]],
                  " WHERE clasificacion_final = 'caso de covid-19 confirmado por asociación clínica epidemiológica'
                    OR clasificacion_final = 'caso de covid-19 confirmado por comité de  dictaminación'
                    GROUP BY 1,2
                    
                  UNION
                  
                  SELECT entidad_res, 'inmusupr' as enfermedad,
                    COUNT (inmusupr) cantidad_enfermos
                    FROM preprocesamiento.", consulta_semanal$nombre_tabla_semanal[[fila]],
                  " WHERE inmusupr = 'positivo'
                    GROUP BY 1,2
                    
                  UNION
                  
                  SELECT entidad_res, 'hipertension' as enfermedad,
                    COUNT (hipertension) cantidad_enfermos
                    FROM preprocesamiento.", consulta_semanal$nombre_tabla_semanal[[fila]],
                  " WHERE hipertension = 'positivo'
                    GROUP BY 1,2
                    
                  UNION
                  
                  SELECT entidad_res, 'otra_com' as enfermedad,
                    COUNT (otra_com) cantidad_enfermos
                    FROM preprocesamiento.", consulta_semanal$nombre_tabla_semanal[[fila]],
                  " WHERE otra_com = 'positivo'
                    GROUP BY 1,2
                    
                  UNION
                  
                  SELECT entidad_res, 'cardiovascular' as enfermedad,
                    COUNT (cardiovascular) cantidad_enfermos
                    FROM preprocesamiento.", consulta_semanal$nombre_tabla_semanal[[fila]],
                  " WHERE cardiovascular = 'positivo'
                    GROUP BY 1,2
                    
                  UNION
                  
                  SELECT entidad_res, 'renal_cronica' as enfermedad,
                    COUNT (renal_cronica) cantidad_enfermos
                    FROM preprocesamiento.", consulta_semanal$nombre_tabla_semanal[[fila]],
                  " WHERE renal_cronica = 'positivo'
                    GROUP BY 1,2
                    
                  UNION
                  
                  SELECT entidad_res, 'obesidad' as enfermedad,
                    COUNT (obesidad) cantidad_enfermos
                    FROM preprocesamiento.", consulta_semanal$nombre_tabla_semanal[[fila]],
                  " WHERE obesidad = 'positivo'
                    GROUP BY 1,2",sep = "")

req <- dbSendQuery(con, consulta)
df5 <- dbFetch(req) # Obtener los nelementos (filas) del conjunto de resultados
dbClearResult(req) # Limpiar los resultados obtenidos de una consulta

df5 <- mex_map_es %>% left_join(df5, by = c("CODE" = "entidad_res"))
df5$geometry <- NULL
df5 <- cbind(fecha = consulta_semanal$fecha_inicial[[fila]], df5)
names(df5)[names(df5) == "NAME"] <- "entidad"

nombre_tabla <- "df5"

carga_df(esquema, nombre_tabla, df5)

# --------------------------------------------------------------------------------------------------

consulta <-paste("SELECT  rango_edad, con_asma, con_embarazo, Cantidad_casos FROM (
  
  SELECT 'Menores de 31 años' as rango_edad , 
  CASE WHEN embarazo = 'positivo' THEN 'Embarazada' else 'No embarazada' end as Con_embarazo , 
  CASE WHEN asma = 'positivo' THEN 'Asmatica' else 'No asmatica' end as Con_asma , count(*) Cantidad_casos
  FROM preprocesamiento." , consulta_semanal$nombre_tabla_semanal[[fila]],
                 " WHERE fecha_def != '9999-99-99' AND sexo = 'mujer'
  and embarazo in ('positivo','negativo')
  and asma in ('positivo','negativo')  AND edad <= 30
  group by 1,2,3
  union
  
  SELECT 'Mayores de 31 años' as rango_edad , 
  case when embarazo = 'positivo' then 'Embarazada' else 'No embarazada' end as Con_embarazo , 
  case when asma = 'positivo' then 'Asmatica' else 'No asmatica' end as Con_asma , count(*) Cantidad_casos 
  FROM preprocesamiento." , consulta_semanal$nombre_tabla_semanal[[fila]],
                 " WHERE fecha_def != '9999-99-99' AND sexo = 'mujer'
  and embarazo in ('positivo','negativo')
  and asma in ('positivo','negativo')  AND edad > 30
  group by 1,2,3
  
) as Z", sep= "")

req <- dbSendQuery(con, consulta)
df6 <- dbFetch(req) # Obtener los nelementos (filas) del conjunto de resultados
dbClearResult(req) # Limpiar los resultados obtenidos de una consulta
df6 <- cbind(fecha = consulta_semanal$fecha_inicial[[fila]], df6)

nombre_tabla <- "df6"

carga_df(esquema, nombre_tabla, df6)