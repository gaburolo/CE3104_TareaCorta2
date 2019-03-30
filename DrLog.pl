%Regla que determina si un valor es miembro de una lista
%miembro(valor,lista)
miembro(X,[X|_]).
miembro(X,[_|Y]):-miembro(X,Y).

% Hecho que determina si dos valores son iguales o bien retorna el mismo
% valor que se ingreso
igualdad(X,X).



% Serie de hechos que contienen cada uno una lista de palabras clabe
% para la interacion fluida del sistema experto con el usuario
% Son de la forma:
% hecho(["palabra clave 1","palabra clave 2",...,"palabra clave n"]).
saludo(["Hola","hola","Buenas","buenas","Buenos","buenos"]).
despedida(["adios","Adios","luego","gracias","Gracias"]).
afirmacion(["Bueno","bueno","Ok","si","Si","ok","Correcto","correcto","Afirmativo","afirmativo"]).
negacion(["No","no","negativo","Negativo","Incorrecto","incorrecto"]).
verbo1erP(["tengo","Tengo","tenido","siento","Siento","sentido","oigo","me"]).
conjuncion(["tambien","y","e"]).
pregunta(["que","Que","Como","como","cuales","Cuales","�que","�Que","�Como","�como","�cuales","�Cuales"]).
dictaminar(["quetengo","Quetengo","�quetengo?","quetengo?","�Quetengo?","Quetengo?","quetengodoctor","Quetengodoctor","�quetengodoctor?","quetengodoctor?","�Quetengodoctor?","Quetengodoctor?","quetengoDoctor","QuetengoDoctor","�quetengoDoctor?","quetengoDoctor?","�QuetengoDoctor?","QuetengoDoctor?"]).
dar_cuidados(["quetengoquetomar","Quetengoquetomar","�quetengoquetomar?","quetengoquetomar?","�Quetengoquetomar?","Quetengoquetomar?","quedebotomar","Quedebotomar","�quedebotomar?","quedebotomar?","�Quedebotomar?","Quedebotomar?","cualescuidadosdebotener","cualescuidadosdebotener?","�cualescuidadosdebotener?","quecuidadosdebotener","quecuidadosdebotener?","�quecuidadosdebotener?","cualescuidadostengoquetener","cualescuidadostengoquetener?","�cualescuidadostengotener?","quetengoquetomardoctor","Quetengoquetomardoctor","�quetengoquetomardoctor?","quetengoquetomardoctor?","�Quetengoquetomardoctor?","Quetengoquetomardoctor?","quedebotomardoctor","Quedebotomardoctor","�quedebotomardoctor?","quedebotomardoctor?","�Quedebotomardoctor?","Quedebotomardoctor?","cualescuidadosdebotenerdoctor","cualescuidadosdebotenerdoctor?","�cualescuidadosdebotenerdoctor?","cualescuidadostengoquetenerdoctor","cualescuidadostengoquetenerdoctor?","�cualescuidadostengotenerdoctor?"]).
dar_causas(["cualessonlascausa","�cualessonlascausa","Cualessonlascausa","�Cualessonlascausa","quelocausa","�quelocausa","Quelocausa","�Quelocausa"]).
freno_causas(["causas","causa","provoca","causas?","causa?","provoca?"]).
dar_prevenciones(["comopuedoevita","�comopuedoevita","�Comopuedoevita","comoseevita","�comoseevita","Comoseevita","�Comoseevita","comolaevita","�comolaevita","Comolaevita","�Comolaevita","comoloevita","�comoloevita","Comoloevita","�Comoloevita","comoseevita","�comoseevita","Comoseevita","�Comoseevita","quemaneraloevita","quemaneraseevita"]).
freno_prevenciones(["prevenirla","previene","evitar","evita","evitarla","evito","prevengo","prevenirla?","previene?","evitar?","evita?","evitarla?","evito?","prevengo?"]).



