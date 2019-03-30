package DrLogInterfaz.Scenes;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Alert;
import javafx.scene.control.TextField;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStreamWriter;
import java.net.URL;
import java.util.ResourceBundle;

public class Windows3Controller implements Initializable{


    /**
     * Atributos de window3
     */
    private String ruta = "C:/Users/gaburolo/IdeaProjects/proyecto_intefaz/DrLog_Java.pl";
    private String ruta2= "C:/Users/gaburolo/IdeaProjects/proyecto_intefaz/DrLog.pl";
    private String registro;


    @FXML
    private TextField nombreEnfermedad;
    @FXML
    private TextField sintoma1;
    @FXML
    private TextField sintoma2;
    @FXML
    private TextField sintoma3;
    @FXML
    private TextField cuidado;
    @FXML
    private TextField causa;
    @FXML
    private TextField prevenciones;
    @FXML

    /**
     * Accion al presionar el boton guardar en la ventana 3
     * Este comprueba que los sintomas y el nombre del a enfermedad esten llenos
     * Guarda en el archivo prolog la nueva enfemerdad con cada una de sus caracteristicas
     */
    private void pressButtonGua(ActionEvent e) {


        if(nombreEnfermedad.getText().equals("") || sintoma1.getText().equals("") || sintoma2.getText().equals("") || sintoma3.getText().equals("")){
            Alert alert = new Alert(Alert.AlertType.WARNING);
            alert.setTitle("Mensaje de alerta");
            alert.setHeaderText("CUIDADO");
            alert.setContentText("Debe rellenar todos los campos");
            alert.showAndWait();
        }else {


            File archivo = new File(ruta);
            File archivo2 = new File(ruta2);

            String enfermedad="enfermedad('"+nombreEnfermedad.getText()+"',['"+sintoma1.getText().replace(" ","")+"','"+sintoma2.getText().replace(" ","")+"','"+sintoma3.getText().replace(" ","")+"'],"+"\""+cuidado.getText()+"\""+","+"\""+causa.getText()+"\""+",\""+prevenciones.getText()+"\").";
            String enfermedad2="enfermedad("+"\""+nombreEnfermedad.getText()+"\""+",["+"\""+sintoma1.getText().replace(" ","")+"\""+","+"\""+sintoma2.getText().replace(" ","")+"\""+","+"\""+sintoma3.getText().replace(" ","")+"\""+"],"+"\""+cuidado.getText()+"\""+","+"\""+causa.getText()+"\",\""+prevenciones.getText()+"\").";
            try {

                if(!archivo.exists()){
                    archivo.createNewFile();
                    archivo2.createNewFile();
                }

                BufferedWriter Fescribe=new BufferedWriter(new OutputStreamWriter(new FileOutputStream(archivo,true), "utf-8"));
                BufferedWriter Fescribe2=new BufferedWriter(new OutputStreamWriter(new FileOutputStream(archivo2,true), "utf-8"));
                Fescribe.write(enfermedad + "\r\n");
                Fescribe2.write(enfermedad2+"\r\n");
                System.out.println(enfermedad);
                Fescribe2.close();
                Fescribe.close();
            } catch (Exception ex) {
                System.out.println(ex.getMessage());
            }



            registro = nombreEnfermedad.getText() + ": " + sintoma1.getText() + ", " + sintoma2.getText() + ", " + sintoma3.getText();

            Alert alert = new Alert(Alert.AlertType.INFORMATION);
            alert.setTitle("Guardado");
            alert.setHeaderText("Desea guardar esta informacion: ");
            alert.setContentText(registro);
            alert.showAndWait();
            nombreEnfermedad.getScene().getWindow().hide();
        }

}

    /**
     * Inicializador de la pantalla numero 3
     * @param location la ubicacion de sus fxml
     * @param resources los recursos
     */
    @Override
    public void initialize(URL location, ResourceBundle resources) {

    }

}
