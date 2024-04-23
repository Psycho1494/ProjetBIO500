# Date: 11 mars 2024
# Jeux de donnees: acoustique_oiseaux
# Equipe: Emy Chevrette
#         Angelique Cornellier
#         Coralie Mimeault
#         Stephanie Morin-Beaumier


# 1-Fonction qui permet de remplacer les termes "NULL" par "NA".

remplacer_NULL_par_NA <- function(df) {
  df[df == "NULL"] <- NA
  return(df)
}


