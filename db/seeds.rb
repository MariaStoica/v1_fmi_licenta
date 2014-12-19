# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# SESIUNEA
Sesiune.create(data_start: "1-10-2014", data_end: nil, este_deschisa: true, deadline: "30-6-2015")


# USERS
# Admin id = 1
User.create(email: "admin@admin.com", 
	        nume: "FMI", prenume: "LicentaAdmin", 
	        rol: "Administrator", 
	        grupa: nil, grad: nil, 
	        este_eligibil_licenta: false, 
	        token: nil, 
	        specializare: nil, 
	        are_domeniu_propuneri_studenti: false)

# Darth Vader id = 2
User.create(email: "vader@prof.com",     
			nume: "Darth", prenume: "Vader", 
			rol: "Profesor", 
			grupa: nil, grad: "Profesor", 
			este_eligibil_licenta: true, 
			token: nil, 
			specializare: "Matematica", 
			are_domeniu_propuneri_studenti: false)
# Albus Dumbledore id = 3
User.create(email: "albus@prof.com",     
			nume: "Dumbledore", prenume: "Albus", 
			rol: "Profesor", 
			grupa: nil, grad: "Conferentiar", 
			este_eligibil_licenta: true, 
			token: nil, 
			specializare: "Informatica", 
			are_domeniu_propuneri_studenti: true)
# Han Solo id = 4
User.create(email: "solo@prof.com",      
			nume: "Solo", prenume: "Han", 
			rol: "Profesor", 
			grupa: nil, grad: "Asistent", 
			este_eligibil_licenta: false, 
			token: nil, 
			specializare: "Informatica", 
			are_domeniu_propuneri_studenti: false)

# Maria Stoica id = 5
User.create(email: "maria@student.com",  
			nume: "Stoica", prenume: "Maria", 
			rol: "Student", 
			grupa: 331, grad: nil, 
			este_eligibil_licenta: true, 
			token: nil, 
			specializare: "Informatica", 
			are_domeniu_propuneri_studenti: false)
# Stefan Lache id = 6
User.create(email: "stef@student.com",   
			nume: "Lache", prenume: "Stefan", 
			rol: "Student", 
			grupa: 314, grad: nil, 
			este_eligibil_licenta: true, 
			token: nil, 
			specializare: "Matematica", 
			are_domeniu_propuneri_studenti: false)
# Marius Melemciuc id = 7
User.create(email: "marius@student.com", 
			nume: "Melemciuc", prenume: "Marius", 
			rol: "Student", 
			grupa: 224, grad: nil, 
			este_eligibil_licenta: false, 
			token: nil, 
			specializare: "Informatica", 
			are_domeniu_propuneri_studenti: false)


# DOMENII
# Domeniile de matematica ale lui Vader
Domeniu.create(nume: "Logica Fuzzy",     user_id: 2, sesiune_id: 1, descriere: "Fuzzy logic is a form of many-valued logic; it deals with reasoning that is approximate rather than fixed and exact. Compared to traditional binary sets (where variables may take on true or false values), fuzzy logic variables may have a truth value that ranges in degree between 0 and 1. Fuzzy logic has been extended to handle the concept of partial truth, where the truth value may range between completely true and completely false. Furthermore, when linguistic variables are used, these degrees may be managed by specific functions.")
Domeniu.create(nume: "Corpuri si inele", user_id: 2, sesiune_id: 1, descriere: "In mathematics, and more specifically in algebra, a ring is an algebraic structure with operations generalizing the arithmetic operations of addition and multiplication. By means of this generalization, theorems from arithmetic are extended to non-numerical objects like polynomials, series, matrices and functions.")
Domeniu.create(nume: "Geometrie",        user_id: 2, sesiune_id: 1, descriere: "Geometry (from the Ancient Greek: γεωμετρία; geo- 'earth', -metron 'measurement') is a branch of mathematics concerned with questions of shape, size, relative position of figures, and the properties of space.")
Domeniu.create(nume: "Fractali",         user_id: 2, sesiune_id: 1, descriere: "A fractal is a natural phenomenon or a mathematical set that exhibits a repeating pattern that displays at every scale. If the replication is exactly the same at every scale, it is called a self-similar pattern.")

