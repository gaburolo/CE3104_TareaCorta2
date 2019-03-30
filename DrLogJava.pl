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
pregunta(["que","Que","Como","como","cuales","Cuales","¿que","¿Que","¿Como","¿como","¿cuales","¿Cuales"]).
dictaminar(["quetengo","Quetengo","¿quetengo?","quetengo?","¿Quetengo?","Quetengo?","quetengodoctor","Quetengodoctor","¿quetengodoctor?","quetengodoctor?","¿Quetengodoctor?","Quetengodoctor?","quetengoDoctor","QuetengoDoctor","¿quetengoDoctor?","quetengoDoctor?","¿QuetengoDoctor?","QuetengoDoctor?"]).
dar_cuidados(["quetengoquetomar","Quetengoquetomar","¿quetengoquetomar?","quetengoquetomar?","¿Quetengoquetomar?","Quetengoquetomar?","quedebotomar","Quedebotomar","¿quedebotomar?","quedebotomar?","¿Quedebotomar?","Quedebotomar?","cualescuidadosdebotener","cualescuidadosdebotener?","¿cualescuidadosdebotener?","quecuidadosdebotener","quecuidadosdebotener?","¿quecuidadosdebotener?","cualescuidadostengoquetener","cualescuidadostengoquetener?","¿cualescuidadostengotener?","quetengoquetomardoctor","Quetengoquetomardoctor","¿quetengoquetomardoctor?","quetengoquetomardoctor?","¿Quetengoquetomardoctor?","Quetengoquetomardoctor?","quedebotomardoctor","Quedebotomardoctor","¿quedebotomardoctor?","quedebotomardoctor?","¿Quedebotomardoctor?","Quedebotomardoctor?","cualescuidadosdebotenerdoctor","cualescuidadosdebotenerdoctor?","¿cualescuidadosdebotenerdoctor?","cualescuidadostengoquetenerdoctor","cualescuidadostengoquetenerdoctor?","¿cualescuidadostengotenerdoctor?"]).
dar_causas(["cualessonlascausa","¿cualessonlascausa","Cualessonlascausa","¿Cualessonlascausa","quelocausa","¿quelocausa","Quelocausa","¿Quelocausa"]).
freno_causas(["causas","causa","provoca","causas?","causa?","provoca?"]).
dar_prevenciones(["comopuedoevita","¿comopuedoevita","¿Comopuedoevita","comoseevita","¿comoseevita","Comoseevita","¿Comoseevita","comolaevita","¿comolaevita","Comolaevita","¿Comolaevita","comoloevita","¿comoloevita","Comoloevita","¿Comoloevita","comoseevita","¿comoseevita","Comoseevita","¿Comoseevita","quemaneraloevita","quemaneraseevita"]).
freno_prevenciones(["prevenirla","previene","evitar","evita","evitarla","evito","prevengo","prevenirla?","previene?","evitar?","evita?","evitarla?","evito?","prevengo?"]).



% Con esta regla somos capaces de tomar la linea de texto que
% ingresa el usuario y convertirla en una lista de strings
% donde cada valor de la lista es una palabra para asi poder analizar el
% texto y reconocer las palabras clave para retornar una respuesta
% adecuada.
consulta(String,R):-split_string(String,' ','',List),comparador(List,R).

% Nos permite lo mismo que consulta solo que esta regla recibe la
% enfermedad que se obtuvo con los sintomas obtenidos en pasos
% anteriores y nos da la informacion que preguntemos sobre la enfermedad
consulta2(String,E,R):-split_string(String,' ','',List),comparador2(List,E,R).



% En esta regla ingresamos la respuesta del doctor para verificar si se
% nos esta dando un sintoma y si es asi retorna el sintoma y si no
% retorna un 1.
verificar_pregunta(P,_,S):-igualdad('No entendi lo que me dijiste. Podrias tratar de decirmelo diferente, o continuamos con otra cosa',P),igualdad('1',S).
verificar_pregunta(P,R,S):-igualdad('Que otro sintoma presenta?',P),split_string(R,' ','',List),comprobar(List,S).
verificar_pregunta(P,_,S):-igualdad('Buenas en que le puedo ayudar??',P),igualdad('1',S).
verificar_pregunta(P,_,S):-igualdad("Bueno dime algun sintoma para poder dictaminarte",P),igualdad("1",S).
verificar_pregunta(P,_,S):-igualdad("Aun no tengo los datos suficientes para responder alguna pregunta!",P),igualdad("1",S).



% Esta regla va verificando recursivamente cada palabra de la lista
% ingresada, si hay alguna coinsidencia retorna la la respuesta del
% DrLog de acuerdo a lo dicho por el usuario.
% Si no se encuentra coinsidencia se retorna una respuesta
% predeterminada.
comparador([],R):-igualdad("No entendi lo que me dijiste. Podrias tratar de decirmelo diferente? o continuamos con otra cosa",R).
comparador([X|_],R):-verbo1erP(Z),miembro(X,Z),igualdad("Que otro sintoma presenta?",R).
comparador([X|_],R):-saludo(Z),miembro(X,Z),igualdad("Buenas en que le puedo ayudar??",R).
comparador([X|_],R):-conjuncion(Z),miembro(X,Z),igualdad("Que otro sintoma presenta?",R).
comparador([X|_],R):-negacion(Z),miembro(X,Z),igualdad("Bueno dime algun sintoma para poder dictaminarte",R).
comparador([X|_],R):-pregunta(Z),miembro(X,Z),igualdad("Aun no tengo los datos suficientes para responder alguna pregunta!",R).
comparador([_|Y],R):-comparador(Y,R).

