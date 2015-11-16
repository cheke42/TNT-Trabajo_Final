package com.tnt.principal;

import java.io.IOException;

import javafx.application.Application;
import javafx.event.EventHandler;
import javafx.fxml.FXMLLoader;
import javafx.scene.Scene;
import javafx.scene.control.Tooltip;
import javafx.scene.image.Image;
import javafx.scene.layout.AnchorPane;
import javafx.stage.Modality;
import javafx.stage.Stage;
import javafx.stage.WindowEvent;

import com.tnt.controller.ControladorAgregarCreencia;
import com.tnt.controller.ControladorPreposiciones;
import com.tnt.controller.ControladorPrincipal;
import com.tnt.enums.RelacionImportancia;
import com.tnt.util.Utilidades;

public class Principal extends Application {

    private Stage primaryStage;
    private AnchorPane layoutPrincipal;

    public static void main(String[] args) {
	launch(args);

    }

    @Override
    public void start(Stage primaryStage) throws Exception {
	this.primaryStage = primaryStage;
	primaryStage.setResizable(false);
	primaryStage.sizeToScene();
	cargarVentanaPrincipal();
	primaryStage.setOnHiding(new EventHandler<WindowEvent>() {

	    public void handle(WindowEvent event) {
		// post cerrar ventana
	    }
	});

    }

    private void cargarVentanaPrincipal() throws IOException {
	FXMLLoader loader = new FXMLLoader();
	loader.setLocation(Utilidades.restToURL("/com/tnt/view/principal.fxml"));
	layoutPrincipal = loader.load();
	Scene escena = new Scene(layoutPrincipal);
	primaryStage.setScene(escena);
	primaryStage.setResizable(false);
	primaryStage.sizeToScene();
	primaryStage.setTitle("Dinámica de Conocimiento - Cambio de creencias");
	ControladorPrincipal controladorPrincipal = loader.getController();
	controladorPrincipal.setEscenario(primaryStage);
	controladorPrincipal.setPrincipal(this);
	controladorPrincipal.getImgExpandir().setImage(new Image("file:recursos/imagenes/agregar.png"));
	controladorPrincipal.getBtnExpandir().setTooltip(new Tooltip("Agregar creencia"));
	controladorPrincipal.getBtnConsolidar().setTooltip(new Tooltip("Consolidar"));
	controladorPrincipal.getBtnContraer().setTooltip(new Tooltip("Contraer"));
	controladorPrincipal.getBtnRevisar().setTooltip(new Tooltip("Revisar"));
	primaryStage.getIcons().add(new Image("file:recursos/imagenes/logo.png"));
	// controladorPrincipal.getImagenLogo().setImage(this.imagenLogo);
	// controladorPrincipal.setPrincipal(this);
	// controladorPrincipal.getFieldUsuario().focusedProperty();
	primaryStage.show();

    }

    public void cargarVentanaAgregarCreencia() throws IOException {

	FXMLLoader loader = new FXMLLoader();
	loader.setLocation(Utilidades
		.restToURL("/com/tnt/view/agregarCreencia.fxml"));
	AnchorPane anchoUsuarios = (AnchorPane) loader.load();
	Stage escenarioAgregarCreencia = new Stage();
	escenarioAgregarCreencia.setResizable(false);
	escenarioAgregarCreencia.getIcons().add(new Image("file:recursos/imagenes/addPreposicion.png"));
	escenarioAgregarCreencia.sizeToScene();
	escenarioAgregarCreencia.setTitle("Agregar Preposición");
	// escenarioAgregarCreencia.getIcons().add(new
	// Image("file:recursos/imagenes/imagen.png"));
	escenarioAgregarCreencia.initModality(Modality.WINDOW_MODAL);
	escenarioAgregarCreencia.initOwner(primaryStage);
	Scene escena = new Scene(anchoUsuarios);
	escenarioAgregarCreencia.setScene(escena);
	ControladorAgregarCreencia controladorAgregarCreencia = loader
		.getController();
	controladorAgregarCreencia.setEscenario(escenarioAgregarCreencia);
	controladorAgregarCreencia.setPrincipal(this);
	escenarioAgregarCreencia.showAndWait();
    }

    public void cargarVentanaAgregarPreposicion(RelacionImportancia relImp)
	    throws IOException {

	FXMLLoader loader = new FXMLLoader();
	loader.setLocation(Utilidades
		.restToURL("/com/tnt/view/preposiciones.fxml"));
	AnchorPane anchoUsuarios = (AnchorPane) loader.load();
	Stage escenarioAgregarPreposicion = new Stage();
	escenarioAgregarPreposicion.getIcons().add(new Image("file:recursos/imagenes/preposicion.png"));
	escenarioAgregarPreposicion.setResizable(false);
	escenarioAgregarPreposicion.sizeToScene();
	escenarioAgregarPreposicion.setTitle("Preposición");
	// escenarioAgregarCreencia.getIcons().add(new
	// Image("file:recursos/imagenes/imagen.png"));
	escenarioAgregarPreposicion.initModality(Modality.WINDOW_MODAL);
	escenarioAgregarPreposicion.initOwner(primaryStage);
	Scene escena = new Scene(anchoUsuarios);
	escenarioAgregarPreposicion.setScene(escena);
	ControladorPreposiciones controladorPreposicion = loader
		.getController();
	controladorPreposicion.setRelImp(relImp);
	controladorPreposicion.setEscenario(escenarioAgregarPreposicion);
	escenarioAgregarPreposicion.showAndWait();
    }

}
