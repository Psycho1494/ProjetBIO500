# Date: 11 mars 2024
# Jeux de donnees: acoustique_oiseaux
# Equipe: Emy Chevrette
#         Angelique Cornellier
#         Coralie Mimeault
#         Stephanie Morin-Beaumier

# 1-Creation des tables sql.
creationsql <-function(donnee_oiseau) {
  connexion <- dbConnect(SQLite(), dbname="OISEAU")
  on.exit(dbDisconnect(connexion))

#   Creation de la cle primaire qui va accueillir les informations sur les observations.

dbSendQuery(connexion, "DROP TABLE observations;")
creer_observations<-
  "CREATE TABLE observations(
id    INTEGER PRIMARY KEY AUTOINCREMENT,
site_id INTEGER,
variable  VARCHAR(50)
);"
dbSendQuery(connexion, creer_observations)

#   Creer une cle etrangere qui va accueillir les informations sur les sites.
dbSendQuery(connexion, "DROP TABLE site;")
creer_site<-
  "CREATE TABLE site(
id_site    INTEGER PRIMARY KEY AUTOINCREMENT,
site_id  INTEGER NOT NULL,
lat REAL,
FOREIGN KEY(id_site)REFERENCES observations(id)
);"
dbSendQuery(connexion, creer_site)

#   Creer une cle etrangere qui va accueillir les informations sur les especes d'oiseaux recensees.
dbSendQuery(connexion, "DROP TABLE espece;")
creer_espece<-
  "CREATE TABLE espece(
id_espece    INTEGER PRIMARY KEY AUTOINCREMENT,
valid_scientific_name VARCHAR(50),
vernacular_fr VARCHAR(50),
vernacular_en VARCHAR(50),
rank VARCHAR(50),
FOREIGN KEY(id_espece) REFERENCES observations(id)
);"
dbSendQuery(connexion, creer_espece)

#   Creer une cle etrangere qui va accueillir les informations temporelles des observations.
dbSendQuery(connexion, "DROP TABLE dob;")
creer_date_obs<-
  "CREATE TABLE dob(
id_obs    INTEGER PRIMARY KEY AUTOINCREMENT,
date_obs  DATE,
time_start TIME,
time_finish TIME,
time_obs TIME,
FOREIGN KEY(id_obs) REFERENCES observations(id)
);"
dbSendQuery(connexion, creer_date_obs)

#   Creer une cle etrangere qui va accueillir les informations taxonomiques des especes recensees.
dbSendQuery(connexion, "DROP TABLE taxo;")
creer_taxo<-
  "CREATE TABLE taxo(
id_taxo    INTEGER PRIMARY KEY AUTOINCREMENT,
species VARCHAR(50),
genus VARCHAR(50),
family  VARCHAR(50),
'order' VARCHAR(50),
class VARCHAR(50),
phylum VARCHAR(50),
kingdom VARCHAR(50),
FOREIGN KEY(id_taxo) REFERENCES observations(id)
);"
dbSendQuery(connexion, creer_taxo)

# 2-Injection des donnees dans les dataframes.

dbWriteTable(connexion, append = TRUE, name = "observations", value = donnee_oiseau[,c(1,7)], row.names = FALSE)
dbWriteTable(connexion, append = TRUE, name = "site", value = donnee_oiseau[,c("site_id","lat")], row.names = FALSE)
dbWriteTable(connexion, append = TRUE, name = "espece", value = donnee_oiseau[,c("valid_scientific_name","vernacular_fr","vernacular_en","rank")], row.names = FALSE)
dbWriteTable(connexion, append = TRUE, name = "dob", value = donnee_oiseau[,c("date_obs","time_start","time_finish","time_obs")], row.names = FALSE)
dbWriteTable(connexion, append = TRUE, name = "taxo", value = donnee_oiseau[,c("species","genus","family","order","class","phylum","kingdom")], row.names = FALSE)

dbListTables(connexion)

# 3-Generer les dataframes.

result_observations <- dbGetQuery(connexion, "SELECT * FROM observations")
print(result_observations)
result_site <- dbGetQuery(connexion, "SELECT * FROM site")
print(result_site)
result_espece <- dbGetQuery(connexion, "SELECT * FROM espece")
print(result_espece)
result_date_obs <- dbGetQuery(connexion, "SELECT * FROM dob")
print(result_date_obs)
result_taxo <- dbGetQuery(connexion, "SELECT * FROM taxo")
print(result_taxo)



}