library(sf)

archivo_es <- "1_datos/mapa_mexico_estados/Mexico_States.shp"

if (file.exists(archivo_es)){
  
  # Carga el archivo shapefile a R
  mex_map_es <- st_read("1_datos/mapa_mexico_estados/Mexico_States.shp")
  
}else{
  
  # Descarga el archivo zip de github
  download.file(url = "https://github.com/JoelGL23/archivos_generales/raw/main/mapa_mexico_estados.zip",
                destfile = "1_datos/mapa_mexico_estados.zip")
  
  unzip("1_datos/mapa_mexico_estados.zip", exdir = "1_datos/")
  
  source("2_r_scripts/carga_mapa.R")
  
}

mex_map_es$CODE <- gsub("MX","",mex_map_es$CODE)