% Con esta regla somos capaces de tomar la linea de texto que
% ingresa el usuario en consola y convertirla en una lista de strings
% donde cada valor de la lista es una palabra para asi poder analizar el
% texto y reconocer las palabras clave.
% Retorna un sintoma.
consulta(R):-read_line_to_codes(user_input, Codes), atom_codes(A, Codes), atom_string(A, String), split_string(String,' ','',List),comparador(List,R).

% Nos permite lo mismo que consulta solo que esta regla recibe la
% enfermedad que se obtuvo con los sintomas obtenidos en pasos
% anteriores y nos da la informacion que preguntemos sobre la enfermedad
consulta2(E):-read_line_to_codes(user_input, Codes), atom_codes(A,
Codes), atom_string(A, String), split_string(String,' ','',List),comparador2(List,E).



% Esta regla va verificando recursivamente cada palabra de la lista
% ingresada, si hay alguna coinsidencia imprime la la respuesta del
% DrLog de acuerdo a lo dicho por el usuario y continua con la consulta.
% En caso de reconocer que se da un sintoma se retorna este sintoma.
% Si no se encuentra coinsidencia se da una respuesta predeterminada y
% se continua con la consulta.
comparador([],R):-igualdad("No entendi lo que me dijiste. �Podrias tratar de decirmelo diferente? o continuamos con otra cosa",P),write(P),nl,consulta(R).
comparador([X|Y],R):-verbo1erP(Z),miembro(X,Z),comprobar([X|Y],R).
comparador([X|_],R):-saludo(Z),miembro(X,Z),igualdad("�Buenas en que le puedo ayudar??",P),write(P),nl,consulta(R).
comparador([X|Y],R):-conjuncion(Z),miembro(X,Z),comprobar([X|Y],R).
comparador([X|_],R):-negacion(Z),miembro(X,Z),igualdad("Bueno dime algun sintoma para poder dictaminarte",P),write(P),nl,consulta(R).
comparador([X|_],R):-pregunta(Z),miembro(X,Z),igualdad("Aun no tengo los datos suficientes para responder alguna pregunta!",P),write(P),nl,consulta(R).
comparador([_|Y],R):-comparador(Y,R).

% Basicamente realiza la misma funcion de comparador solo que responde
% de manera diferente de acuerdo a lo ingresado por el usuario.
% Si se reconoce que se esta haciendo una pregunta se comprueba la
% pregunta y se responde acorde a esta.
% En caso de reconocer que el usuario se despide se termina la consulta.
comparador2([],E):-igualdad("No entendi lo que me dijiste. �Podrias tratar de decirmelo diferente? o continuamos con otra cosa",P),write(P),nl,consulta2(E).
comparador2([X|Y],E):-pregunta(Z),miembro(X,Z),comprobar2([X|Y],E).
comparador2([X|_],E):-verbo1erP(Z),miembro(X,Z),igualdad("Ya tengo los datos necesarios para dictaminarte, me lo puedes preguntar cuando quieras",P),write(P),nl,consulta2(E).
comparador2([X|_],E):-afirmacion(Z),miembro(X,Z),igualdad("�Y cual seria la pregunta??",P),write(P),nl,consulta2(E).
comparador2([X|_],E):-negacion(Z),miembro(X,Z),igualdad("Bueno si ya no quieres continuar despidete y damos por concluida la consulta",P),write(P),nl,consulta2(E).
comparador2([X|_],E):-saludo(Z),miembro(X,Z),igualdad("Ehh ok hola! �dime en que mas te puedo ayudar??",P),write(P),nl,consulta2(E).
comparador2([X|_],E):-despedida(Z),miembro(X,Z),igualdad(E,E).
comparador2([_|Y],E):-comparador2(Y,E).



