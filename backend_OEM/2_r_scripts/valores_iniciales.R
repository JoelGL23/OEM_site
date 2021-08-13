library(lubridate)

id_semanal <- "CAS01"
fecha_inicial <- ymd("2021-01-01")
descarga_semanal <- 2
descripcion_archivo_semanal <- "pendiente"

valores_fecha <- obtener_valores_fecha(fecha_inicial)

nombre_tabla_semanal <- paste("covid19mexico",valores_fecha$anio_ab, valores_fecha$mes, valores_fecha$dia, sep = "")

archivos_semanales <- data.frame(id_semanal,
                                 fecha_inicial,
                                 valores_fecha[,],
                                 descarga_semanal,
                                 descripcion_archivo_semanal,
                                 nombre_tabla_semanal)

id_mensual <- "CAM1"
primer_dia <- format(as.Date(archivos_semanales$fecha_inicial[[1]],"%Y-%m-%d"),'%d')
anio_mes <- as.Date(archivos_semanales$fecha_inicial[[1]],"%Y-%m-%d")
anio_mes <- substring(anio_mes,1,8)
primer_dia_fecha <- as.Date(paste(anio_mes,primer_dia,sep = ""))
dia_intermerdio <- as.integer(days_in_month(archivos_semanales$fecha_inicial[[1]])/2)
dia_intermerdio <- as.character(dia_intermerdio)
dia_intermerdio_fecha <- as.Date(paste(anio_mes,dia_intermerdio,sep = ""))
ultimo_dia <- as.character(days_in_month(archivos_semanales$fecha_inicial[[1]]))
ultimo_dia_fecha  <- as.Date(paste(anio_mes,ultimo_dia,sep = ""))

archivos_mensuales <- data.frame(id_mensual,
                                 primer_dia,
                                 primer_dia_fecha,
                                 dia_intermerdio,
                                 dia_intermerdio_fecha,
                                 ultimo_dia,
                                 ultimo_dia_fecha)