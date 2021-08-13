source("2_r_scripts/RPostgres.R")

# Agrupación de los datos deseados
temptotal <- summarise(group_by(df7, sexo, entidad_res), Freq = n())

tempDif <- summarise(group_by(df7, diabetes, sexo, entidad_res), Freq = n())
tempDif <- subset(tempDif, tempDif$diabetes == "positivo")

tempInt <- summarise(group_by(df7, diabetes, sexo, intubado, entidad_res), Freq = n())
tempInt <- subset(tempInt, tempInt$diabetes == "positivo" & tempInt$intubado == "positivo")

# Extracción de columnas
df7 <- tempDif[,c(2:4)]
colnames(df7)[names(df7) == "Freq"] <- "muertes_diabetes"

# Cálculo del porcentaje
tempDif$Freq <- ((tempDif$Freq*100)/temptotal$Freq)
tempInt$Freq <- ((tempInt$Freq*100)/temptotal$Freq)

# Extracción de columnas
df7 <- cbind(df7, porc_muertes_diabetes = tempDif$Freq)
df7 <- cbind(df7, porc_muertes_diabetes_intubado = tempInt$Freq)

df7 <- mex_map_es %>% left_join(df7, by = c("CODE" = "entidad_res"))
df7$geometry <- NULL
df7 <- cbind(fecha = consulta_semanal$fecha_inicial[[fila]], df7)
names(df7)[names(df7) == "NAME"] <- "entidad"

nombre_tabla <- "df7"

carga_df(esquema, nombre_tabla, df7)

# -----------------------------------------------------------------------------------------------------------

# Extracción y agrupación de los datos deseados
positivoCovid <- summarise(group_by(df8, sexo, entidad_res, clasificacion_final), Freq = n())


positivoCovid$clasificacion_final <- "COVID-19" # Asignación de valor
colnames(positivoCovid)[3] <- "ENFERMEDAD" # Cambio de nombre a columna

positivoDia <- summarise(group_by(df8, sexo, entidad_res, diabetes), Freq = n())
positivoDia <- subset(positivoDia, positivoDia$diabetes == 'positivo') # Extracción de los datos
positivoDia$diabetes <- "DIABETES" # Asignación de valor
colnames(positivoDia)[3] <- "ENFERMEDAD" # Cambio de nombre a columna

positivoEp <- summarise(group_by(df8, sexo, entidad_res, epoc), Freq = n())
positivoEp <- subset(positivoEp, positivoEp$epoc == 'positivo') # Extracción de los datos
positivoEp$epoc <- "EPOC" # Asignación de valor
colnames(positivoEp)[3] <- "ENFERMEDAD" # Cambio de nombre a columna

positivoAsm <- summarise(group_by(df8, sexo, entidad_res, asma), Freq = n())
positivoAsm <- subset(positivoAsm, positivoAsm$asma == 'positivo') # Extracción de los datos
positivoAsm$asma <- "ASMA" # Asignación de valor
colnames(positivoAsm)[3] <- "ENFERMEDAD" # Cambio de nombre a columna

positivoHip <- summarise(group_by(df8, sexo, entidad_res, hipertension), Freq = n())
positivoHip <- subset(positivoHip, positivoHip$hipertension == 'positivo') # Extracción de los datos
positivoHip$hipertension <- "HIPERTENSION" # Asignación de valor
colnames(positivoHip)[3] <- "ENFERMEDAD" # Cambio de nombre a columna

positivoOb <- summarise(group_by(df8, sexo, entidad_res, obesidad), Freq = n())
positivoOb <- subset(positivoOb, positivoOb$obesidad == 'positivo') # Extracción de los datos
positivoOb$obesidad <- "OBESIDAD" # Asignación de valor
colnames(positivoOb)[3] <- "ENFERMEDAD" # Cambio de nombre a columna

positivoIn <- summarise(group_by(df8, sexo, entidad_res, inmusupr), Freq = n())
positivoIn <- subset(positivoIn, positivoIn$inmusupr == 'positivo') # Extracción de los datos
positivoIn$inmusupr <- "INMUSUPR" # Asignación de valor
colnames(positivoIn)[3] <- "ENFERMEDAD" # Cambio de nombre a columna

positivoRen <- summarise(group_by(df8, sexo, entidad_res, renal_cronica), Freq = n())
positivoRen <- subset(positivoRen, positivoRen$renal_cronica == 'positivo') # Extracción de los datos
positivoRen$renal_cronica <- "RENAL_CRONICA" # Asignación de valor
colnames(positivoRen)[3] <- "ENFERMEDAD" # Cambio de nombre a columna

