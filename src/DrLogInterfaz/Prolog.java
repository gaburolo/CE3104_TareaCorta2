package DrLogInterfaz;

import javafx.scene.text.Text;
import org.jpl7.Query;

import javafx.scene.control.*;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.ArrayList;

public class Prolog {
    private ArrayList<String> sintomas=new ArrayList<String>();;

    BufferedReader entrada = new BufferedReader(new InputStreamReader(System.in));
    String enfermedad;
    String conexion="consult('DrLog_Java.pl')";
    boolean bandera=true;

    public Prolog(){
        System.out.println("Bienvenido a su consulta medica proceda a hablar con DrLog");
        Query Consul_Prolog = new Query(conexion);
        if(Consul_Prolog.hasSolution()){
            System.out.println("Exito");
        }else{
            System.out.println("FAIL");
        }

    }


    public void mensaje(String ingreso,ScrollPane scrollPane,String texto,Text text){

        if(sintomas.size()!=3){
            String consulta="consulta("+"\""+ingreso+"\""+",X)";
            Query rpta001=new Query(consulta);

            String salida = rpta001.oneSolution().get("X").toString().substring(1, rpta001.oneSolution().get("X").toString().length() - 1).toString();
            if(sintomas.size()!=2){

                texto=text.getText()+"\n"+"(DrLog): "+salida;
                text.setText(texto);
                scrollPane.setContent(text);

            }

            System.out.println("salida"+salida);
            //Window2Controller.scrollPane1.setContent(text);
            String verificar="verificar_pregunta("+"\""+salida+"\""+","+"\""+ingreso+"\""+",X)";


            Query rpta002=new Query(verificar);

            String salida2 = rpta002.oneSolution().get("X").toString();

            System.out.println("salida2"+salida2);
            if('1'!= salida2.charAt(1) ){
                sintomas.add(salida2);
                System.out.println(sintomas);
            }else{
                System.out.println("no es un sintoma");

            }
        }

        if(sintomas.size()==3 && bandera ){
            texto=text.getText()+"\n"+"(DrLog): "+"Correcto, ya tengo los sintomas suficientes, preguntame tu dictamen cuando quieras";
            text.setText(texto);
            scrollPane.setContent(text);
            System.out.println("Correcto, ya tengo los sintomas suficientes, preguntame tu dictamen cuando quieras");

            String verificar_enfermedad="verificar_enfermedad(X,"+"\""+sintomas.get(0)+"\""+","+"\""+sintomas.get(1)+"\""+","+"\""+sintomas.get(2)+"\""+")";
            System.out.println(verificar_enfermedad);
            Query respuesta3=new Query(verificar_enfermedad);

            enfermedad=respuesta3.oneSolution().get("X").toString();
            System.out.println("enfermedad"+enfermedad);
            bandera=false;
        }else if(sintomas.size()==3 && bandera==false){

            mensaje2(ingreso,scrollPane,texto,text);
        }

    }
    private void mensaje2(String mensaje,ScrollPane scrollPane,String texto,Text text){
        String consulta2="consulta2(\""+mensaje+"\",\""+enfermedad+"\",X)";
        System.out.println(consulta2);
        Query respuesta4=new Query(consulta2);
        texto=text.getText()+"\n"+"(DrLog): "+respuesta4.oneSolution().get("X").toString();
        text.setText(texto);
        scrollPane.setContent(text);
        System.out.println(respuesta4.oneSolution().get("X").toString());

    }
}
