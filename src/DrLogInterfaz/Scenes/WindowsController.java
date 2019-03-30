package DrLogInterfaz.Scenes;

import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;

import javafx.event.ActionEvent;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.stage.Modality;
import javafx.stage.Stage;

import java.io.IOException;
import java.net.URL;
import java.util.ResourceBundle;
public class WindowsController implements Initializable {


    /**
     * Constructor
     * @throws IOException
     */
    public WindowsController() throws IOException {
    }

    /**
     * Accion al presionar el boton "Consulta"
     * crea una ventana de tipo "windows2"
     * obtiene su fxml
     * da las caracteristicas a la ventana
     * la muestra
     * @param event
     * @throws IOException
     */
    @FXML
    public void pressButtonCon(ActionEvent event) throws IOException {

        Parent root =FXMLLoader.load(getClass().getResource("window2.fxml"));
        Scene scene = new Scene(root);
        Stage stage = new Stage();
        stage.setTitle("Consulta");
        stage.setScene(scene);
        stage.initModality(Modality.APPLICATION_MODAL);
        stage.show();





    }
    /**
     * Accion al presionar el boton "Consulta"
     * crea una ventana de tipo "windows3"
     * obtiene su fxml
     * da las caracteristicas a la ventana
     * la muestra
     * @param event
     * @throws IOException
     */
    @FXML
    private void pressButtoReg(ActionEvent event) throws IOException {
        Parent root2 =FXMLLoader.load(getClass().getResource("window3.fxml"));
        Scene scene2 = new Scene(root2);
        Stage stage2 = new Stage();
        stage2.setTitle("Registro");
        stage2.setScene(scene2);
        stage2.initModality(Modality.APPLICATION_MODAL);
        stage2.show();
    }

    /**
     * Inicializador de la pantalla numero 1
     * Muestra el primer texto en la pantalla
     * @param location la ubicacion de sus fxml
     * @param resources los recursos
     */
    @Override
    public void initialize(URL location, ResourceBundle resources) {

    }


}
