##Graphique observation du nombre de famille par mois par année

graph_obs_mois_famille <-function(fammois) {
  pdf(file="observation_mois_famille.pdf")
  par(mar=c(5,5,5,5))
barplot(
  t(as.matrix(fammois[, -1])),  # Transpose la matrice des données sauf la première colonne (mois)
  beside = TRUE,  # Place les barres côte à côte
  col = c("darkblue", "darkred", "darkgreen", "purple", "darkorange"),  # Couleurs des barres
  ylim = c(0, 40),  # Limite de l'axe y
  names.arg = fammois$mois,  # Noms des barres sur l'axe x
  xlab = "Mois",
  ylab = "Nombre de familles"
)

legend(x=30, y = 40, legend = c("2016", "2017","2018","2019","2020"), 
       col = c("darkblue", "darkred","darkgreen","purple","darkorange"), lwd = 4, 
       cex = 0.8, box.lwd = 2, box.col = "white")
dev.off()
}