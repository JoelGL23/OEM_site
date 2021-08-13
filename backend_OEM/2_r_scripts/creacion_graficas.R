library(tidyverse)
library(sf)
library(ggplot2)
library(treemapify)
library(viridis)
library(scales)

df1$cantidad <- as.integer(df1$cantidad)

# Creación del mapa
df1_plot <- df1 %>%
  ggplot(aes(fill = cantidad)) +
  xlab("Longitud") +
  ylab("Latitud") +
  geom_sf(colour = "grey", size = 1) +
  geom_sf_label(aes(label = CODE), size = 1.5) +
  scale_fill_distiller(palette = "Reds", direction = 1, name = "Totales")

df1_plot

# ----------------------------------------------------------------------------------------------

df2$cantidad <- as.integer(df2$cantidad)

# Creación de grafica
df2_plot <- ggplot(df2, aes(x=pais_origen, y= round(cantidad, digits = 0), fill = pais_origen)) +
  geom_bar(stat="identity") +
  theme_bw() +
  guides(color = FALSE, size = FALSE) +
  labs(x ="PAÍSES", y = "CANTIDADES") +
  theme(panel.grid.major = element_blank()) + 
  theme(axis.text.x=element_text(angle=90,hjust=1,vjust=0.5), legend.position="bottom", legend.text = element_text(size = 7))

# Imprimir grafica
df2_plot + theme(legend.position = "none")

# ----------------------------------------------------------------------------------------------

df3$cantidad <- as.integer(df3$cantidad)

# Creación de la grafica
df3_plot <- ggplot(df3,aes(fill=sexo,x=rango,y=cantidad)) +
  geom_bar(position="dodge", stat="identity") +
  ylab("CANTIDADES") +
  xlab("EDADES") +
  theme(legend.position="bottom", legend.text = element_text(size = 7))

# Imprimir la grafica
df3_plot

# ----------------------------------------------------------------------------------------------

df4$cantidad <- as.integer(df4$cantidad)

# Creación de la grafica
df4_plot <- ggplot(df4, aes(area = cantidad, fill = clasificacion_final,label = CODE)) +
  geom_treemap() +
  geom_treemap_text(fontface = "italic", colour = "white", place = "centre")

# Imprimir la grafica
df4_plot

# ----------------------------------------------------------------------------------------------

df5$cantidad_enfermos <- as.integer(df5$cantidad_enfermos)

# Creación de la grafica
df5_plot <- ggplot(df5, aes(fill=enfermedad, y=entidad, x=cantidad_enfermos)) + 
  geom_bar(position="stack", stat="identity") +
  scale_fill_viridis(discrete = T) +
  theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank()) +
  ylab("")

# Imprimir la grafica
df5_plot

# ----------------------------------------------------------------------------------------------

df6$cantidad_casos <- as.integer(df6$cantidad_casos)
# Combinación de columnas
df6 <-unite(df6, variables,c(3:4),  sep = " / ", remove = T)

# Creación de la grafica
df6_plot <- ggplot(df6,aes(fill=variables,x=rango_edad,y=cantidad_casos)) +
  geom_bar(position="dodge", stat="identity") +
  ylab("TOTALES") +
  xlab("") +
  labs(fill="") +
  theme(legend.position="bottom", legend.text = element_text(size = 7))

# Imprimir la grafica
df6_plot

# ----------------------------------------------------------------------------------------------

df7$muertes_diabetes <- as.integer(df7$muertes_diabetes)

# Creación de la grafica
df7_plot_a <- ggplot(df7,aes(fill=sexo,x=entidad,y=muertes_diabetes))+
  geom_bar(position="dodge", stat="identity") +
  labs(y="TOTALES",x="ESTADOS") +
  theme(axis.text.x=element_text(angle=90,hjust=1,vjust=0.5), legend.position="bottom", legend.text = element_text(size = 7))

# Imprimir la grafica
df7_plot_a

# Creación de la grafica
df7_plot_b <- ggplot(df7,aes(fill=sexo,x=entidad,y=porc_muertes_diabetes))+
  geom_bar(position="dodge", stat="identity") +
  labs(y="PORCENTAJE",x="ESTADOS") +
  theme(axis.text.x=element_text(angle=90,hjust=1,vjust=0.5), legend.position="bottom", legend.text = element_text(size = 7))

# Imprimir la grafica
df7_plot_b


# Creación de las graficas
df7_plot_c <- ggplot(df7,aes(fill=sexo,x=entidad,y=porc_muertes_diabetes_intubado))+
  geom_bar(position="dodge", stat="identity")  +
  labs(y="TOTALES",x="ESTADOS") +
  theme(axis.text.x=element_text(angle=90,hjust=1,vjust=0.5), legend.position="bottom", legend.text = element_text(size = 7))

# Imprimir la grafica
df7_plot_c

names(df7)[names(df7) == "porc_muertes_diabetes"] <- "PMD"
names(df7)[names(df7) == "porc_muertes_diabetes_intubado"] <- "PMDI"

