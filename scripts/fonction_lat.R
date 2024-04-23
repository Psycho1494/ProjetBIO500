# Date: 11 mars 2024
# Jeux de donnees: acoustique_oiseaux
# Equipe: Emy Chevrette
#         Angelique Cornellier
#         Coralie Mimeault
#         Stephanie Morin-Beaumier


# 1-Fonction qui permet de verifier que les donnees de latitude se retrouvent
#   bien au Quebec, soit entre les valeurs 45 et 63.

verifier_limites_latitude <- function(df, colonne_latitude) {
  latitudes <- df[[colonne_latitude]]
  limites <- all(latitudes >= 45 & latitudes <= 63)
  return(limites)
}


