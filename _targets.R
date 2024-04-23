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
source("scripts/fonction_combiner.r")
source("scripts/fonction_date.r")
source("scripts/fonction_na.r")
source("scripts/fonction_lat.r")
source("scripts/tableSQL.r")
source("scripts/fonction_req_om.r")
source("scripts/graph_obs_mois_annee.r")
source("scripts/fonction_req_fm.R")
source("scripts/graph_famille.r")
source("scripts/fonction_obs_lat.r")
source("scripts/graph_obs_lat.r")


# 2-Creation de la liste des targets (pipeline).

list(
   
  tar_target(
     donnee_oiseau ,
     lecture_donnees()
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
    creation_table_sql,
    creationsql(donnee_oiseau_date)
  ),
  tar_target(
    observation_mois_annee,
    obs_mois_annee(creation_table_sql)
  ),
  tar_target(
    graph_mois_annee,
    graph_obs_mois_annee(observation_mois_annee)
  ),
  tar_target(
    observation_mois_famille,
    obs_mois_famille(creation_table_sql),
  ),
  tar_target(
    graph_famille,
    graph_obs_mois_famille(observation_mois_famille)
  ),
  tar_target(
    observation_lat,
    obs_lat(creation_table_sql),
  ),
  tar_target(
    graph_lat,
    graph_obs_lat(observation_lat)
  ),
  tar_render(
    rapport,
    path="article/rapport.Rmd",
    output_file = "rapport.pdf"
  )
)
