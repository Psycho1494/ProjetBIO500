# Date: 11 mars 2024
# Jeux de donnees: acoustique_oiseaux
# Equipe: Emy Chevrette
#         Angelique Cornellier
#         Coralie Mimeault
#         Stephanie Morin-Beaumier


# 1-Fonction qui permet d'uniformiser le format des dates.

convertir_date <- function(df, colonne_date) {
  
  
  df[[colonne_date]] <- parse_date_time(df[[colonne_date]],orders =  c("%d/%m/%y", "%y-%m-%d"))
  df[[colonne_date]] <- as.character(df[[colonne_date]])
  
  
  return(df)
}