# ----------------------------------------------------------------------------------------------

# Creación de las graficas
df8_plot_a <- ggplot(df8,aes(x=entidad, y=cantidad, group=ENFERMEDAD, color= ENFERMEDAD))+
  geom_line()+
  geom_point() +
  labs(y="TOTALES",x="ESTADOS") +
  theme(axis.text.x=element_text(angle=90,hjust=1,vjust=0.5), legend.position="bottom", legend.text = element_text(size = 7))

# Imprimir la grafica
df8_plot_a

# Creación de las graficas
df8_plot_b <- ggplot(df8,aes(fill=sexo,x=ENFERMEDAD,y=cantidad))+
  geom_bar(position="dodge", stat="identity") +
  labs(y="TOTALES") +
  theme(axis.text.x=element_text(angle=90,hjust=1,vjust=0.5), legend.position="bottom", legend.text = element_text(size = 7))

# Imprimir la grafica
df8_plot_b

# ------------------------------------------------------------------------------------------------

# Creación de la grafica
df9_plot_a <- ggplot(df9,aes(fill=sexo, x=Dia,y=cantidad))+
  geom_bar(position="dodge", stat="identity")  +
  labs(y="TOTALES",x="DÍAS")

# Imprimir la grafica
df9_plot_a

# Creación de la grafica
df9_plot_b <- ggplot(df9,aes(fill=sexo, x=Dia,y=porcentaje))+
  geom_bar(position="dodge", stat="identity")  +
  labs(y="PORCENTAJES",x="DÍAS")

# Imprimir la grafica
df9_plot_b

# ------------------------------------------------------------------------------------------------

# Creación de la grafica
df10_plot_a <- ggplot(df10,aes(fill=sexo, x=Estado,y=cantidad))+
  geom_bar(position="dodge", stat="identity")  +
  labs(y="TOTALES",x="ESTADO")

# Imprimir la grafica
df10_plot_a

# Creación de la grafica
df10_plot_b <- ggplot(df10,aes(fill=sexo, x=Estado,y=porcentaje))+
  geom_bar(position="dodge", stat="identity")  +
  labs(y="PORCENTAJES",x="ESTADO")

# Imprimir la grafica
df10_plot_b

# ------------------------------------------------------------------------------------------------

# Creación de grafica
df11_plot <- ggplot(df11, aes(x="", y=cantidad, fill=cardiovascular)) +
  geom_bar(stat="identity", width=1, color="white") +
  coord_polar("y", start=0) +
  labs(fill='') +
  theme_void()

# Imprimir grafica
df11_plot

# ------------------------------------------------------------------------------------------------

df12_plot <- subset(df12, df12$clasificacion_final == "caso de covid-19 confirmado por asociación clínica epidemiológica" |
                      df12$clasificacion_final == "caso de covid-19 confirmado por comité de  dictaminación")
df12_plot$clasificacion_final <- "Confirmados Covid-19"

df12_plot <- aggregate(df12_plot$resultado_covid, by=list(fecha=df12_plot$fecha,
                                                          clasificacion_final=df12_plot$clasificacion_final), FUN=sum)

names(df12_plot)[names(df12_plot) == "x"] <- "cantidad"
df12_plot$fecha <- as.character(df12_plot$fecha)

temp <- as.data.frame(diff(df12_plot$cantidad))
temp <- rbind(0,temp)
names(temp)[names(temp) == "x"] <- "diferencia"
df12_plot <- cbind(df12_plot,temp)
df12_plot$diferencia <- as.integer(df12_plot$diferencia)

# Creación de grafica
df12_plot <- ggplot(df12_plot, aes(x=fecha, y=diferencia)) +
  geom_bar(position="dodge", stat="identity") +
  theme(axis.text.x=element_text(angle=90,hjust=1,vjust=0.5), legend.position="bottom", legend.text = element_text(size = 7))

# Imprimir grafica
df12_plot

# ------------------------------------------------------------------------------------------------

df13_plot <- df13
df13_plot$clasificacion_final <- "Confirmados Covid-19"

df13_plot <- aggregate(df13_plot$resultado_covid, by=list(fecha=df13_plot$fecha,
                                                          clasificacion_final=df13_plot$clasificacion_final), FUN=sum)

names(df13_plot)[names(df13_plot) == "x"] <- "cantidad"
df13_plot$fecha <- as.character(df13_plot$fecha)

temp <- as.data.frame(diff(df13_plot$cantidad))
temp <- rbind(0,temp)
names(temp)[names(temp) == "x"] <- "diferencia"
df13_plot <- cbind(df13_plot,temp)
df13_plot$diferencia <- as.integer(df13_plot$diferencia)

# Creación de grafica
df13_plot <- ggplot(df13_plot, aes(x=fecha, y=diferencia)) +
  geom_bar(position="dodge", stat="identity") +
  theme(axis.text.x=element_text(angle=90,hjust=1,vjust=0.5), legend.position="bottom", legend.text = element_text(size = 7))

# Imprimir grafica
df13_plot