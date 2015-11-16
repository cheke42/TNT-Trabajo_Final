package com.tnt.controller;

import java.io.IOException;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.scene.control.Button;
import javafx.scene.control.ListView;
import javafx.scene.control.TextField;
import javafx.scene.image.ImageView;
import javafx.stage.Stage;

import com.tnt.enums.RelacionImportancia;
import com.tnt.principal.Principal;

public class ControladorAgregarCreencia {

    @FXML
    private Button btnAgregarMasImportante;

    @FXML
    private ListView<String> listTanImportantes;

    @FXML
    private TextField fieldCreencia;

    @FXML
    private Button btnQuitarMasImportante;

    @FXML
    private ListView<String> listMasimportantes;

    @FXML
    private Button btnQuitarTanImportante;

    @FXML
    private Button btnAgregarTanImportante;

    @FXML
    private ImageView imgBackground;

    private Stage escenario;

    private Principal principal;

    public Button getBtnAgregarMasImportante() {
	return btnAgregarMasImportante;
    }

    public ListView<String> getListTanImportantes() {
	return listTanImportantes;
    }

    public TextField getFieldCreencia() {
	return fieldCreencia;
    }

    public Button getBtnQuitarMasImportante() {
	return btnQuitarMasImportante;
    }

    public ListView<String> getListMasimportantes() {
	return listMasimportantes;
    }

    public Button getBtnQuitarTanImportante() {
	return btnQuitarTanImportante;
    }

    public Button getBtnAgregarTanImportante() {
	return btnAgregarTanImportante;
    }

    public ImageView getImgBackground() {
	return imgBackground;
    }

    public void setBtnAgregarMasImportante(Button btnAgregarMasImportante) {
	this.btnAgregarMasImportante = btnAgregarMasImportante;
    }

    public void setListTanImportantes(ListView<String> listTanImportantes) {
	this.listTanImportantes = listTanImportantes;
    }

    public void setFieldCreencia(TextField fieldCreencia) {
	this.fieldCreencia = fieldCreencia;
    }

    public void setBtnQuitarMasImportante(Button btnQuitarMasImportante) {
	this.btnQuitarMasImportante = btnQuitarMasImportante;
    }

    public void setListMasimportantes(ListView<String> listMasimportantes) {
	this.listMasimportantes = listMasimportantes;
    }

    public void setBtnQuitarTanImportante(Button btnQuitarTanImportante) {
	this.btnQuitarTanImportante = btnQuitarTanImportante;
    }

    public void setBtnAgregarTanImportante(Button btnAgregarTanImportante) {
	this.btnAgregarTanImportante = btnAgregarTanImportante;
    }

    public void setImgBackground(ImageView imgBackground) {
	this.imgBackground = imgBackground;
    }

    public Stage getEscenario() {
	return escenario;
    }

    public void setEscenario(Stage escenario) {
	this.escenario = escenario;
    }

    public Principal getPrincipal() {
	return principal;
    }

    public void setPrincipal(Principal principal) {
	this.principal = principal;
    }

    @FXML
    void agregarTanImportante(ActionEvent event) throws IOException {
	principal
		.cargarVentanaAgregarPreposicion(RelacionImportancia.TAN_IMPORTANTE);
    }

    @FXML
    void agregarMasImportante(ActionEvent event) throws IOException {
	principal
		.cargarVentanaAgregarPreposicion(RelacionImportancia.MENOS_IMPORTANTE);
    }

}
