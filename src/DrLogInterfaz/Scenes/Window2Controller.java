package DrLogInterfaz.Scenes;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.*;
import javafx.scene.text.Text;
import DrLogInterfaz.Prolog;


import java.net.URL;
import java.util.ResourceBundle;

public class Window2Controller implements Initializable {


    /**
     * Atributos de window2
     */
    private String texto="";
    private Prolog prolog = new Prolog();
    private Text text = new Text(texto);
    @FXML
    public ScrollPane scrollPane1;
    @FXML
    private TextField textField1;

    /**
     * Accion tealizada por el boton "Enviar"
     * este toma el texto ingresado en el textField1
     * comprueba si no esta vacio
     * lo envia a la clase prolog y lo muestra en pantalla
     * @param event
     */
    public void pressButtonEnv(ActionEvent event) {
        scrollPane1.setFitToWidth(true);
        if(textField1.getText().equals("")){

        }else{


            texto=text.getText()+"\n"+"(Paciente): "+textField1.getText();
            text.setText(texto);

            text.wrappingWidthProperty().bind(textField1.getScene().widthProperty());
            scrollPane1.setContent(text);
            prolog.mensaje(textField1.getText(), scrollPane1, texto, text);
            textField1.setText("");

        }

    }
    /**
     * Inicializador de la pantalla numero 2
     * Muestra el primer texto en la pantalla
     * @param location la ubicacion de sus fxml
     * @param resources los recursos
     */

    @Override
    public void initialize(URL location, ResourceBundle resources) {


        text.setText("Bienvenido a su consulta medica proceda a hablar con DrLog");
        scrollPane1.setContent(text);
    }


}
