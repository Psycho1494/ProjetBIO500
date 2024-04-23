###famille par mois
obs_mois_famille <-function(z) {
  connexion <- dbConnect(SQLite(), dbname="OISEAU")
  on.exit(dbDisconnect(connexion))
#2016
sql_requete_fam <- "
SELECT count(DISTINCT family),mois FROM
(SELECT  strftime('%m', date_obs) AS mois,family 
  FROM dob
  JOIN taxo ON taxo.id_taxo=dob.id_obs
  WHERE (date_obs >= '2016-01-01' AND date_obs < '2017-01-01'))
  GROUP BY mois
  
 ;
"
famille_2016 <- dbGetQuery(connexion, sql_requete_fam)

#2017
sql_requete_fam_2017 <- "
SELECT count(DISTINCT family),mois FROM
(SELECT  strftime('%m', date_obs) AS mois,family 
  FROM dob
  JOIN taxo ON taxo.id_taxo=dob.id_obs
  WHERE (date_obs >= '2017-01-01' AND date_obs < '2018-01-01'))
  GROUP BY mois
  
 ;
"
famille_2017 <- dbGetQuery(connexion, sql_requete_fam_2017)

#2018

sql_requete_fam_2018 <- "
SELECT count(DISTINCT family),mois FROM
(SELECT  strftime('%m', date_obs) AS mois,family 
  FROM dob
  JOIN taxo ON taxo.id_taxo=dob.id_obs
  WHERE (date_obs >= '2018-01-01' AND date_obs < '2019-01-01'))
  GROUP BY mois
  
 ;
"
famille_2018 <- dbGetQuery(connexion, sql_requete_fam_2018)

#2019
sql_requete_fam_2019 <- "
SELECT count(DISTINCT family),mois FROM
(SELECT  strftime('%m', date_obs) AS mois,family 
  FROM dob
  JOIN taxo ON taxo.id_taxo=dob.id_obs
  WHERE (date_obs >= '2019-01-01' AND date_obs < '2020-01-01'))
  GROUP BY mois
  
 ;
"
famille_2019 <- dbGetQuery(connexion, sql_requete_fam_2019)

#2020
sql_requete_fam_2020 <- "
SELECT count(DISTINCT family),mois FROM
(SELECT  strftime('%m', date_obs) AS mois,family 
  FROM dob
  JOIN taxo ON taxo.id_taxo=dob.id_obs
  WHERE (date_obs >= '2020-01-01' AND date_obs < '2021-01-01'))
  GROUP BY mois
  
 ;
"
famille_2020 <- dbGetQuery(connexion, sql_requete_fam_2020)

#####combine famile-mois

fammois<-merge(famille_2016,famille_2017, by= "mois",all=TRUE)
fammois<-merge(fammois,famille_2018, by= "mois",all=TRUE)
fammois<-merge(fammois,famille_2019, by= "mois",all=TRUE)
fammois<-merge(fammois,famille_2020, by= "mois",all=TRUE)
fammois[is.na(fammois)]<-0
colnames(fammois)<-c("mois","famille_2016","famille_2017","famille_2018","famille_2019","famille_2020")

return(fammois)
}