positivoTab <- summarise(group_by(df8, sexo, entidad_res, tabaquismo), Freq = n())
positivoTab <- subset(positivoTab, positivoTab$tabaquismo == 'positivo') # Extracción de los datos
positivoTab$tabaquismo <- "TABAQUISMO" # Asignación de valor
colnames(positivoTab)[3] <- "ENFERMEDAD" # Cambio de nombre a columna

# Combinación de los datos deseados
df8 <- do.call("rbind", list(positivoCovid, positivoDia, positivoEp, positivoAsm, 
                             positivoHip, positivoOb, positivoIn, positivoRen, positivoTab))

df8 <- mex_map_es %>% left_join(df8, by = c("CODE" = "entidad_res"))
df8$geometry <- NULL

df8 <- cbind(fecha = consulta_semanal$fecha_inicial[[fila]], df8)
names(df8)[names(df8) == "NAME"] <- "entidad"
names(df8)[names(df8) == "Freq"] <- "cantidad"

nombre_tabla <- "df8"

carga_df(esquema, nombre_tabla, df8)

# ------------------------------------------------------------------------------------------------------

# Asignación de formato a fecha
df9$ing <- as.Date(as.character(df9$fecha_ingreso), format="%Y-%m-%d")-as.Date(as.character(df9$fecha_sintomas), format="%Y-%m-%d")

# Asignación de formato a entero
df9$ing <- as.integer(df9$ing)

# Extracción y agrupación de datos
temptotal <- summarise(group_by(df9, sexo), Freq = n())
ingrMa2 <- subset(df9, df9$ing > 2)
ingrMa2 <- summarise(group_by(ingrMa2, sexo), Freq = n())
ingrMa2$Dia <- "Mayor a 2 días"
ingrMe2 <- subset(df9, df9$ing <= 2)
ingrMe2 <- summarise(group_by(ingrMe2, sexo), Freq = n())
ingrMe2$Dia <- "Menor a 2 días"
df9 <- do.call("rbind", list(ingrMa2,ingrMe2))

# Cálculo del porcentaje
df9 <- cbind(df9, porcentaje = ((df9$Freq*100)/temptotal$Freq))

df9 <- cbind(fecha = consulta_semanal$fecha_inicial[[fila]], df9)
names(df9)[names(df9) == "Freq"] <- "cantidad"

nombre_tabla <- "df9"

carga_df(esquema, nombre_tabla, df9)

# ----------------------------------------------------------------------------------------------------

# Extracción y agrupación de datos
intubados <- subset(df10, df10$intubado == 'positivo')
temptotal <- summarise(group_by(intubados, sexo), Freq = n())
difuntos <- subset(intubados, intubados$fecha_def != "9999-99-99")
difuntos <- summarise(group_by(difuntos, sexo), Freq = n())
difuntos$Estado <- "MUERTO"
vivos <- subset(intubados, intubados$fecha_def == "9999-99-99")
vivos <- summarise(group_by(vivos, sexo), Freq = n())
vivos$Estado <- "VIVO"

# Agrupación de los datos deseados
df10 <- do.call("rbind", list(difuntos,vivos))

# Cálculo del porcentaje
df10 <- cbind(df10, porcentaje = ((df10$Freq*100)/temptotal$Freq))

df10 <- cbind(fecha = consulta_semanal$fecha_inicial[[fila]], df10)
names(df10)[names(df10) == "Freq"] <- "cantidad"

nombre_tabla <- "df10"

carga_df(esquema, nombre_tabla, df10)

# --------------------------------------------------------------------------------------------------

df11$clasificacion_final <- "COVID-19" # Cambio de los valores
df11 <- summarise(group_by(df11, cardiovascular, clasificacion_final), Freq = n()) # Agrupación de los datos deseados

df11 <- cbind(fecha = consulta_semanal$fecha_inicial[[fila]], df11)
names(df11)[names(df11) == "Freq"] <- "cantidad"

nombre_tabla <- "df11"

carga_df(esquema, nombre_tabla, df11)

rm(positivoAsm, positivoCovid, positivoDia, positivoEp, positivoHip, positivoIn,
   positivoOb, positivoRen, positivoTab, tempDif, tempInt, temptotal, req, difuntos,
   ingrMa2, ingrMe2, intubados, vivos)