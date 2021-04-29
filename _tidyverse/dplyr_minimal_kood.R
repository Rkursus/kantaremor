# Tidyderse - `dplyr` minimalistlikud näited

# Andmetabelist info kättesaamiseks kasutame R-i paketti *dplyr*, mis tuleb kaasa paketiga `tidyverse`

#Esmakordsel kasutamisel tuleb pakett installeerida. 
install.packages("tidyverse")
library(tidyverse)


# Paketi *dplyr* peamised käsud on:
# ---------------------------------
# * `select()`: vali alamhulk veergudest
# * `filter()`: vali alamhulk ridadest
# * `arrange()`: sorteeri ridu
# * `mutate()`: lisa uusi veerge
# * `summarise()`: agregeeri mitu väärtust üheks tunnuseks
# * `group_by()`: muuda andmestik grupeeritud andmestikuks, et seejärel rakendada funktsioone igale grupile eraldi
# * `ungroup()`: eemaldab andmetabelilt grupeeringu
# * `top_n()`: vali n esimest/viimast vaatlust


# Järgnevalt on toodud minimalistlikud näited, mis iseloomustavad paketi *dplyr* funktsionaalsust.
andmed = data.frame(sugu = c("M", "M", "N"),
                    vanus = c(20, 60, 30),
                    pikkus = c(180, 200, 150))
andmed


### select()
# vali alamhulk veergudest

# Näide 1
select(andmed, vanus)

# Näide 2
select(andmed, sugu, vanus)

# Näide 3 (annab sama tulemuse, mis näide 2)
select(andmed, -pikkus)


### filter()
# vali alamhulk ridadest

# Näide 1
filter(andmed, pikkus > 160)

# Näide 2
filter(andmed, pikkus > 160, vanus > 30)

# Näide 3 (sama, mis näide 2)
filter(andmed, pikkus > 160 & vanus > 30)


### arrange()
# sorteeri ridu

# Näide 1
arrange(andmed, pikkus)

# Näide 2 (sorteeri kahanevalt)
arrange(andmed, desc(pikkus))


### mutate()
# lisa uusi veerge

# Näide 1
mutate(andmed, pikkus2 = pikkus/100)

# Näide 2 (mitme tunnuse lisamine)
mutate(andmed, pikkus2 = pikkus/100,
       suvaline_tunnus = pikkus*vanus,
       keskmine_vanus = mean(vanus))


### summarise()
# agregeeri tunnuse väärtused üheks väärtuseks

summarise(andmed, keskmine_pikkus = mean(pikkus))


### group_by()
# muuda andmestik grupeeritud andmestikuks, kus funktsioone rakendatakse eraldi gruppidele

andmed_grupeeritult = group_by(andmed, sugu)

# Rakendame funktsiooni summarise iga grupi jaoks eraldi
summarise(andmed_grupeeritult, keskmine_pikkus = mean(pikkus))

# Lisaks keskmisele pikkusele võime ka iga grupi kohta loendada vaatluste arvu
summarise(andmed_grupeeritult, 
          keskmine_pikkus = mean(pikkus), 
          inimeste_arv = n())

# Sageli muudavad analüüsi kiireks ja mugavaks funktsioonid:
  
# * `distinct()` - eralda unikaalsed väärtused
# * `sample_n()` - tõmba n juhuslikku väärtust etteantud veerust
# * `n()` - loe kokku andmepunktide arv
# * `n_distinct()` - loe kokku unikaalsete väärtuste arv

### ungroup()

# muuda grupeeritud andmestik grupeerimata andmestikuks
ungroup(andmed_grupeeritult)

### top_n()
# eralda andmestikust mingi tunnuse järgi TOP n vaatlust

# top 1 pikkuse järgi
top_n(andmed, 1, pikkus)

# top 2 pikkuse järgi (näeme, et ei ole sorteeritud)
top_n(andmed, 2, pikkus)


# Enne vaatluste järjestamist saab tunnusele rakendada ka mingit funktsiooni.
# bottom 2 pikkuse järgi
top_n(andmed, 2, -pikkus)

# inimene, kelle pikkus on kõige lähemal 160-le
top_n(andmed, 1, -abs(pikkus-160) )


### Mitme funktsiooni järjest rakendamine
# Näide: Sorteerime pikkuse järgi ning valime välja ainult read, kus sugu == "M"

# Variant 1
sorteeritud = arrange(andmed, pikkus)
filter(sorteeritud, sugu == "M")

# Variant 2 (ilma vahetulemust salvestamata)
filter(arrange(andmed, pikkus), 
       sugu == "M")


### %>% operaator
# Funktsioonide järjest rakendamist võimaldab *dplyr* kirja panna *pipe* operaatori `%>%` abil. 

# See operaator võtab vasakul oleva objekti, ning annab selle edasi paremal oleva funktsiooni esimeseks argumendiks. 
#  Näiteks `f(x, y)` võime kirjutada `x %>% f(y)`.

# Eelneva näite jätk:
# Variant 3, pipe operaatoriga
andmed %>% 
  arrange(pikkus) %>%
  filter(sugu == "M")


# Nii saadud kood on paremini loetav, eriti kui järjest rakendatakse mitmeid funktsioone. 
# Näiteks
andmed %>%
  group_by(sugu) %>%
  summarise(keskmine_pikkus = mean(pikkus))



# *Lisamärkus 2.* 
# Operaatorit `%>%` saab kasutada ka teiste funktsioonide (mitte ainult *dplyr* enda funktsioonide) jaoks.
c(1,3) %>% mean() %>% log(base=2)

