package sample.Scenes;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Label;
import javafx.scene.control.TextField;


import java.io.IOException;
import java.net.URL;
import java.util.ResourceBundle;

public class window2Controller implements Initializable {
    @FXML
    private Label label1;
    String texto="";
    @FXML
    private TextField textField1;
    public void pressButtonEnv(ActionEvent event) {
        texto=texto+"\n"+textField1.getText();
        label1.setText(texto);
    }

    @Override
    public void initialize(URL location, ResourceBundle resources) {

    }


}
