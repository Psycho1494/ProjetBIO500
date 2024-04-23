##requete SQL
####observation par mois par année ####

obs_mois_annee <-function(x) {
  connexion <- dbConnect(SQLite(), dbname="OISEAU")
  on.exit(dbDisconnect(connexion))
  #2016
  sql_requete <- "
SELECT count(id_obs) AS nb_obs, strftime('%m', date_obs) AS mois 
  FROM dob
  WHERE (date_obs >= '2016-01-01' AND date_obs < '2017-01-01')
  GROUP BY mois;
"
  dategraph <- dbGetQuery(connexion, sql_requete)

  #2017
  
  sql_requete_2017 <- "
SELECT count(id_obs) AS nb_obs, strftime('%m', date_obs) AS mois 
  FROM dob
  WHERE (date_obs >= '2017-01-01' AND date_obs < '2018-01-01')
  GROUP BY mois;
"
  date17 <- dbGetQuery(connexion, sql_requete_2017)

  #2018
  
  sql_requete_2018 <- "
SELECT count(id_obs) AS nb_obs, strftime('%m', date_obs) AS mois 
  FROM dob
  WHERE (date_obs >= '2018-01-01' AND date_obs < '2019-01-01')
  GROUP BY mois;
"
  date18 <- dbGetQuery(connexion, sql_requete_2018)

  #2019
  sql_requete_2019 <- "
SELECT count(id_obs) AS nb_obs, strftime('%m', date_obs) AS mois 
  FROM dob
  WHERE (date_obs >= '2019-01-01' AND date_obs < '2020-01-01')
  GROUP BY mois;
"
  date19 <- dbGetQuery(connexion, sql_requete_2019)

  #2020
  sql_requete_2020<- "
SELECT count(id_obs) AS nb_obs, strftime('%m', date_obs) AS mois 
  FROM dob
  WHERE (date_obs >= '2020-01-01' AND date_obs < '2021-01-01')
  GROUP BY mois;
"
  date20 <- dbGetQuery(connexion, sql_requete_2020)

  datecombine<-merge(dategraph,date17, by= "mois",all=TRUE)
  datecombine<-merge(datecombine,date18, by= "mois",all=TRUE)
  datecombine<-merge(datecombine,date19, by= "mois",all=TRUE)
  datecombine<-merge(datecombine,date20, by= "mois",all=TRUE)
  datecombine[is.na(datecombine)]<-0
  colnames(datecombine)<-c("mois","obs_2016","obs_2017","obs_2018","obs_2019","obs_2020")
  return(datecombine)
}