% Luego de que se reconoce que se esta dando un sintoma se cuemprueba la
% lista de palabras y se concatena lo que este despues de la palabra
% clave hasta que termine el texto o se identifique alguna palabra para
% detenerse y se retornan las palabras del sintoma como un solo string
comprobar([X|Y],Sintoma):-verbo1erP(Z),miembro(X,Z),devolver_sintoma(Y,Sintoma).
comprobar([X|Y],Sintoma):-conjuncion(Z),miembro(X,Z),devolver_sintoma(Y,Sintoma).
comprobar([_|Y],Sintoma):-comprobar(Y,Sintoma).

% Verificamos la lista ingresada palabra por palabra y una ves
% reconocida la palabra clave se concatenan recursivamente en un solo
% string las palabras posteriores de la lista hasta que se vac�e la
% lista o se reconosca alguna palabra para detenerse.
devolver_sintoma(X,S):-igualdad(X,[]),igualdad("",S).
devolver_sintoma([X|_],S):-verbo1erP(Z),miembro(X,Z),igualdad("",S).
devolver_sintoma([X|_],S):-saludo(Z),miembro(X,Z),igualdad("",S).
devolver_sintoma([X|_],S):-conjuncion(Z),miembro(X,Z),igualdad("",S).
devolver_sintoma([X|_],S):-afirmacion(Z),miembro(X,Z),igualdad("",S).
devolver_sintoma([X|_],S):-negacion(Z),miembro(X,Z),igualdad("",S).
devolver_sintoma([X|Y],S):-devolver_sintoma(Y,R),string_concat(X,R,S).



% Se concatena la lista ingresada en un solo string y se verifia si este
% string es una pregunta valida.
comprobar2(X,Enfermedad):-concat_respuesta(X,R),verificar(R,Enfermedad).
comprobar2([_|Y],Enfermedad):-comprobar(Y,Enfermedad).

% Se concatena recursivamente la lista de palabras ingresada en un solo
% string y lo retorna
concat_respuesta(X,S):-igualdad(X,[]),igualdad("",S).
concat_respuesta([X|_],S):-saludo(Z),miembro(X,Z),igualdad("",S).
concat_respuesta([X|_],S):-conjuncion(Z),miembro(X,Z),igualdad("",S).
concat_respuesta([X|_],S):-afirmacion(Z),miembro(X,Z),igualdad("",S).
concat_respuesta([X|_],S):-negacion(Z),miembro(X,Z),igualdad("",S).
concat_respuesta([X|_],S):-freno_causas(Z),miembro(X,Z),igualdad("causa",S).
concat_respuesta([X|_],S):-freno_prevenciones(Z),miembro(X,Z),igualdad("evita",S).
concat_respuesta([X|Y],S):-concat_respuesta(Y,R),string_concat(X,R,S).



% Esta regla verifica si el string ingresado es una pregunta valida, si
% es as� imprime lo que el usuario pregunto y se continua con la
% consulta.
% Por ejemplo si se verifica que la pregunta esta relacionada con causas
% de la enfermedad, si es una enfermedad que esta registrada se imprimen
% las causas y si no lo esta se da una respuesta predeterminada.
verificar(P,E):-dictaminar(Z),miembro(P,Z),
    string_concat("Usted presenta los sintomas de: ",E,Dictamen),
    write(Dictamen),nl,write("�Alguna otra pregunta?"),nl,consulta2(E).
verificar(P,E):-dar_cuidados(Z),miembro(P,Z),igualdad(E,"Enfermedad desconocida"),write("No se los cuidados de su enfermedad ya que no se encuentra registrada"),nl,write("�Alguna otra pregunta?"),nl,consulta2(E).
verificar(P,E):-dar_cuidados(Z),miembro(P,Z),enfermedad(E,_,C,_,_),write(C),nl
    ,write("�Alguna otra pregunta?"),nl,consulta2(E).
verificar(P,E):-dar_causas(Z),miembro(P,Z),igualdad(E,"Enfermedad desconocida"),write("No se las causas de su enfermedad ya que no se encuentra registrada"),nl,write("�Alguna otra pregunta?"),nl,consulta2(E).
verificar(P,E):-dar_causas(Z),miembro(P,Z),enfermedad(E,_,_,C,_),write(C),nl
    ,write("�Alguna otra pregunta?"),nl,consulta2(E).
