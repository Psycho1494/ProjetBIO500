####requete obervation en fonction de la latitude
obs_lat<-function(l) {
  connexion <- dbConnect(SQLite(), dbname="OISEAU")
  on.exit(dbDisconnect(connexion))
sql_requete_lat <- "
SELECT count(id_site) AS nb_obs, lat 
  FROM site
  
  GROUP BY lat;
"
obs_lat <- dbGetQuery(connexion, sql_requete_lat)

return(obs_lat)
}