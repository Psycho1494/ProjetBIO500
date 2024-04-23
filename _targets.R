# Date: 11 mars 2024
# Jeux de donnees: acoustique_oiseaux
# Equipe: Emy Chevrette
#         Angelique Cornellier
#         Coralie Mimeault
#         Stephanie Morin-Beaumier

# 1-Libraries et sources des targets.

library(targets)
library(lubridate)
library(dplyr)
library(RSQLite)
library(rmarkdown)
library(tarchetypes)
library(rticles)
library(bib2df)
source("fonction_combiner.r")
source("fonction_date.r")
source("fonction_na.r")
source("fonction_lat.r")
source("fonction_req_om.r")
source("graph_obs_mois_annee.r")
source("fonction_req_fm.R")
source("graph_famille.r")
source("fonction_obs_lat.r")
source("graph_obs_lat.r")

# 2-Creation de la liste des targets (pipeline).

list(
   
  tar_target(
     donnee_oiseau ,
     Lecture_donnees()
  ),
  tar_target(
    donnee_oiseau_n,
    remplacer_NULL_par_NA(donnee_oiseau)
  ),
  tar_target(
    donnee_oiseau_date,
    convertir_date(donnee_oiseau_n, "date_obs")
  ),
  tar_target(
    donnee_oiseau_lat,
    verifier_limites_latitude(donnee_oiseau_date, "lat")
  ),
  tar_target(
    observation_mois_annee,
    obs_mois_annee(donnee_oiseau_date)
  ),
  tar_target(
    graph_mois_annee,
    graph_obs_mois_annee(observation_mois_annee)
  ),
  tar_target(
    observation_mois_famille,
    obs_mois_famille(donnee_oiseau_date),
  ),
  tar_target(
    graph_famille,
    graph_obs_mois_famille(observation_mois_famille)
  ),
  tar_target(
    observation_lat,
    obs_lat(donnee_oiseau_lat),
  ),
  tar_target(
    graph_lat,
    graph_obs_lat(observation_lat)
  ),
  tar_render(
    rapport,
    path="rapport.Rmd",
    output_file = "rapport.pdf"
  )
)

