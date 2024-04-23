# Date: 11 mars 2024
# Jeux de donnees: acoustique_oiseaux
# Equipe: Emy Chevrette
#         Angelique Cornellier
#         Coralie Mimeault
#         Stephanie Morin-Beaumier

# 1-Setter le work directory vers les donnees "acoustique_oiseaux".
library(dplyr)
library(RSQLite)
library(DBI)
library(lubridate)
library(rmarkdown)
library(rticles)
library(bib2df)

# 2-Combiner les fichiers csv et extraire les donnees.

source("fonction_combiner.r")
donnee_oiseau <- Lectures_donnees_m()

# 3-Nettoyage des donnees.

#   Remplacer les termes "NULL" par "NA".

source("fonction_na.r")
donnee_oiseau <- remplacer_NULL_par_NA(donnee_oiseau)

#   Uniformiser le format des dates.

source("fonction_date.r")
library(lubridate)
donnee_oiseau <- convertir_date(donnee_oiseau, "date_obs")

#   Verifier que les donnees de latitude se retrouvent bien au Quebec, 
#   soit entre les valeurs 45 et 63.

source("fonction_lat.r")
resultat_verification <- verifier_limites_latitude(donnee_oiseau, "lat")

# 4-Requete sql pour obtenir les observations par mois et par annee. 

source("fonction_req_om.r")
observation_mois_annee<- obs_mois_annee()

# 5-Creation du graphique des obervations d'oiseaux en fonction du mois et des annees.

source("graph_obs_mois_annee.r")
graph_obs_mois_annee(observation_mois_annee)

# 6-Requete sql pour obtenir les mois, les annees et les familles.

source("fonction_req_fm.R")
observation_mois_famille<-obs_mois_famille()

# 7-Creation du graphique du nombre de famille par mois et par annee.

source("graph_famille.r")
graph_obs_mois_famille(observation_mois_famille)

# 8-Requete sql pour obtenir les observations d'oiseaux en fonction de la latitude.

source("fonction_obs_lat.r")
observation_lat<-obs_lat()

# 9-Creation du graphique des observation d'oiseaux en fonction de la latitude.

source("graph_obs_lat.r")
graph_obs_lat(observation_lat)



