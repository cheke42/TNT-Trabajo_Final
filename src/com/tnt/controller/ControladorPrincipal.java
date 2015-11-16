package com.tnt.controller;

import java.io.IOException;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.scene.control.Button;
import javafx.scene.control.ListView;
import javafx.scene.control.TextArea;
import javafx.scene.image.ImageView;
import javafx.stage.Stage;

import com.tnt.principal.Principal;

public class ControladorPrincipal {

    @FXML
    private Button btnContraer;

    @FXML
    private ListView<?> listHistorialActividades;

    @FXML
    private ImageView imgExpandir;

    @FXML
    private TextArea txtAreaBaseDeConocimiento;

    @FXML
    private ImageView imgConsolidar;

    @FXML
    private ImageView imgContraer;

    @FXML
    private Button btnRevisar;

    @FXML
    private Button btnConsolidar;

    @FXML
    private ImageView imgBackground;

    @FXML
    private Button btnExpandir;

    @FXML
    private ImageView imgRevisar;

    private Stage escenario;

    private Principal principal;

    public Button getBtnContraer() {
	return btnContraer;
    }

    public ListView<?> getListHistorialActividades() {
	return listHistorialActividades;
    }

    public ImageView getImgExpandir() {
	return imgExpandir;
    }

    public TextArea getTxtAreaBaseDeConocimiento() {
	return txtAreaBaseDeConocimiento;
    }

    public ImageView getImgConsolidar() {
	return imgConsolidar;
    }

    public ImageView getImgContraer() {
	return imgContraer;
    }

    public Button getBtnRevisar() {
	return btnRevisar;
    }

    public Button getBtnConsolidar() {
	return btnConsolidar;
    }

    public ImageView getImgBackground() {
	return imgBackground;
    }

    public Button getBtnExpandir() {
	return btnExpandir;
    }

    public ImageView getImgRevisar() {
	return imgRevisar;
    }

    public void setBtnContraer(Button btnContraer) {
	this.btnContraer = btnContraer;
    }

    public void setListHistorialActividades(ListView<?> listHistorialActividades) {
	this.listHistorialActividades = listHistorialActividades;
    }

    public void setImgExpandir(ImageView imgExpandir) {
	this.imgExpandir = imgExpandir;
    }

    public void setTxtAreaBaseDeConocimiento(TextArea txtAreaBaseDeConocimiento) {
	this.txtAreaBaseDeConocimiento = txtAreaBaseDeConocimiento;
    }

    public void setImgConsolidar(ImageView imgConsolidar) {
	this.imgConsolidar = imgConsolidar;
    }

    public void setImgContraer(ImageView imgContraer) {
	this.imgContraer = imgContraer;
    }

    public void setBtnRevisar(Button btnRevisar) {
	this.btnRevisar = btnRevisar;
    }

    public void setBtnConsolidar(Button btnConsolidar) {
	this.btnConsolidar = btnConsolidar;
    }

    public void setImgBackground(ImageView imgBackground) {
	this.imgBackground = imgBackground;
    }

    public void setBtnExpandir(Button btnExpandir) {
	this.btnExpandir = btnExpandir;
    }

    public void setImgRevisar(ImageView imgRevisar) {
	this.imgRevisar = imgRevisar;
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
    void expandir(ActionEvent event) throws IOException {
	principal.cargarVentanaAgregarCreencia();
    }

}
