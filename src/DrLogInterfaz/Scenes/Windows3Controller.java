package DrLogInterfaz.Scenes;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Alert;
import javafx.scene.control.TextField;

import java.net.URL;
import java.util.ResourceBundle;

public class Windows3Controller implements Initializable{

    String registro="";
    @FXML
    private TextField nombreEnfermedad;
    @FXML
    private TextField sintoma1;
    @FXML
    private TextField sintoma2;
    @FXML
    private TextField sintoma3;

    @FXML
    private void pressButtonGua(ActionEvent e) {


        if(nombreEnfermedad.getText().equals("") || sintoma1.getText().equals("") || sintoma2.getText().equals("") || sintoma3.getText().equals("")){
            Alert alert = new Alert(Alert.AlertType.WARNING);
            alert.setTitle("Mensaje de alerta");
            alert.setHeaderText("CUIDADO");
            alert.setContentText("Debe rellenar todos los campos");
            alert.showAndWait();
        }else {
            registro = nombreEnfermedad.getText() + ": " + sintoma1.getText() + ", " + sintoma2.getText() + ", " + sintoma3.getText();

            Alert alert = new Alert(Alert.AlertType.INFORMATION);
            alert.setTitle("Guardado");
            alert.setHeaderText("Desea guardar esta informacion: ");
            alert.setContentText(registro);
            alert.showAndWait();
            nombreEnfermedad.getScene().getWindow().hide();
        }

}

    @Override
    public void initialize(URL location, ResourceBundle resources) {

    }

}
