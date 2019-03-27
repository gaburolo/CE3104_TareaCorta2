package sample;

import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.Label;
import javafx.scene.control.ScrollPane;
import javafx.scene.layout.Pane;
import javafx.scene.text.Text;
import javafx.stage.Stage;

public class Main extends Application {

    @Override
    public void start(Stage primaryStage) throws Exception{

        Pane root = FXMLLoader.load(getClass().getResource("sample.fxml"));
        Scene scene = new Scene(root,300,200);
        primaryStage.setScene(scene);
        primaryStage.show();


        //ScrollPane root = new ScrollPane();


        //root.setFitToWidth(true);
        //root.setContent(label1);


    }


    public static void main(String[] args) {
        launch(args);
    }
}
