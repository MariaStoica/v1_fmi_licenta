# Licență FMI

Aplicatia web pentru gestionarea dezvoltarii lucrarii de licenta de la alegerea profesorului coordonator si tema lucrarii pana la predarea lucrarii finale si generarea referatului de licenta. 

------

### 0. New to Ruby on Rails:

Uita-te mai intai pe **MyRubyOnRailsCheatSheet.pdf** daca nu esti familiar cu limbajul, iar daca nu stii Ruby on Rails fa mai intai de toate Rails For Zombies 1 si 2 (http://railsforzombies.org). Iti ia cam 2 zile dar macar intelegi RoR foarte bine si te poti apuca de treaba. In cheat sheet-ul meu gasesti cam toate functiile si comenzile folosite in aplicatia de licenta impreuna cu alte resurse. Sunt si comenzi puse la indemana in caz ca le uiti. Recomandarea mea e sa tii cheat sheet-ul asta deschis ca sa te poti uita pe el cand iti trebuie ceva. Eu folosesc Evernote pentru asta.

------

### 1. Get it to work locally:

```
$ git clone https://github.com/RoR-FMI/licenta.git
$ cd licenta
$ bundle install
$ rake db:migrate
$ rake db:seed
```

Cel mai bine e sa incepi cu baza de date din seeds.rb (prin rularea comenzii `$ rake db:seed`) si apoi sa te joci cu aplicatia. Daca vrei sa resetezi baza de date (sa stearga datele din prezent si sa puna datele din seeds.rb) ruleaza `$ rake db:reset`.

------

### 2. Useri pentru development si test:

**Rol: Administrator**
* admin@admin.com

**Rol: Profesor**
* vader@prof.com
* solo@prof.com
* albus@prof.com

**Rol: Student**
* maria@student.com
* stef@student.com
* marius@student.com

**Password: foobar**

------

### 3. Cum functioneaza aplicatia de licenta:

#### 3.0. Ce poate sa faca fiecare user (vezi si /browse_pagini/listaFeatures)

###### Administratorul...

* ...are grija de pornirea si oprirea sesiunii de functionare a aplicatiei (in vacanta de vara e inchisa, in timpul anului universitar e deschisa).
* ...creaza deadline-uri si reminders cu diverse lucruri pe care le au de facut profesorii si studentii in felul urmator: (datele si alert-urile sunt orientative). De asemenea pot fi si alerturi penru completarea unor documente necesare la secretariat.
	0. Sesiunea se deschide pe 1 Oct
	1. (1 Oct - 1 Nov) Profesorii isi introduc domeniile si temele pentru anul curent.
	2. (2 Nov - 2 Dec) Studentii isi aleg temele de licenta
	3. (3 Dec - 3 Ian) Profesorii trebuie sa fi dat un raspuns (Accept sau Reject) la toate solicitarile pe care le-au avut. Daca mai exista Pending-uri trebuiesc lamurite.
	4. (4 Ian - 6 Jun) Studentii isi aleg tema pentru licenta si incep sa lucreze la ea. Trebuie ca versiunea finala sa fie urcata inainte de 6 Jun.
	5. (4 Feb - 8 Jun) Profesorii trebuie sa fi create referatele de licenta pentru toti studentii lor care au urcat versiunea finala de licenta.
	6. Sesiunea se inchide pe 30 Jun
* ...updateaza informatii despre useri - unii profesori au specializare dubla si pot primi studenti atat de la informatica cat si de la matematica. Iar unii studenti, desi sunt in an terminal, nu isi dau licenta si atunci nu au voie sa interactioneze cu aplicatia mai mult decat vizualizarea arhivei.

###### Profesorul...

* ...poate vedea anunturile si deadline-urile puse de administrator
* ...isi gestioneaza temele si domeniile. Poate accepta sau nu teme de la studenti.
* ...poate sa vada si sa raspunda la discutiile temelor sale.
* ...isi poate vedea studentii cu licenta si progresul pe care l-au facut pana acum. Poate vedea si studentii care au ales teme din domeniile sale sau care au propus.
* ...poate vedea pagina de licenta a studentilor pe care ii are la licenta. Poate sa le vada fisierele incarcate si sa discute cu ei la nivel de licenta, capitol si fisier. Poate sa urce fisiere numai in capitolul Bibliografie.
* ...poate genera referatul de licenta numai dupa ce studentul a incarcat versiunea finala si progresul este 100%
* ...poate accesa arhiva la orice moment.

###### Studentul...

* ...poate vedea anunturile si deadline-urile puse de administrator
* ...poate vedea si cauta in temele profesorilor din aceeasi specializare ca el/ea.
* ...poate sa discute la nivel de tema inainte sa o aleaga. Cand adauga un comentariu la disctuiile temei respective, profesorul posesor primeste mail.
* ...nu poate sa vada tema propusa de un alt student decat daca acesta nu o ia la licenta. In momentul acela devine vizibila si celorlalti studenti.
* ...poate adauga capitole si todo-uri la licenta si fisiere. Poate sa discute cu profesorul coordonator la nivel de licenta, capitol sau fisier.
* ...poate incarca versiunea finala a licentei numai dupa ce progresul este 100%.
* ...poate renunta la licenta in orice moment dupa ce si-a ales o tema pentru licenta si inainte sa urce versiunea finala a licentei. In momentul acesta, tema aleasa devine libera, progresul (capitolele, todo-urile si fisierele) asociat licentei (tema si studentul) ramane in baza de date. Daca tema asta e luata de alt student atunci progresul ei se sterge din baza de date. Daca nu o ia nimeni, studentul care a renuntat la ea poate sa revina la tema fara sa fi pierdut progresul.
* ...poate accesa arhiva la orice moment.

#### 3.1. Baza de date (sau cine-i cine si care ce vrea)

![alt text](https://github.com/RoR-FMI/licenta/blob/master/LicentaFMI_ERD_simplu.png "Aplicatia de licenta FMI baza de date siplificata")


###### Povestea pe scurt:

Fiecare **User** este Administrator, Student sau Profesor. 
Fiecare profesor are domenii si teme.
**Temele** fac parte dintr-un **domeniu**.
Temele pot fi adaugate atat de profesori cat si de studenti (diferenta o face **user_id**).
Fiecare Student isi alege mai multe teme de licenta care apar in **AlegeriUserTema**. In momentul in care are Accept de la profesorul temei, studentul poate sa o aleaga pe aceea ca fiind licenta lui si sa inceapa sa lucreze la ea. Fiecare licenta are mai multe capitole si fisiere. Fiecare capitol are mai multe todos.

Campurile cu portocaliu nu sunt in schema.rb dar pot fi apelate (vezi explicatii in *Rails For Zombies 2*).
Capurile taiate cu rosu nu exista in schema (au fost adaugate de Ponyorm (http://ponyorm.com) cand am facut diagrama pentru a arata relatiile).

###### Toate Tabelele:

* **User**

> Fiecare User care se logheaza prin api-ul fmi poate fi *Administrator*, *Student* sau *Profesor*. Cand se logheaza, daca nu este in baza de date a aplicatiei de licenta atunci este adaugat. Cand aplicatia este deschisa, doar studentii si profesorii eligibili pentru licenta pot folosi toate resursele aplicatiei. Adica **studentii din an terminal care s-au inscris la licenta** si **profesorii cu un grad >= Lector**.

* **Tema**

> Temele sunt in mare parte propuse de profesori si fiecare tema face parte dintr-un domeniu. Insa si studentii pot propune teme in domeniile **Propuneri Studenti** care figureaza la profesorii care accepta propuneri de la studenti.

* **Domeniu**

> Temele sunt clasificate pe domenii (arii mai mari de materie care au multiple implementari si aplicatii (potentiale teme)). Domeniul **Propuneri Studenti** este un titlu rezervat pentru a anunta ca profesorul domeniului accepta propuneri de la studenti. Studentii pot sa adauge teme aici fie din pagina BrowserHome fie de pe pagina Domeniului. 

* **AlegeriUserTema**

> Un student poate sa aleaga mai multe teme pana primeste acceptul unui profesor pentru ca acea tema sa devina licenta in progres. AlegeriUserTema este o combinatie de user si tema cu atribute pentru raspunsul studentului si al profesorului. La inceput ambele sunt **Pending**. Profesorul poate sa dea **Reject** si atunci s-a terminat sau **Accept**, caz in care daca studentul da si el accept atunci lucrarea devine licenta in progres si se adauga in tabelul Licenta.

* **Licenta**

> Reprezinta o combinatie de user si tema sa.

* **LicentaSalvata**

> Tabelul Licenta e folosit in sesiunea curenta pentru a tine cont de ce studenti renunta la licenta sau isi schimba tema. LicentaSalvata este o copie de backup a licentlor (a combinatiilor de user si tema) pentru cazul in care studentii revin la prima tema si sa nu isi piarda munca. Daca altcineva le ia tema la care au renuntat, atunci progresul lor se pierde din baza de date. (se sterg capitolele, fisierele si todo-urile)

* **Capitol**

> Fiecare capitol apartine unei Licente. La crearea licentei se genereaza automat 3 capitole obligatorii din orice lucrare: Introducere, Concluzii si Bibliografie. Fiecare capitol poate avea todo-uri si fisiere.

* **Fisier**

> Fiecare fisier apartine unui capitol. Studentul poate sa urce fisiere in toate capitolele, profesorul coordonator, numai in capitolul Bibliografie. Fisierele urcate pot fi materiale ajutatoare din partea profesorului sau pot fi schite de capitol din partea studentului care cere feedback.

* **Todo**

> Fiecare todo apartine unui capitol. Sunt folosite pentru a ajuta studentul sa isi organizeze pasii implementarii licentei. Pe baza todo-urilor rezolvate se calculeaza progresul licentei. Cand atinge 100% poate sa urce versiunea finala de licenta si apoi se poate genera referatul de licenta.

* **Sesiune**

> Reprezinta anul universitar pe parcursul caruia functioneaza aplicatia. Este folosit in vizualizarea arhivei si separarea temelor, domeniilor, alegelilor facut de studenti si a licentelor pe fiecare an. Sesiunile sunt pornite si oprite de catre administrator.

* **Deadline**

> Alerte, anunturi, mesaje si deadline-uri create de administrator. Unele sunt numai pentru profesori, altele sunt pentru studenti, altele sunt de interes general.

* **ComentariuTema**

> Comentariile acestea sunt afisate pe IntreabaPage si reprezinta discutia publica a studentilor cu profesorul temei. Daca autorul temei este un student atunci profesorul din discutie va fi posesorul domeniului temei.

* **ComentariuLicenta**

> Acestea sunt pe pagina LicentaHome si reprezinta discutia dintre profesor si studentul sau.

* **ComentariuCapitol**

> La fel la nivel de capitol ca sa fie structurat schimbul de informatii. Pot fi intrebari sau feedback etc.

* **ComentariuFisier**

> Disctuie la nivelul unui fisier uploadat. Intrebari, feedback, nelamurir, imbunatatiri etc. 


#### 3.2. Sesiunile de functionare ale aplicatiei de licenta

Aplicatia de licenta este disponibila tot anul si se poate gasi in una din urmatoarele 2 stari:

1. **inchisa**

2. **deschisa**

Cand este **inchisa** (in vacanta de vara), userii sunt limitati doar la vizionare in mare parte.
Mai exact:
* Administratorul are aceleasi acces ca si atunci cand aplicatia e deschisa.
* Profesorii pot doar sa vada arhiva de teme din anii trecuti pana in prezent (inclusiv sesiunea care tocmai s-a inchieat) si lucrarile de licenta ale studentilor pe care i-a avut.
* Studentii pot doar sa vizualizeze arhiva de teme. Cei care si-au dat licenta anul curent mai au acces la pagina lor de licenta (ca vizualizare) pana cand incepe urmatoarea sesiune (licenta le este pastrat in baza de date).

Cand este **deschisa** (in timpul anului) se intampla mai multe lucruri (care sunt detaliate in punctele urmatoare):
- alerte, deadlineuri, reminders si hartii de completat
- domeniile si temele propuse de profesori
- discutarea temelor
- temele propuse de studenti
- alegerea temei de licenta
- incepe treaba: pagina de licenta, capitole, fisiere, todos, progres, submit final version
- generarea referatului de licenta


#### 3.3. Autentificarea

Pentru a accesa orice resursa a aplicatiei de licenta, userul trebuie sa fie logat. Asta se face cu ajutorul site-ului de autentificare (http://fmi-api.herokuapp.com). Daca nu esti logat si te duci pe un link din aplicatia de licenta, esti redirectionat pe site-ul de auth unde introduci e-mailul si parola. Primesti un token de autentificare si apoi esti redirectionat inapoi la pagina de home a aplicatiei de licenta.

#### 3.4. Despre paginile si controllerele din aplicatie

* **admin_pagini**_controller.rb

> * **ControlPanel** - locul de unde administratorul porneste o sesiune noua sau o inchide pe cea curenta si gestioneaza alertele si deadline-urile
> * **UserSpecializari** - aici poate vedea toti userii (profesori si studenti) care s-au logat in aplicatia de licenta macar o data - poate vedea cati studenti are fiecare profesor si daca mai are cereri de licenta la care nu a raspuns

* **browse_pagini**_controller.rb

> * **BrowseHome** - cu toate domeniile si temele din sesiunea curenta atunci cand aplicatia e deschisa
> * **IntreabaPage** - pagina cu discutia legata de o tema. diferenta dintre temele afisate se face prin parametrii in link
> * **AlegerileMele** - pagina pentru studenti in care vad la ce teme au dat Alege Tema si care profesori nu le-au raspuns (Pending) sau le-au raspuns fie cu Accept fie cu Reject
> * **TemeleMele** - pagina pentru profesori in care isi gestioneaza domeniile, temele si acceptul pentru temele propuse de studenti
> * **StudentiiMei** - pagina pentru profesori in care vad studentii pe care ii au la licenta imrpeuna cu progresul fiecaruia al lucrarea sa
> * **BrowseHomeArhiva** - pagina cu toate sesiunile anterioare
> * **ListaFeatures** - o pagina in care am enumerat toate functionalitatile aplicatiei
> * **ViewDataBase** - o pagina pe care am afisat toata baza de date - ca sa nu fie nevoie sa stai in consola rails pentru vizualizare. Dar trebuie sa intri in consola daca vrei sa faci vreo modificare. `$ rails c` (vezi cheat sheet la 5. The Data Base pentru diverse comenzi)

* **licenta_pagini**_controller.rb

> * **LicentaHome** - pagina de home a studentilor care si-au ales deja licenta. Aici sunt afisate: progresul total, lista de todo-uri pe capitol, alerte si alte deadline-uri de actualitate si discutia la nivel de licenta cu profesorul coordonator

* **user_sessions**_controller.rb

> Aici, in metoda *create*, verific daca userul logat exista deja in baza de date a aplicatiei de licenta. Daca da, ii updatez tokenul de autentificare. Daca nu, fac un GET ca sa iau toate datele despre user si il adaug in baza mea de date.

Controllerele

* *alegeri_user_temas*_controller.rb
* *capitols*_controller.rb
* *comentariu_capitols*_controller.rb
* *comentariu_fisiers*_controller.rb
* *comentariu_licentas*_controller.rb
* *comentariu_temas*_controller.rb
* *deadlines*_controller.rb
* *domenius*_controller.rb
* *fisiers*_controller.rb
* *licenta_salvata*_controller.rb
* *licentas*_controller.rb
* *sesiune*_controller.rb
* *temas*_controller.rb
* *todos*_controller.rb
* *users*_controller.rb

au fost generate de catre scaffold cand am creat modelele. Nu contin nimic in plus fata de codul generat.

------

### 4. Alte observatii
* Codul care da mailuri a fost comentat pentru ca nu functioneaza pe heroku daca nu configurezi un serviciu de mail. Dar local, merge sa dai mail daca decomentezi codul. (vezi cheat sheet la Mail pentru un overview al modului de implementare al mailului)

------

### 5. Ce-a mai ramas de implementat (vezi si issues)

* generarea referatului de licenta

------

to be continued . . .

