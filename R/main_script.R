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

