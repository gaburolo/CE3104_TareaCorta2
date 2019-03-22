package sample;

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
public class Controller implements Initializable {



    public Controller() throws IOException {
    }


    @FXML
    public void pressButtonCon(ActionEvent event) throws IOException {

        Parent root =FXMLLoader.load(getClass().getResource("Scenes/window2.fxml"));
        Scene scene = new Scene(root);
        Stage stage = new Stage();
        stage.setTitle("Consulta");
        stage.setScene(scene);
        stage.initModality(Modality.APPLICATION_MODAL);
        stage.show();





    }

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

    @Override
    public void initialize(URL location, ResourceBundle resources) {

    }


}
