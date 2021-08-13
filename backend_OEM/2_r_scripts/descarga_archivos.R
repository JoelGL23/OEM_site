library(sf)
library(RCurl)
library(lubridate)
library(janitor)
library(DBI)
library(RPostgres)
library(DT)

rm(list = ls())
options(timeout=600)

source("2_r_scripts/creacion_estructura.R")

while(as.Date(consulta_semanal$fecha_inicial[[fila]]) <= Sys.Date() | fila <= num_fila_sem){
  if(consulta_semanal$descarga_semanal[[fila]] == 2){
    
    valores_fecha <- obtener_valores_fecha(consulta_semanal$fecha_inicial[[fila]])
    
    url <- obtener_link(valores_fecha$anio, valores_fecha$mes, valores_fecha$dia)
    
    comprobar_link <- url.exists(url)
    
    if(comprobar_link == "TRUE"){
      
      nombre_archivo <- paste(valores_fecha$anio_ab, valores_fecha$mes, valores_fecha$dia,"COVID19MEXICO.csv", sep = "")
      
      temp <- tempfile()
      download.file(url,temp)
      datos <- read.csv(unz(temp, nombre_archivo))
      colnames(datos) <- tolower(colnames(datos))
      
      consulta_semanal$id_semanal[[fila]] <- paste("'",consulta_semanal$id_semanal[[fila]],"'", sep = "")
      
      source("2_r_scripts/carga_archivos_originales.R")
      source("2_r_scripts/carga_requisitos_1_6.R")
      source("2_r_scripts/carga_requisitos_7_11.R")
      source("2_r_scripts/carga_requisito_12_13.R")
      
      auxiliar <- consulta_semanal$dia[[fila]]
      
      dia_reporte <- as.numeric(as.character(consulta_mensual$ultimo_dia))
      dia_actual <- as.numeric(as.character(auxiliar))
      
      nombre_reporte <- paste(month(consulta_semanal$fecha_inicial[[fila]], label = TRUE),
                              consulta_semanal$anio[[fila]],sep = "")
      
      if(consulta_semanal$fecha_inicial[[fila]] == ultima_fila$fecha_inicial){
        
        primera_fecha_titulo <- primera_fila$fecha_inicial
        ultima_fecha_titulo <- ultima_fila$fecha_inicial
        
        nombre_r <- paste("Reporte semanal del ", primera_fecha_titulo, " al ", ultima_fecha_titulo,sep = "")
        
        setwd("~/OpenEyesMex_2_0/OEM_site")
        file.rename("reporte_semanal.Rmd", paste(nombre_r, ".Rmd", sep = ""))
        rmarkdown::render_site()
        unlink("reporte_mensual_files/", recursive = TRUE)
        file.rename(paste(nombre_r, ".Rmd", sep = ""),"reporte_semanal.Rmd")
        setwd("~/OpenEyesMex_2_0/OEM_site/backend_OEM")
        
        break
        
        rm(df1, df2, df3, df4, df5, df6 ,df7 ,df8, df9, df10, df11,
           df1_plot, df2_plot, df3_plot, df4_plot, df5_plot, df6_plot,
           df7_plot_a,df7_plot_b,df7_plot_c,df8_plot_a, df8_plot_b, df9_plot_a, 
           df9_plot_b, df10_plot_a,df10_plot_b , df11_plot, req, df12, df13, df13_plot, df12_plot)
        
        query <- dbSendQuery(con, "DROP SCHEMA IF EXISTS resultado_semanal CASCADE")
        query <- dbSendQuery(con, "CREATE SCHEMA IF NOT EXISTS resultado_semanal")
        
        source("2_r_scripts/nuevo_inicio.R")
        source("2_r_scripts/valores_semanales.R")
        
        aux <- consulta_semanal
        aux <- aux[order(aux$dia),]
        
        primera_fila <- head(aux, 1)
        ultima_fila <- tail(aux, 1)
        
        fila <- 1
        
      }
      
      if(dia_actual == dia_reporte){
        
        primera_fecha_titulo <- consulta_mensual$primer_dia_fecha
        intermedio_fecha_titulo <- consulta_mensual$dia_intermerdio_fecha
        ultima_fecha_titulo <- consulta_mensual$ultimo_dia_fecha
        
        setwd("~/OpenEyesMex_2_0/OEM_site")
        file.rename("reporte_mensual.Rmd", paste(nombre_reporte, ".Rmd", sep = ""))
        rmarkdown::render_site()
        file.rename(paste(nombre_reporte, ".Rmd", sep = ""),"reporte_mensual.Rmd")
        setwd("~/OpenEyesMex_2_0/OEM_site/backend_OEM")
        
        rm(df1, df2, df3, df4, df5, df6 ,df7 ,df8, df9, df10, df11,
           df1_plot, df2_plot, df3_plot, df4_plot, df5_plot, df6_plot,
           df7_plot_a,df7_plot_b,df7_plot_c,df8_plot_a, df8_plot_b, df9_plot_a,
           df9_plot_b, df10_plot_a,df10_plot_b , df11_plot, req, df12, df13, df13_plot, df12_plot)
        
        source("2_r_scripts/valores_mensuales.R")
        
        query <- dbSendQuery(con, "DROP SCHEMA IF EXISTS resultado_mensual CASCADE")
        query <- dbSendQuery(con, "CREATE SCHEMA IF NOT EXISTS resultado_mensual")
        
      }
      
      unlink(temp)
      
    }else{
      
      print("BASE HISTORICA NO ACTUALIZADA")
      break
      
    }
  }else{
    
    fila <- fila + 1
    
    if(fila > num_fila_sem){
      
      print("LOS INDICES SUPERAN LOS LIMITES")
      fila <- fila - 1
      break
      
    }
  }
}