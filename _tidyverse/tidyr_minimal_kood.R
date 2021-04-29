# Tidyderse - `tidyr` näited

# Pakett `tidyr` on Hadley Wickhami kirjutatud R-i pakett, mis tuleb kaasa paketiga `tidyverse`. 
#  See pakett aitab laias formaadis andmetabelit transformeerida pikas formaadis andmestikuks ja vastupidi (nn pivot).
library(tidyverse)

# Järgnevalt on toodud minimalistlikud näited, mis iseloomustavad paketi `tidyr` funktsionaalsust.
andmed = data.frame(nimi= c("Mati", "Toomas", "Kati"),
                    sugu = c("M", "M", "N"),
                    vanus = c(20, 60, 30),
                    pikkus = c(180, 200, 150),
                    kaal = c(80, 100, 50))
andmed


### gather()
# Transformeeri lai andmestik pikaks.

# Näide 1
gather(andmed, key=tunnus, value=vaartus, vanus, pikkus, kaal)

# Näide 2
gather(andmed, key=tunnus, value=vaartus, vanus:kaal)

# Näide 3
gather(andmed, key=tunnus, value=vaartus, -nimi, -sugu)

# Näide 4
gather(andmed, key=tunnus, value=vaartus, -nimi)

# Näide 5
gather_(andmed, key_col="tunnus", value_col="vaartus", 
        gather_cols = c("sugu","vanus","pikkus","kaal"))


### spread()

# Transformeeri pikk andmestik laiaks.

# pikas formaadis andmed
andmed.pikk = gather(andmed, key=tunnus, value=vaartus, -nimi, -sugu)
andmed.pikk

# Näide 1
spread(andmed.pikk, key=tunnus, value=vaartus)

# Näide 2
spread_(andmed.pikk, key_col="tunnus", value_col="vaartus")



