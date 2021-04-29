# --- Rakendustarkvara R
# --- II praktikum ----


# --- 1. Väärtuste tüübid ----

kaalud <- c(73, 85, 92.3, 62, 103.2, 70.2)
nimed <- c("Liisa", "Margus", "Mati", "Maria", "Tauno", "Heleri")
vanused <- c(37, NA, 23, 53, 53, 45)

# Kontrollimem väärtuste tüüpe
is.integer(kaalud)
is.numeric(kaalud)

class(liik)
class(vanused)
is.na(vanused)

# Eraldi käsk on ka puuduvate väärtuste esinemise kontrolliks:
is.na(vanused)
anyNA(vanused)



# ---- ÜL 1.1.1 ----

# 1.  
x <- c(0:5, "tekst", "T", 234.5, "234,5")
x

# Kas on sõned?
is.character(x)

# Proovi arvuks teisendada: as.numeric()
as.numeric(x) 


# 2.
# Kas tulemus on oodatav?
z <- c("a", "NA", NA, 0)
is.na(z)



 
# --- 1.2 Tõeväärtused ja tõeväärtusvektorid ----

# Tõeväärtusvektori tekitamiseks piisab vektori kontrollimist mõne väärtusega
kaalud > 80
vanused == 53
nimed == "Mati"
vanused == kaalud
nimed == "Mati" | nimed == "Maria"

# Kui soovime mingit väärtust võrrelda NA-ga, siis järgnev kahjuks ei tööta
vanused == NA

# Puuduvaid väärtusi saab kontrollida funktsiooniga is.na()
is.na(vanused)

# Kui on vaja kontrollida kas ming väätus leidub etteantud hulgas:
1:4 %in% c(2, 5)

c(2, 5) %in% 1:4

# Tõeväärtusi saab kasutada arvutustel, sellisel juhul konverteeritakse tõeväärtused TRUE => 1, FALSE => 0.
is.na(vanused) * 1
sum(is.na(vanused))


# ---- ÜL 1.2.1 ----

# 1.
as.integer(c("tere", 0, 1, TRUE, FALSE)) 
as.integer(c(        0, 1, TRUE, FALSE))
# Miks on tulemused erinevad?

# LISA

# Mis tekst teisendub loogikaväärtuseks?
# vt  
?logical
#  c("T", "TRUE", "True", "true") are regarded as true,
#  c("F", "FALSE", "False", "false") as false
# Kontrolli
tekst <- c("T", "TRUE", "True", "true", "F", "FALSE", "False", "false", "skljgsdfj", "TRue", "truE", "fals", "FAlse")
as.logical(tekst)
 



# --- 2. Andmestik, andmete import ----

# Proovi Import DataSet võimalusi RStudios.



# --- 2.1 Töökausta seadistamine ----

# Töökausta paika seadmine
# Windowsis kaustade struktuuri tähistamiseks kasutada tagurpidi kaldkriipsu "\" (backward slash),
# kuid R-is on sellel oma tähendus, seega tuleb kasutada "\\"
setwd("C:\\Users\\mina\\Rkoolitus\\")

# Aga võib kasutada ka tavalist kaldkriipsu "/" (forward slash)
setwd("C:/Users/mina/Rkoolitus/")

# RStudios saab töökataloogi ka automaatselt seada käesoleva skripti asukoha järgi

#install.packages('rstudioapi')
setwd(dirname(rstudioapi::getActiveDocumentContext()[[2]]))

# Tulemused saab kirjutada faili käsuga write.csv2()
write.csv2(näide1, "failinimi.txt", row.names = F)



# --- 2.2 Esmase ülevaate saamine andmetabelist ----

load(url("https://github.com/Rkursus/kantaremor/raw/main/data/andmed.RData"))
str(andmed)
summary(andmed)
dim(andmed)
ncol(andmed)
nrow(andmed)
names(andmed)
head(andmed)



# --- 3. Toimingud andmestikuga ----


# --- 3.1 Veergude ja ridade eraldamine andmestikust: indeksi ja nime järgi ----

# Andmestikus ainult ühe veeru uurimiseks kasutame dollari-sümbolit
vanused <- andmed$vanus
median(andmed$vanus)
median(vanused)

# data.frame on kahemõõtmeline tabel, seega iga elemendi asukoht on määratud rea ja veeru numbriga
# Rea- ja veerunumbrite abil andmestikust infot eraldades tuleb kasutada kantsulgusid:

andmed[3, 2] # kolmas rida, teine veerg
andmed[ , 2] # kogu teine veerg
andmed[3, ] # kogu kolmas rida

# Korraga on võimalik eraldada ka mitut rida või veergu, kasutades selleks käsku c(.):

andmed[, c(2, 4)] # teine ja neljas veerg
valik <- c(2, 4) # tekitame objekti, milles on kirjas huvipakkuvate veergude numbrid
andmed[, valik] # kasutame seda objekti andmestikust veergude eraldamiseks
andmed[c(5, 3, 9), ] # viies, kolmas ja üheksas rida

# Tihti on veeruindeksite asemel mugavam kasutada veergude nimesid (peavad olema jutumärkides):
andmed[, c("vanus", "pikkus")]  # eraldame veerud "vanus" ja "pikkus"




# --- 3.2 Uue tunnuse lisamine ----

# Uue tunnuse lisamiseks tuleb valida uus tunnuse nimi ja omistada väärtused
andmed$pikkus_meetrites <- andmed$pikkus/100
str(andmed)


# --- 3.4 Veergude ja ridade eraldamine andmestikust: tõeväärtusvektori abil ----

# eraldame kõik read, kus sugu == 2 (Mees) ning salvestame selle uueks objektiks
mehed <- andmed[andmed$sugu == "2", ]

# moodustame kaks filtritunnust ja kombineerime need alagrupi valikuks
filter_tervis <- andmed$tervis == "väga hea"              # väga hea tervisega
filter_vanus <- andmed$vanus >= 23                        # vähemalt 23 aastased
alamandmestik <- andmed[filter_tervis & filter_vanus, ]   # Ära unusta: [read, veerud]

# ---- ÜL 3.3.1 ----

# Moodusta alamandmestik, kuhu kuuluvad uuritavad, kellel puudub vererõhu mõõtmistulemus 
#  (tunnus `SVR` - süstoolne vererõhk)
alamandmestik <- andmed[_____,______]




