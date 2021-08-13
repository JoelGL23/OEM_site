consulta <- paste("SELECT *
                    FROM originales.", consulta_semanal$nombre_tabla_semanal[[fila]],sep = "")

reqP <- dbSendQuery(con, consulta)
dfP <- dbFetch(reqP) # Obtener los nelementos (filas) del conjunto de resultados
dbClearResult(reqP) # Limpiar los resultados obtenidos de una consulta

# Creación de data frame
datos <- as.data.frame(dfP)
aux <- datos

rm(reqP)

datos$entidad_um <- plyr::mapvalues(datos$entidad_um, 
                                    c("1","2","3","4","5","6","7","8","9"),
                                    c("01","02","03","04","05","06","07","08","09"))

# Cambio de los valores
datos$entidad_res <- plyr::mapvalues(datos$entidad_res, 
                                     c("1","2","3","4","5","6","7","8","9"),
                                     c("01","02","03","04","05","06","07","08","09"))

datos$entidad_nac <- plyr::mapvalues(datos$entidad_nac, 
                                     c("1","2","3","4","5","6","7","8","9"),
                                     c("01","02","03","04","05","06","07","08","09"))

datos$municipio_res  <- plyr::mapvalues(datos$municipio_res, 
                                        c("1","2","3","4","5","6","7","8","9"),
                                        c("01","02","03","04","05","06","07","08","09"))

datos$edad <- plyr::mapvalues(datos$edad, 
                              c("0","1","2","3","4","5","6","7","8","9"),
                              c("00","01","02","03","04","05","06","07","08","09"))

datos$origen <- plyr::mapvalues(datos$origen,
                                c("1","2"),
                                c("usmer","fuera de usmer"))

datos$sector <- plyr::mapvalues(datos$sector,
                                c("1","2","3","4","5","6","7","8","9", "10", "11", "12", "13"),
                                c("cruz roja", "dif", "estatal", "imms", "imms-bienestar", "isste",
                                  "municipal", "pemex", "privada", "sedena", "semar", "ssa", 
                                  "universitario"))

datos$sexo <- plyr::mapvalues(datos$sexo,
                              c("1", "2"),
                              c("mujer", "hombre"))

datos$tipo_paciente <- plyr::mapvalues(datos$tipo_paciente,
                                       c("1", "2"),
                                       c("ambulatorio", "hospitalizado"))

datos$resultado_lab <- plyr::mapvalues(datos$resultado_lab,
                                       c("1","2","3","4"),
                                       c("positivo a sars-cov-2", "no positivo a sars-cov-2",
                                         "resultado pendiente", "resultado no adecuado"))

datos$resultado_antigeno <- plyr::mapvalues(datos$resultado_antigeno,
                                            c("1", "2"),
                                            c("positivo a sars-cov-2", "negativo a sars-cov-2"))

datos$nacionalidad <- plyr::mapvalues(datos$nacionalidad,
                                      c("1", "2"),
                                      c("mexicana", "extranjera"))

datos$clasificacion_final <- plyr::mapvalues(datos$clasificacion_final,
                                             c("1","2","3","4","5","6","7"),
                                             c("caso de covid-19 confirmado por asociación clínica epidemiológica",
                                               "caso de covid-19 confirmado por comité de  dictaminación",
                                               "caso de sars-cov-2  confirmado",
                                               "inválido por laboratorio",
                                               "no realizado por laboratorio",
                                               "caso sospechoso",
                                               "negativo a sars-cov-2"))

datos$pais_origen <- plyr::mapvalues(datos$pais_origen,
                                     c("97"),
                                     c("no aplica"))

datos[datos==1]<-"positivo"
datos[datos==2]<-"negativo"
datos[datos==97]<-"no aplica"
datos[datos==98]<-"se ignora"
datos[datos==99]<-"no especificado"

datos$edad <- aux$edad

datos$pais_origen <- gsub("<e1>", "a", datos$pais_origen)
datos$pais_origen <- gsub("<e9>", "e", datos$pais_origen)
datos$pais_origen <- gsub("<ed>", "i", datos$pais_origen)
datos$pais_origen <- gsub("<f3>", "o", datos$pais_origen)
datos$pais_origen <- gsub("<fa>", "u", datos$pais_origen)
datos$pais_origen <- gsub("<f1>", "n", datos$pais_origen)

table_id <- Id(schema = "preprocesamiento", table = consulta_semanal$nombre_tabla_semanal[[fila]])

dbWriteTable(con, name = table_id, value = datos, row.names = F)