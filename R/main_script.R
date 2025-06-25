# main_script.R

# Cargar librerías
if (!requireNamespace("data.table", quietly = TRUE)) install.packages("data.table")
if (!requireNamespace("purrr", quietly = TRUE)) install.packages("purrr")
if (!requireNamespace("furrr", quietly = TRUE)) install.packages("furrr")
if (!requireNamespace("sf", quietly = TRUE)) install.packages("sf")
if (!requireNamespace("parallel", quietly = TRUE)) install.packages("parallel")
if (!requireNamespace("arrow", quietly = TRUE)) install.packages("arrow")
if (!requireNamespace("mapSpain", quietly = TRUE)) install.packages("mapSpain")

library(data.table)
library(purrr)
library(furrr)
library(sf)
library(parallel)
library(arrow)
library(mapSpain)

# Obtener el polígono de la provincia de Zaragoza
zaragoza <- esp_get_prov(prov = "Zaragoza")

# Mostrar el polígono
print(zaragoza)

library(sf)
library(purrr)
library(furrr)
library(dplyr)  # Para manipulación de datos

procesar_archivo <- function(archivo, poligono) {
  # Leer solo datos dentro del polígono usando wkt_filter
  wkt <- st_as_text(st_geometry(poligono))
  
  datos <- sf::read_sf(archivo, query = NULL, wkt_filter = wkt)
  
  # Calcular medias de las variables
  medias <- datos %>%
    summarise(
      MeanTemperature = mean(MeanTemperature, na.rm = TRUE),
      Precipitation = mean(Precipitation, na.rm = TRUE),
      RelativeHumidity = mean(RelativeHumidity, na.rm = TRUE)
    )
  
  return(medias)
}
plan(multisession, workers = 2)  

archivos <- list.files(path = "raw_data", pattern = "\\.gpkg$", full.names = TRUE)
resultados <- future_map_dfr(archivos, ~ procesar_archivo(.x, zaragoza))
print(resultados)


