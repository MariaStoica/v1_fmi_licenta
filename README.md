## Licență FMI

Aplicatia web pentru gestionarea dezvoltarii lucrarii de licenta de la alegerea profesorului coordonator si tema lucrarii pana la predarea lucrarii finale si generarea referatului de licenta. 

Useri pentru development si test:

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

Cum functioneaza aplicatia de licenta:


### 1. Sesiunile de functionare ale aplicatiei de licenta

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


### 2. Autentificarea

Pentru a accesa orice resursa a aplicatiei de licenta, userul trebuie sa fie logat. Asta se face cu ajutorul site-ului de autentificare (auth). Adica: te duci la linkul aplicatiei de licenta, esti redirectionat pe site-ul de auth (http://fmi-api.herokuapp.com) unde introduci credentials si apoi esti redirectionat inapoi la pagina de home a aplicatiei de licenta.



------

to be continued . . .