verificar(P,E):-dar_prevenciones(Z),miembro(P,Z),igualdad(E,"Enfermedad desconocida"),write("No se como se previene su enfermedad ya que no se encuentra registrada"),nl,write("�Alguna otra pregunta?"),nl,consulta2(E).
verificar(P,E):-dar_prevenciones(Z),miembro(P,Z),enfermedad(E,_,_,_,Prev),write(Prev),nl
    ,write("�Alguna otra pregunta?"),nl,consulta2(E).



% En esta regla se ingresan los sintomas obtenidos en la consulta y
% se verifica que exista una enfermedad registrada que concuerde con los
% sintomas.
% En caso de no identificarse una enfermedad se retorna "Enfermedad desconocida"
verificar_enfermedad(E,A,B,C):-enfermedad(E,[A,B,C],_,_,_).
verificar_enfermedad(E,A,B,C):-enfermedad(E,[A,C,B],_,_,_).
verificar_enfermedad(E,A,B,C):-enfermedad(E,[B,A,C],_,_,_).
verificar_enfermedad(E,A,B,C):-enfermedad(E,[B,C,A],_,_,_).
verificar_enfermedad(E,A,B,C):-enfermedad(E,[C,A,B],_,_,_).
verificar_enfermedad(E,A,B,C):-enfermedad(E,[C,B,A],_,_,_).
verificar_enfermedad(E,_,_,_):-igualdad(E,"Enfermedad desconocida").




%Con esta regla se da inicio a la consulta como tal
iniciar():-
    consulta(A),%retorna el primer sintoma
    write("�Que otro sintoma presenta?"),nl,
    consulta(B),%retorna el segundo sintoma
    write("�Que otro sintoma presenta?"),nl,
    consulta(C),%retorna el tercer sintoma
    verificar_enfermedad(Enfermedad,A,B,C),%verifica que la enfermedad exista
    write("Correcto ya tengo los sintomas suficientes, preguntame tu dictamen cuando quieras"),nl,
    consulta2(Enfermedad),%nos da la informacion de la enfermedad
    string_concat("Hasta luego fue un gusto atenderte!! :D  Y recuerda tienes ",Enfermedad,Despedida),
    write(Despedida).


%Con esta regla iniciamos el programa
consultar:-
    write('Bienvenido a su consulta medica proceda a hablar con DrLog'),nl,
    iniciar().%Se inicia la consulta



% Aqui estan las enfermedades que se encuentran registradas y si se
% agregan nuevas se van agregando de ultimas.
% Son de la forma:
% enfermedad(enfermedad,[sintoma1,sintoma2,sintoma3],cuidados,causas,prevenciones).
enfermedad("sida",["dolordegarganta","cansanciopersistente","inflamacionpelvica"],"Se recomienda tomar el tratamiento antirretroviral (TAR) que es una combinaci�n de medicamentos contra el VIH, vigile su peso corporal","El virus de inmunodeficiencia humana (VIH) es el virus que causa el sida. Cuando una persona se infecta con VIH, el virus ataca y debilita al sistema inmunitario. A medida que el sistema inmunitario se debilita, la persona est� en riesgo de contraer infecciones y c�nceres que pueden ser mortales","Mantenga sus pantalones arriba o use condon sin enbargo el segundo no es cien por ciento seguro xd").
enfermedad("sarampion",["salpullido","fiebre","tosseca"],"Untece calamina en el salpullido y tome antibiotico durante 4 dias","El sarampi�n es una enfermedad v�rica aguda causada por un paramixovirus del g�nero Morbillivirus","Los padres deben chequear si sus hijos tienen las vacunas del calendario al d�a. De 12 meses a cuatro a�os deben acreditar una dosis de vacuna triple viral (sarampi�n-rub�ola-paperas).").
