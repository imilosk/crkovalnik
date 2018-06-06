# Uporabniški vmesniki - 5. domača naloga - Aplikacija za postopno učenje pisnega sporazumevanja oseb s posebnimi potrebami

Nivoji težavnosti (izbere učitelj v nastavitvah):
1. Predloga (polja, kamor je treba povleči črke) z označenimi črkami.
2. Nad predlogo je zapisana beseda, predloga pa je prazna; otrok črke vleče v prazna
polja.
3. Pravilna beseda se ne izpiše, predloga je prazna. Otrok mora iz slike in premetanih
črk sam ugotoviti, za katero besedo gre in črke pravilno povleči v predlogo.
4. Namesto premetanih črk iskane besede, je otroku na voljo prilagojena tipkovnica (vse
črke slovenske abecede, brez številk in ločil).

#### DONE:
- Grid slik
- Dinamično ustvarjanje povleci-in-spusti polj z upoštevano toleranco, da ni potrebno popolno ujemanje pri "spusti"
- Nivoji težavnosti 1-3 (se ne preveri, ali je beseda pravilno vpisana)
- Gumba "Naprej" in "Nazaj" v igralnem zaslonu za spreminjanje slik 
- Preveri, ali je beseda pravilno vpisana
- Nagrada po pravilno vpisani besedi

#### FINISH:
- Uspešno/neuspešno akcijo (premik črke) ustrezno pobarvaj (zeleno/rdeče) - **manjka rdeča barva**
- Settings: glasbo, zvok vklopi/izklopi, črnobele skike (preberi sliko iz datoteke), izbor nivojev **samo izbor nivojev je narejen**
- Izhod iz igralnega zaslona naj bo le preko gumba "Nazaj", ki igralca vrne v zaslon kjer izbira področja besed. Od tu se preko "Nazaj" lahko vrne v osnovni zaslon, k izbiri igre - **manjkajo nekateri gumbi**

#### TODO: 
- Uspešno akcijo (premik črke) naj spremlja nek generičen zvok / klik; prav tako za neuspešno temu ustrezen zvok
- V nastavitvah naj bo možno izbirati med velikimi in malimi črkami

#### MAYBE:
- Nivo težavnosti 4
- Uredi kodo, koda naj bo razporejena v večih datotekah
- Na zaslonu naj bo slika besede na levi strani, predloga na desni premetane črke pa spodaj (kot je pokazal na predavanjih)
izbira področja besed

#### KAJ NE BOMO NAREDILI:
- V primeru tipkovnice, naj utripa oz. se otroku pokaže nek namig na ustrezno tipko. Namig (pomoč) naj bo možno v nastavitvah izklopiti.
- Če po nekem kratkem času otrok ne poskusi z (novo) črko ali pa se je zmotil, naj se prava ˇ
črka na nek način vizualno poudari. Lahko počasi utripa, lahko se veča in manjša, lahko
spreminja barvo, ..
- Namesto povleci-in-spusti naj bo v nastavitvah možno izbrati klikanje na ustrezno črko
ali uporaba enostavne tipkovnice.
- Administratorski način (dodajanje/brisanje slik, ...)