% Basicamente realiza la misma funcion de comparador solo que responde
% de manera diferente de acuerdo a lo ingresado por el usuario.
% Si se reconoce que se esta haciendo una pregunta se comprueba la
% pregunta y se responde acorde a esta.
comparador2([],_,R):-igualdad("No entendi lo que me dijiste. Podrias tratar de decirmelo diferente? o continuamos con otra cosa",R).
comparador2([X|Y],E,R):-pregunta(Z),miembro(X,Z),comprobar2([X|Y],E,R).
comparador2([X|_],_,R):-verbo1erP(Z),miembro(X,Z),igualdad("Ya tengo los datos necesarios para dictaminarte, me lo puedes preguntar cuando quieras",R).
comparador2([X|_],_,R):-afirmacion(Z),miembro(X,Z),igualdad("Y cual seria la pregunta??",R).
comparador2([X|_],_,R):-negacion(Z),miembro(X,Z),igualdad("Bueno si ya no quieres continuar despidete y damos por concluida la consulta",R).
comparador2([X|_],_,R):-saludo(Z),miembro(X,Z),igualdad("Ehh ok hola! dime en que mas te puedo ayudar??",R).
comparador2([X|_],_,R):-despedida(Z),miembro(X,Z), igualdad("Hasta luego fue un gusto atenderte!! :D",R).
comparador2([_|Y],E,R):-comparador2(Y,E,R).



% Luego de que se reconoce que se esta dando un sintoma se cuemprueba la
% lista de palabras y se concatena lo que este despues de la palabra
% clave hasta que termine el texto o se identifique alguna palabra para
% detenerse y se retornan las palabras del sintoma como un solo string
comprobar([X|Y],Sintoma):-verbo1erP(Z),miembro(X,Z),devolver_sintoma(Y,Sintoma).
comprobar([X|Y],Sintoma):-conjuncion(Z),miembro(X,Z),devolver_sintoma(Y,Sintoma).
comprobar([_|Y],Sintoma):-comprobar(Y,Sintoma).

% Verificamos la lista ingresada palabra por palabra y una ves
% reconocida la palabra clave se concatenan recursivamente en un solo
% string las palabras posteriores de la lista hasta que se vacíe la
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
comprobar2(X,Enfermedad,Resp):-concat_respuesta(X,R),verificar(R,Enfermedad,Resp).
comprobar2([_|Y],Enfermedad,Resp):-comprobar2(Y,Enfermedad,Resp).

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
% es así se retorna la informacion que el usuario requiere.
% Por ejemplo si se verifica que la pregunta esta relacionada con causas
% de la enfermedad, si es una enfermedad que esta registrada se retorna
% las causas y si no lo esta se da una respuesta predeterminada.
verificar(P,E,R):-dictaminar(Z),miembro(P,Z),
    string_concat("Usted presenta los sintomas de: ",E,Dictamen), string_concat(Dictamen,".  Alguna otra pregunta?",R).
verificar(P,E,R):-dar_cuidados(Z),miembro(P,Z),igualdad(E,'Enfermedad desconocida'),igualdad("No se los cuidados de su enfermedad ya que no se encuentra registrada.  Alguna otra pregunta?",R).
verificar(P,E,R):-dar_cuidados(Z),miembro(P,Z),enfermedad(E,_,C,_,_),string_concat(C,".  Alguna otra pregunta?",R).
verificar(P,E,R):-dar_causas(Z),miembro(P,Z),igualdad(E,'Enfermedad desconocida'),igualdad("No se las causas de su enfermedad ya que no se encuentra registrada.  Alguna otra pregunta?",R).
verificar(P,E,R):-dar_causas(Z),miembro(P,Z),enfermedad(E,_,_,C,_),string_concat(C,".  Alguna otra pregunta?",R).
verificar(P,E,R):-dar_prevenciones(Z),miembro(P,Z),igualdad(E,'Enfermedad desconocida'),igualdad("No se como se previene su enfermedad ya que no se encuentra registrada.  Alguna otra pregunta?",R).
verificar(P,E,R):-dar_prevenciones(Z),miembro(P,Z),enfermedad(E,_,_,_,Prev),string_concat(Prev,".  Alguna otra pregunta?",R).



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



% Aqui estan las enfermedades que se encuentran registradas y si se
% agregan nuevas se van agregando de ultimas.
% Son de la forma:
% enfermedad(enfermedad,[sintoma1,sintoma2,sintoma3],cuidados,causas,prevenciones).
enfermedad('sida',['dolordegarganta','cansanciopersistente','inflamacionpelvica'],"Se recomienda tomar el tratamiento antirretroviral (TAR) que es una combinación de medicamentos contra el VIH, vigile su peso corporal","El virus de inmunodeficiencia humana (VIH) es el virus que causa el sida. Cuando una persona se infecta con VIH, el virus ataca y debilita al sistema inmunitario. A medida que el sistema inmunitario se debilita, la persona está en riesgo de contraer infecciones y cánceres que pueden ser mortales","Mantenga sus pantalones arriba o use condon sin enbargo el segundo no es cien por ciento seguro xd").
enfermedad('sarampion',['salpullido','fiebre','tosseca'],"Untece calamina en el salpullido y tome antibiotico durante 4 dias","El sarampión es una enfermedad vírica aguda causada por un paramixovirus del género Morbillivirus","Los padres deben chequear si sus hijos tienen las vacunas del calendario al día. De 12 meses a cuatro años deben acreditar una dosis de vacuna triple viral (sarampión-rubéola-paperas).").
