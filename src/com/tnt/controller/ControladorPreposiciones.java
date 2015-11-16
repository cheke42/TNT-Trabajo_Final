package com.tnt.controller;

import javafx.fxml.FXML;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.TextField;
import javafx.stage.Stage;

import com.tnt.enums.RelacionImportancia;

public class ControladorPreposiciones {

    @FXML
    private Button btnAsignacion;

    @FXML
    private Label lblCantCorchetesCerrados;

    @FXML
    private Button btnLimpiar;

    @FXML
    private Button btnCerrarParentesis;

    @FXML
    private Button btnNegacion;

    @FXML
    private Button btnConjuncion;

    @FXML
    private Button btnAbrirParentesis;

    @FXML
    private Label lblCantCorchetesAbierto;

    @FXML
    private Label lblCantParentesisCerrado;

    @FXML
    private TextField fieldPreposiciones;

    @FXML
    private Button btnAceptar;

    @FXML
    private Button btnDiyuncion;

    @FXML
    private Label lblCantParentesisAbierto;

    @FXML
    private Button btnAbrirCorchete;

    private Stage Escenario;

    private RelacionImportancia relImp;

    public Button getBtnAsignacion() {
	return btnAsignacion;
    }

    public Label getLblCantCorchetesCerrados() {
	return lblCantCorchetesCerrados;
    }

    public Button getBtnLimpiar() {
	return btnLimpiar;
    }

    public Button getBtnCerrarParentesis() {
	return btnCerrarParentesis;
    }

    public Button getBtnNegacion() {
	return btnNegacion;
    }

    public Button getBtnConjuncion() {
	return btnConjuncion;
    }

    public Button getBtnAbrirParentesis() {
	return btnAbrirParentesis;
    }

    public Label getLblCantCorchetesAbierto() {
	return lblCantCorchetesAbierto;
    }

    public Label getLblCantParentesisCerrado() {
	return lblCantParentesisCerrado;
    }

    public TextField getFieldPreposiciones() {
	return fieldPreposiciones;
    }

    public Button getBtnAceptar() {
	return btnAceptar;
    }

    public Button getBtnDiyuncion() {
	return btnDiyuncion;
    }

    public Label getLblCantParentesisAbierto() {
	return lblCantParentesisAbierto;
    }

    public Button getBtnAbrirCorchete() {
	return btnAbrirCorchete;
    }

    public void setBtnAsignacion(Button btnAsignacion) {
	this.btnAsignacion = btnAsignacion;
    }

    public void setLblCantCorchetesCerrados(Label lblCantCorchetesCerrados) {
	this.lblCantCorchetesCerrados = lblCantCorchetesCerrados;
    }

    public void setBtnLimpiar(Button btnLimpiar) {
	this.btnLimpiar = btnLimpiar;
    }

    public void setBtnCerrarParentesis(Button btnCerrarParentesis) {
	this.btnCerrarParentesis = btnCerrarParentesis;
    }

    public void setBtnNegacion(Button btnNegacion) {
	this.btnNegacion = btnNegacion;
    }

    public void setBtnConjuncion(Button btnConjuncion) {
	this.btnConjuncion = btnConjuncion;
    }

    public void setBtnAbrirParentesis(Button btnAbrirParentesis) {
	this.btnAbrirParentesis = btnAbrirParentesis;
    }

    public void setLblCantCorchetesAbierto(Label lblCantCorchetesAbierto) {
	this.lblCantCorchetesAbierto = lblCantCorchetesAbierto;
    }

    public void setLblCantParentesisCerrado(Label lblCantParentesisCerrado) {
	this.lblCantParentesisCerrado = lblCantParentesisCerrado;
    }

    public void setFieldPreposiciones(TextField fieldPreposiciones) {
	this.fieldPreposiciones = fieldPreposiciones;
    }

    public void setBtnAceptar(Button btnAceptar) {
	this.btnAceptar = btnAceptar;
    }

    public void setBtnDiyuncion(Button btnDiyuncion) {
	this.btnDiyuncion = btnDiyuncion;
    }

    public void setLblCantParentesisAbierto(Label lblCantParentesisAbierto) {
	this.lblCantParentesisAbierto = lblCantParentesisAbierto;
    }

    public void setBtnAbrirCorchete(Button btnAbrirCorchete) {
	this.btnAbrirCorchete = btnAbrirCorchete;
    }

    public Stage getEscenario() {
	return Escenario;
    }

    public void setEscenario(Stage escenario) {
	Escenario = escenario;
    }

    public RelacionImportancia getRelImp() {
	return relImp;
    }

    public void setRelImp(RelacionImportancia relImp) {
	this.relImp = relImp;
    }

}