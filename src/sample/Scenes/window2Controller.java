package sample.Scenes;

import com.sun.xml.internal.ws.api.ha.StickyFeature;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.*;
import javafx.scene.text.Text;


import java.io.IOException;
import java.net.URL;
import java.util.ResourceBundle;

public class window2Controller implements Initializable {

    String texto="";

    @FXML
    private ScrollPane scrollPane1;

    @FXML
    private TextField textField1;
    public void pressButtonEnv(ActionEvent event) {
        scrollPane1.setFitToWidth(true);
        if(textField1.getText().equals("")){

        }else{
            texto=texto+"\n"+">"+textField1.getText();
            Text text = new Text(texto);
            text.wrappingWidthProperty().bind(textField1.getScene().widthProperty());
            scrollPane1.setContent(text);


        }

    }

    @Override
    public void initialize(URL location, ResourceBundle resources) {

    }


}
