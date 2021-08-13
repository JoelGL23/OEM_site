library(dplyr)
library(sf)

consulta <- paste("SELECT *
                     FROM ", esquema,"df1",
                  " WHERE fecha = ", fecha, sep = "")
# Querys
req <- dbSendQuery(con, consulta)
df1 <- dbFetch(req) # Obtener los nelementos (filas) del conjunto de resultados
dbClearResult(req) # Limpiar los resultados obtenidos de una consulta

df1 <- mex_map_es %>% left_join(df1, by = c("CODE" = "entidad_res"))

# --------------------------------------------------------------------------------------------

consulta <- paste("SELECT *
                     FROM ", esquema,"df2",
                  " WHERE fecha = ", fecha, sep = "")
# Querys
req <- dbSendQuery(con, consulta)
df2 <- dbFetch(req) # Obtener los nelementos (filas) del conjunto de resultados
dbClearResult(req) # Limpiar los resultados obtenidos de una consulta

# Creación de data frame
df2 <- as.data.frame(df2)

# -------------------------------------------------------------------------------------------

consulta <- paste("SELECT *
                     FROM ", esquema,"df3",
                  " WHERE fecha = ", fecha, sep = "")
# Querys
req <- dbSendQuery(con, consulta)
df3 <- dbFetch(req) # Obtener los nelementos (filas) del conjunto de resultados
dbClearResult(req) # Limpiar los resultados obtenidos de una consulta

# Creación de data frame
df3 <- as.data.frame(df3)

# -------------------------------------------------------------------------------------------

consulta <- paste("SELECT *
                     FROM ", esquema,"df4",
                  " WHERE fecha = ", fecha, sep = "")
# Querys
req <- dbSendQuery(con, consulta)
df4 <- dbFetch(req) # Obtener los nelementos (filas) del conjunto de resultados
dbClearResult(req) # Limpiar los resultados obtenidos de una consulta

# Creación de data frame
df4 <- as.data.frame(df4)

# -------------------------------------------------------------------------------------------

consulta <- paste("SELECT *
                     FROM ", esquema,"df5",
                  " WHERE fecha = ", fecha, sep = "")
# Querys
req <- dbSendQuery(con, consulta)
df5 <- dbFetch(req) # Obtener los nelementos (filas) del conjunto de resultados
dbClearResult(req) # Limpiar los resultados obtenidos de una consulta

# Creación de data frame
df5 <- as.data.frame(df5)

# -------------------------------------------------------------------------------------------

consulta <- paste("SELECT *
                     FROM ", esquema,"df6",
                  " WHERE fecha = ", fecha, sep = "")
# Querys
req <- dbSendQuery(con, consulta)
df6 <- dbFetch(req) # Obtener los nelementos (filas) del conjunto de resultados
dbClearResult(req) # Limpiar los resultados obtenidos de una consulta

# Creación de data frame
df6 <- as.data.frame(df6)

# -------------------------------------------------------------------------------------------

consulta <- paste("SELECT *
                     FROM ", esquema,"df7",
                  " WHERE fecha = ", fecha, sep = "")
# Querys
req <- dbSendQuery(con, consulta)
df7 <- dbFetch(req) # Obtener los nelementos (filas) del conjunto de resultados
dbClearResult(req) # Limpiar los resultados obtenidos de una consulta

# Creación de data frame
df7 <- as.data.frame(df7)

# -------------------------------------------------------------------------------------------

consulta <- paste("SELECT *
                     FROM ", esquema,"df8",
                  " WHERE fecha = ", fecha, sep = "")
# Querys
req <- dbSendQuery(con, consulta)
df8 <- dbFetch(req) # Obtener los nelementos (filas) del conjunto de resultados
dbClearResult(req) # Limpiar los resultados obtenidos de una consulta

# Creación de data frame
df8 <- as.data.frame(df8)

# -------------------------------------------------------------------------------------------

consulta <- paste("SELECT *
                     FROM ", esquema,"df9",
                  " WHERE fecha = ", fecha, sep = "")
# Querys
req <- dbSendQuery(con, consulta)
df9 <- dbFetch(req) # Obtener los nelementos (filas) del conjunto de resultados
dbClearResult(req) # Limpiar los resultados obtenidos de una consulta

# Creación de data frame
df9 <- as.data.frame(df9)

# -------------------------------------------------------------------------------------------

consulta <- paste("SELECT *
                     FROM ", esquema,"df10",
                  " WHERE fecha = ", fecha, sep = "")
# Querys
req <- dbSendQuery(con, consulta)
df10 <- dbFetch(req) # Obtener los nelementos (filas) del conjunto de resultados
dbClearResult(req) # Limpiar los resultados obtenidos de una consulta

# Creación de data frame
df10 <- as.data.frame(df10)

# -------------------------------------------------------------------------------------------

consulta <- paste("SELECT *
                     FROM ", esquema,"df11",
                  " WHERE fecha = ", fecha, sep = "")
# Querys
req <- dbSendQuery(con, consulta)
df11 <- dbFetch(req) # Obtener los nelementos (filas) del conjunto de resultados
dbClearResult(req) # Limpiar los resultados obtenidos de una consulta

# Creación de data frame
df11 <- as.data.frame(df11)

# -------------------------------------------------------------------------------------------

consulta <- paste("SELECT *
                     FROM ", esquema,"df12", sep = "")
# Querys
req <- dbSendQuery(con, consulta)
df12 <- dbFetch(req) # Obtener los nelementos (filas) del conjunto de resultados
dbClearResult(req) # Limpiar los resultados obtenidos de una consulta

# Creación de data frame
df12 <- as.data.frame(df12)

# -------------------------------------------------------------------------------------------

consulta <- paste("SELECT *
                     FROM ", esquema,"df13", sep = "")
# Querys
req <- dbSendQuery(con, consulta)
df13 <- dbFetch(req) # Obtener los nelementos (filas) del conjunto de resultados
dbClearResult(req) # Limpiar los resultados obtenidos de una consulta

# Creación de data frame
df13 <- as.data.frame(df13)