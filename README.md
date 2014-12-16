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



Sunt 3 tipuri de useri:

1. Admin

2. Student

3. Profesor

Mod de functionare:

1. Profesorii isi adauga domeniile si temele de licenta pentru a fi alese de catre studenti.

2. Pentru ca o tema sa devina lucrare de licenta, are nevoie de accordul profesorului si al studentului.

3. Comunicarea dintre student si profesorul coordonator se face prin comentarii la nivelul lucrarii, al capitolelor si al fisierelor incarcate.

4. Progresul lucrarii se masoara in functie de todo-urile completate de student.

5. La orice moment, profesorul isi poate vedea studentii si progresul lor in pagina "Studentii mei" 

6. Adminul gestioneaza sesiunile de functionare ale aplicatiei de licenta. Oricine se poate uita pe arhiva de teme de licenta si pe lista curenta de teme, dar nu pot interactiona cu ele (eg: studentii nu pot sa isi aleaga o tema de licenta in afara perioadei de functionare). In momentul in care adminul opreste sesiunea curenta a aplicatiei, temele curente se arhiveaza.