# Domeniile de informatica ale lui Albus
Domeniu.create(nume: "Inteligenta Artificiala",        user_id: 3, sesiune_id: 1, descriere: "Artificial intelligence (AI) is the intelligence exhibited by machines or software. It is an academic field of study which studies the goal of creating intelligence.")
Domeniu.create(nume: "Algoritmi si structuri de date", user_id: 3, sesiune_id: 1, descriere: "An algorithm is an effective method expressed as a finite list[1] of well-defined instructions[2] for calculating a function.[3] Starting from an initial state and initial input (perhaps empty),[4] the instructions describe a computation that, when executed, proceeds through a finite[5] number of well-defined successive states, eventually producing 'output'[6] and terminating at a final ending state. The transition from one state to the next is not necessarily deterministic; some algorithms, known as randomized algorithms, incorporate random input.[7]")
Domeniu.create(nume: "Retelistica",                    user_id: 3, sesiune_id: 1, descriere: "A computer network or data network is a telecommunications network that allows computers to exchange data. In computer networks, networked computing devices pass data to each other along data connections. Data is transferred in the form of packets. The connections (network links) between nodes are established using either cable media or wireless media. The best-known computer network is the Internet.")


# TEME
#Temele de mate
Tema.create(nume: "Position tracking and motion prediction using Fuzzy Logic", domeniu_id: 1, user_id: 2, sesiune_id: 1 ,este_libera: true, descriere: " - ")
Tema.create(nume: "Interval Type-2 Fuzzy Logic Systems",                       domeniu_id: 1, user_id: 2, sesiune_id: 1 ,este_libera: true, descriere: " - ")

Tema.create(nume: "Fractal Compression of Medical Images", domeniu_id: 4, user_id: 2, sesiune_id: 1 ,este_libera: true, descriere: " - ")

# Temele de info
Tema.create(nume: "Algoritmi genetici",       domeniu_id: 5, user_id: 3, sesiune_id: 1 ,este_libera: true, descriere: "In the field of artificial intelligence, a genetic algorithm (GA) is a search heuristic that mimics the process of natural selection. This heuristic (also sometimes called a metaheuristic) is routinely used to generate useful solutions to optimization and search problems.[1] Genetic algorithms belong to the larger class of evolutionary algorithms (EA), which generate solutions to optimization problems using techniques inspired by natural evolution, such as inheritance, mutation, selection, and crossover.")
Tema.create(nume: "Evolutionary programming", domeniu_id: 5, user_id: 3, sesiune_id: 1 ,este_libera: true, descriere: "Evolutionary programming is one of the four major evolutionary algorithm paradigms. It is similar to genetic programming, but the structure of the program to be optimized is fixed, while its numerical parameters are allowed to evolve.")

# ALEGERI_USER_TEMA

AlegeriUserTema.create(tema_id:1 , user_id:6 , sesiune_id: 1, status_profesor: "Accepted", status_student: "Pending")
AlegeriUserTema.create(tema_id:3 , user_id:6 , sesiune_id: 1, status_profesor: "Accepted", status_student: "Pending")
AlegeriUserTema.create(tema_id:5 , user_id:5 , sesiune_id: 1, status_profesor: "Accepted", status_student: "Pending")

# DEADLINES a.k.a. anunturile adminului cu fazele licentei pe parcursul anului
Deadline.create(nume: "Setarea domeniilor si a temelor", data_start: "1-10-2014", data_end: "1-11-2014", descriere: "Profesorii isi organizeaza domeniile si temele pentru anul curent.", public_tinta: "Profesor")
Deadline.create(nume: "Alegerea si discutarea temelor", data_start: "2-11-2014", data_end: "1-12-2014", descriere: "Studentii considera teme pentru licenta.", public_tinta: "Student")
Deadline.create(nume: "Raspunderea la cererile de licenta", data_start: "2-12-2014", data_end: "1-1-2015", descriere: "Profesorii trebuie sa raspunda la toate cererile cu Accept sau Reject - nu trebuie sa mai ramane niciun Pending. ", public_tinta: "Profesor")
Deadline.create(nume: "Alegerea licentei", data_start: "2-1-2015", data_end: "1-2-2015", descriere: "Alegerea temei pentru licenta.", public_tinta: "Student")
Deadline.create(nume: "Versiunea finala a licentei", data_start: "1-3-2015", data_end: "1-6-2015", descriere: "Urcarea versiunii finale de licenta.", public_tinta: "Student")
Deadline.create(nume: "Referatul de licenta", data_start: "2-3-2015", data_end: "8-6-2015", descriere: "Profesorii trebuie sa completeze referatul de licenta dupa ce versiunea finala a fost urcata.", public_tinta: "Profesor")







