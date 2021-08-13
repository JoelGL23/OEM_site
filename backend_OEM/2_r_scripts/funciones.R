obtener_valores_fecha <- function(fecha){
  anio <- format(as.Date(fecha,"%Y-%m-%d"),'%Y')
  anio_ab <- substring(anio,3,4)
  mes <- format(as.Date(fecha,"%Y-%m-%d"),'%m')
  dia <- format(as.Date(fecha,"%Y-%m-%d"),'%d')
  dia_semana <- weekdays(fecha)
  
  valores_fecha <- data.frame(anio, anio_ab, mes, dia, dia_semana)
  
  return(valores_fecha)
}

obtener_link <- function(anio, mes, dia){
  
  temp_anio <- as.character(anio)
  temp_anio <- as.integer(temp_anio)
  
  link <- paste("datosabiertos.salud.gob.mx/gobmx/salud/datos_abiertos/historicos/",
                anio,"/",mes,"/datos_abiertos_covid19_",dia,".",mes,".",anio,".zip", sep = "")
  
  return(link)
}

carga_df <- function(esquema, nombre_tabla, df){
  
  esquema <- "resultado_semanal"
  
  table_id <- Id(schema = esquema, table = nombre_tabla)
  
  dbWriteTable(con, name = table_id, value = df, row.names = F, append = T)
  
  esquema <- "resultado_mensual"
  
  table_id <- Id(schema = esquema, table = nombre_tabla)
  
  dbWriteTable(con, name = table_id, value = df, row.names = F, append = T)
}