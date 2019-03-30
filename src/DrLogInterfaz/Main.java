package DrLogInterfaz;

import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Scene;
import javafx.scene.layout.Pane;
import javafx.stage.Stage;


public class Main extends Application {
    /**
     *
     * @param primaryStage
     * @throws Exception
     */
    @Override
    public void start(Stage primaryStage) throws Exception{

        Pane root = FXMLLoader.load(getClass().getResource("Scenes/window.fxml"));
        Scene scene = new Scene(root,300,200);
        primaryStage.setScene(scene);
        primaryStage.show();



    }

    /**
     *
     * @param args
     */
    public static void main(String[] args) {
        launch(args);
    }
}
