# Date: 11 mars 2024
# Jeux de donnees: acoustique_oiseaux
# Equipe: Emy Chevrette
#         Angelique Cornellier
#         Coralie Mimeault
#         Stephanie Morin-Beaumier

# 1-Creation du graphique des observation d'oiseaux en fonction de la latitude.

graph_obs_lat <-function(obs_lat) {
  pdf(file="figures/observation_lat.pdf")
  par(mar=c(5,5,5,5))

plot(nb_obs~lat, data=obs_lat,xlab="Latitude",ylab="Nombre d'observations")
modele <- lm(nb_obs ~ lat, data = obs_lat)
abline(modele, col = "red")

#   Obtenir un resume du modele.

resumer_modele <- summary(modele)

#   Extraire la valeur de R-carre.

R_squared <- resumer_modele$adj.r.squared

#   Extraire la valeur de p.

p_value <- resumer_modele$coefficients[2, 4]

#   Ajouter la valeur de p au graphique.

text(x = 58, y = 1150, 
     labels = paste("p =", round(p_value, 4)), 
     pos = 4, col = "blue")

#   Ajouter le coefficient de R-carre au graphique.

text(x = 58, y = 1100, 
     labels = paste("R^2 =", round(R_squared, 4)), 
     pos = 4, col = "blue")

dev.off()
}