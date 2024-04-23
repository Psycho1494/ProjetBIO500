# Date: 11 mars 2024
# Jeux de donnees: acoustique_oiseaux
# Equipe: Emy Chevrette
#         Angelique Cornellier
#         Coralie Mimeault
#         Stephanie Morin-Beaumier

# 1-Creation du graphique des obervations d'oiseaux en fonction du mois et des annees.

graph_obs_mois_annee <-function(datecombine) {
  pdf(file="figures/observation_mois_annee.pdf")
  par(mar=c(5,5,5,5))
plot(datecombine$mois,datecombine$obs_2016, type = "l", col = "blue",ylim=c(0,6000),lwd = 2, xlab="Mois",ylab="Nombre d'observations")
lines(datecombine$mois,datecombine$obs_2017,col="red",lwd = 2.5)
lines(datecombine$mois,datecombine$obs_2018,col="green",lwd = 2)
lines(datecombine$mois,datecombine$obs_2019,col="purple",lwd = 2)
lines(datecombine$mois,datecombine$obs_2020,col="orange",lwd = 2)

#   Creation de la legende.

legend(x = 8 , y = 5000, legend = c("2016", "2017","2018","2019","2020"), 
       col = c("blue", "red","green","purple","orange"), lwd = 2.1, 
       cex = 0.8, box.lwd = 2, box.col = "white")
dev.off()

}