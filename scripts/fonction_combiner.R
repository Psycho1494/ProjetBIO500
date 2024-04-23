# Date: 11 mars 2024
# Jeux de donnees: acoustique_oiseaux
# Equipe: Emy Chevrette
#         Angelique Cornellier
#         Coralie Mimeault
#         Stephanie Morin-Beaumier


# 1-Fonction qui cree le dataframe avec tous les fichiers de donnees csv.

Lectures_donnees_m=function(){
  files = list.files( pattern = ".csv", full.names = TRUE)
  combined_data = data.frame()
  for (file in files) {
    data <- read.csv(file, header = TRUE, sep=",")
    combined_data <- bind_rows(combined_data, data)  
  }
  return(combined_data)
}


