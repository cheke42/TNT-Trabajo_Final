	<!DOCTYPE html>
	<html>
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<title>Aplicación</title>
			<link rel="shortcut icon" href="favicon.ico">
		<!-- Latest compiled and minified CSS -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">
		<!-- Optional theme -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap-theme.min.css" integrity="sha384-fLW2N01lMqjakBkx3l/M9EahuwpSfeNvV63J5ezn3uZzapT0u7EYsXMjQV+0En5r" crossorigin="anonymous">
	</head>
	<body>
		<?php  
	    	// declaracion de variables para la gestion de las operaciones del usuario
		$operaciones = array();
		$operacionFinal ='';
		?>
		<div class="container">
			<!-- Static navbar -->
			<nav class="navbar navbar-inverse">
				<div class="container-fluid">
					<div class="navbar-header">
						<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
							<span class="sr-only">Toggle navigation</span>
							<span class="icon-bar"></span>
							<span class="icon-bar"></span>
							<span class="icon-bar"></span>
						</button>
						<a class="navbar-brand">Dinámica de conocimiento</a>
					</div>
					<div id="navbar" class="navbar-collapse collapse">
						<ul class="nav navbar-nav">
							<li><a href="index.php">Home</a></li>
							<li class="active"><a href="aplicacion.php">Aplicación</a></li>
							<li><a href="codigoFuente.php">Código Fuente</a></li>
						</ul>
					</div><!--/.nav-collapse -->
				</div><!--/.container-fluid -->
			</nav>
			<div class="container well">
				<h2>Aplicación</h2>
				<br>
				Podrás realizar las operaciones de expandir (agregar una creencia a K), contraer (K en base a una creencia), hacer revisiones (sobre K respecto a una creencia), consolidaciones (devuelve la consistencia de K) y ver tu base de conocimiento en su estado actual por cada operación realizada.
				<br>
				<br>
				<?php	
				///////////////////////////////////////////////////////////
				//**************Expandir**************
				if(isset($_POST["creenciaExpandir"]) && strlen($_POST["creenciaExpandir"]) > 0) {
					 $concimiento = $_POST["creenciaExpandir"];
					if(strlen($_POST["menos"]) == 0){
					$tanImportanteComo = "''";
					}
					else {
					$tanImportanteComo = $_POST["menos"];	
					}
					if(strlen($_POST["mas"]) == 0){
					$menosImportanteQue = "''";
					}
					else {
					$menosImportanteQue = $_POST["mas"];	
					}
					$operacionRecibidaExpandir = $_POST["operacionFinal"];
					//$expandir = "expandirPorPHP(d->a,d,a-o-b->c),expandirPorPHP(b,'',''),expandirPorPHP(a-o-b->c,d,''),expandirPorPHP(a-o-b->c,b,''),expandirPorPHP(d,'',''),expandirPorPHP(d->c,d,'')";
					$expandir = "expandirPorPHP(".$concimiento.",".$tanImportanteComo.",".$menosImportanteQue.")";
					if (strlen($operacionRecibidaExpandir) == 0) {
						$operacionFinal = 'limpiarBC,' . $expandir;
					}
					else
					{
						$operacionFinal = $operacionRecibidaExpandir . ',' . $expandir;
					}
					//operaciones realizadas por el usuario
					$ultimaOperacion = $expandir;
					$operacionDefinitiva = $operacionFinal . ',imprimirPorPHP.';
					$consultaProlog =`swipl -s tnt.pl -g "$operacionDefinitiva" `;				
				} 
				///////////////////////////////////////////////////////////
				//**************Contraer por menos importante**************
				if(isset($_POST["ContraerPMI"]) && strlen($_POST["ContraerPMI"]) > 0) {
					$contraerPMI = $_POST["ContraerPMI"];
					$operacionRecibidaContraccion = $_POST["operacionFinal"];
					$contraccion = "opcionesContraccionPHP(".$contraerPMI."),contraerPorMenosImportantePHP(".$contraerPMI.")";
					if (strlen($operacionRecibidaContraccion) == 0) {
						$operacionFinal = 'limpiarBC,' . $contraccion;
					}
					else
					{
						$operacionFinal = $operacionRecibidaContraccion . ',' . $contraccion;
					}
					//operaciones realizadas por el usuario
					$ultimaOperacion = $contraccion;
					$operacionDefinitiva = $operacionFinal . ',imprimirPorPHP.';
					$consultaProlog =`swipl -s tnt.pl -g "$operacionDefinitiva" `;
				} 	
					//**************Contraer por mantener más importantes**************
				if(isset($_POST["ContraerPMMI"]) && strlen($_POST["ContraerPMMI"]) > 0) {
					$contraerPMMI = $_POST["ContraerPMMI"];
					$operacionRecibidaContraccion = $_POST["operacionFinal"];
					$contraccion = "opcionesContraccionPHP(".$contraerPMMI."),contraerPorMantenerMasImportantesPHP(".$contraerPMMI.")";
					if (strlen($operacionRecibidaContraccion) == 0) {
						$operacionFinal = 'limpiarBC,' . $contraccion;
					}
					else
					{
						$operacionFinal = $operacionRecibidaContraccion . ',' . $contraccion;
					}
					//operaciones realizadas por el usuario
					$ultimaOperacion = $contraccion;
					$operacionDefinitiva = $operacionFinal . ',imprimirPorPHP.';
					$consultaProlog =`swipl -s tnt.pl -g "$operacionDefinitiva" `;
				} 
				//**************Contraer por mínima cantidad**************
				if(isset($_POST["ContraerPMC"]) && strlen($_POST["ContraerPMC"]) > 0) {
					$contraerPMC = $_POST["ContraerPMC"];
					$operacionRecibidaContraccion = $_POST["operacionFinal"];
					$contraccion = "opcionesContraccionPHP(".$contraerPMC."),contraerPorMinimaCantidadPHP(".$contraerPMC.")";
					if (strlen($operacionRecibidaContraccion) == 0) {
						$operacionFinal = 'limpiarBC,' . $contraccion;
					}
					else
					{
						$operacionFinal = $operacionRecibidaContraccion . ',' . $contraccion;
					}
							//operaciones realizadas por el usuario
					$ultimaOperacion = $contraccion;
					$operacionDefinitiva = $operacionFinal . ',imprimirPorPHP.';
					$consultaProlog =`swipl -s tnt.pl -g "$operacionDefinitiva" `;
				} 				
    ///////////////////////////////////////////////////////////
				//**************Contraer por menos importante**************
				if(isset($_POST["RevisarPMI"]) && strlen($_POST["RevisarPMI"]) > 0) {
					$revisarPMI = $_POST["RevisarPMI"];
					$operacionRecibidaRevision = $_POST["operacionFinal"];
					$revision = "opcionesRevisarPHP(".$revisarPMI."),revisarPorMenosImportantePHP(".$revisarPMI.")";
					if (strlen($operacionRecibidaRevision) == 0) {
						$operacionFinal = 'limpiarBC,' . $revision;
					}
					else
					{
						$operacionFinal = $operacionRecibidaRevision . ',' . $revision;
					}
							//operaciones realizadas por el usuario
					$ultimaOperacion = $revision;
					$operacionDefinitiva = $operacionFinal . ',imprimirPorPHP.';
					$consultaProlog =`swipl -s tnt.pl -g "$operacionDefinitiva" `;
				} 	
					//**************Contraer por mantener más importantes**************
				if(isset($_POST["RevisarPMMI"]) && strlen($_POST["RevisarPMMI"]) > 0) {
					$revisarPMMI = $_POST["RevisarPMMI"];
					$operacionRecibidaRevision = $_POST["operacionFinal"];
					$revision = "opcionesRevisarPHP(".$revisarPMMI."),revisarPorMantenerMasImportantesPHP(".$revisarPMMI.")";
					if (strlen($operacionRecibidaRevision) == 0) {
						$operacionFinal = 'limpiarBC,' . $revision;
					}
					else
					{
						$operacionFinal = $operacionRecibidaRevision . ',' . $revision;
					}
							//operaciones realizadas por el usuario
					$ultimaOperacion = $revision;
					$operacionDefinitiva = $operacionFinal . ',imprimirPorPHP.';
					$consultaProlog =`swipl -s tnt.pl -g "$operacionDefinitiva" `;
				} 
					//**************Contraer por mínima cantidad**************
				if(isset($_POST["RevisarPMC"]) && strlen($_POST["RevisarPMC"]) > 0) {
					$revisarPMC = $_POST["RevisarPMC"];
					$operacionRecibidaRevision = $_POST["operacionFinal"];
					$revision = "opcionesRevisarPHP(".$revisarPMC."),revisarPorMinimaCantidadPHP(".$revisarPMC.")";
					if (strlen($operacionRecibidaRevision) == 0) {
						$operacionFinal = 'limpiarBC,' . $revision;
					}
					else
					{
						$operacionFinal = $operacionRecibidaRevision . ',' . $revision;
					}
							//operaciones realizadas por el usuario
					$ultimaOperacion = $revision;
					$operacionDefinitiva = $operacionFinal . ',imprimirPorPHP.';
					$consultaProlog =`swipl -s tnt.pl -g "$operacionDefinitiva" `;
				} 	
				///////////////////////////////////////////////////////////
				//**************Consolidar por menos importante**************
				if(isset($_POST["cbxConsolidar"]) && strlen($_POST["cbxConsolidar"]) != "0") {

					$operacionRecibidaRevision = $_POST["operacionFinal"];

					switch ($_POST["cbxConsolidar"]) {
    		case "1":
       $consolidar = "opcionesConsolidarPHP,consolidarPorMinimaCantidadPHP";    		
      break;
    		case "2":
      	$consolidar = "opcionesConsolidarPHP,consolidarPorMenosImportantePHP";    		
      break;
    		case "3":
							$consolidar = "opcionesConsolidarPHP,consolidarPorMantenerMasImportantesPHP";
      break;
					}
					if (strlen($operacionRecibidaRevision) == 0) {
						$operacionFinal = 'limpiarBC,' . $consolidar;
					}
					else
					{
						$operacionFinal = $operacionRecibidaRevision . ',' . $consolidar;
					}
							//operaciones realizadas por el usuario
					$operacion = $consolidar;
					$ultimaOperacion = $consolidar;
					$operacionDefinitiva = $operacionFinal . ',imprimirPorPHP.';
					$consultaProlog =`swipl -s tnt.pl -g "$operacionDefinitiva" `;
				} 	
				if(isset($consultaProlog)!= "") { 
					echo("<div class='panel panel-success'>");
					echo("<div class='panel-heading'> ");
					echo("<h3 class='panel-title'>Estado actual de la Base de Conocimiento</h3> ");
					echo("</div> ");
					echo("<div class='panel-body'>");
					echo("Última operación: " . $ultimaOperacion ."."); 
					echo("<br><br>");
					echo ($consultaProlog);
					echo("</div>");
					echo("</div>");
				}
				?>				
				<!--Expandir -->
				<div class="panel panel-primary"> 
					<div class="panel-heading"> 
						<h3 class="panel-title">Expandir</h3> 
					</div> 
					<div class="panel-body">
						<form id="formulario" action="aplicacion.php" method="post">
							<fieldset>
								<div class="form-group">
									<label for="creenciaExpandir">Creencia:</label>
									<input type="text" class="form-control" name="creenciaExpandir" id="creenciaExpandir">
									<label for="menos">Relación de importancia a lo sumo tan importante:</label>
									<input type="text" class="form-control" name="menos" id="menos">
									<label for="mas">Relación de importancia mas importante que:</label>
									<input type="text" class="form-control" name="mas" id="mas">
									<input type="hidden" class="form-control" name="operacionFinal" id="operacionFinal" value="<?php echo($operacionFinal);?>"/>
									<br>
									<input class="btn btn-default" id="btnExpandir" name="enviar" type="submit" value="Expandir" />
								</div>
							</fieldset>
						</form>
					</div>		
				</div> 
				<!--Contraer -->
			<div class="panel panel-primary"> 
				<div class="panel-heading"> 
					<h3 class="panel-title">Contraer</h3> 
				</div> 
				<div class="panel-body">
					<form id="formulario" action="aplicacion.php" method="post">
						<fieldset>
							<div class="form-group">
								<label for="ContraerPMI">Por menos importante:</label>
								<input type="text" class="form-control" name="ContraerPMI" id="ContraerPMI">
 							<br>
								<label for="ContraerPMMI">Por mantener más importantes:</label>
								<input type="text" class="form-control" name="ContraerPMMI" id="ContraerPMMI">
								<br>
								<label for="ContraerPMC">Por mínima cantidad:</label>
								<input type="text" class="form-control" name="ContraerPMC" id="ContraerPMC">
								<input type="hidden" class="form-control" name="operacionFinal" id="operacionFinal" value="<?php echo($operacionFinal);?>"/>
								<br>
								<button class="btn btn-default" id="btnContraerPMC" name="enviar 3" type="submit">Contraer</button>		
								</div>
							</fieldset>
						</form>
					</div>
				</div>
				<!--Revisar-->
				<div class="panel panel-primary"> 
					<div class="panel-heading"> 
						<h3 class="panel-title">Revisar</h3> 
					</div> 
					<div class="panel-body">
						<form id="formulario" action="aplicacion.php" method="post">
							<fieldset>
								<div class="form-group">
									<label for="RevisarPMI">Por menos importante:</label>
									<input type="text" class="form-control" name="RevisarPMI" id="RevisarPMI">
									<label for="RevisarPMMI">Por mantener más importantes:</label>
									<input type="text" class="form-control" name="RevisarPMMI" id="RevisarPMMI">
									<label for="RevisarPMC">Por mínima cantidad:</label>
									<input type="text" class="form-control" name="RevisarPMC" id="RevisarPMC">
									<br>
									<input class="btn btn-default" id="btnExpandir" name="enviar" type="submit" value="Revisar" />
									<input type="hidden" class="form-control" name="operacionFinal" id="operacionFinal" value="<?php echo($operacionFinal);?>"/>
								</div>
							</fieldset>
						</form>
					</div>
				</div>
				<!--Consolidar-->
				<div class="panel panel-primary"> 
					<div class="panel-heading"> 
						<h3 class="panel-title">Consolidar</h3> 
					</div> 
					<div class="panel-body">
						<form id="formulario" action="aplicacion.php" method="post">
							<fieldset>
								<div class="form-group">
									<div class="btn-group">
									<select name="cbxConsolidar" class="form-control">
										<option value="0">Seleccionar</option>
										<option value="1">Por mínima cantidad</option>
										<option value="2">Por menos importante</option>
										<option value="3">Por mantener mas importantes</option>
									</select>
									</div> 
									<input class="btn btn-default" id="btnConsolidar" name="enviar" type="submit" value="Consolidar" />				  					
									<input type="hidden" class="form-control" name="operacionFinal" id="operacionFinal" value="<?php echo($operacionFinal);?>"/>
								</div>
							</fieldset>
						</form>
					</div>
				</div>				
			</div>
		</div>
 <div class="panel-footer clearfix">
  <div align="center"> 
    <p>COBO MEDVEDSKY, Elias Daniel - LIGORRIA, Alexis Enrique - SUAZO, Leonardo Ezequiel</p>
    <p>UNPSJB - Facultad de Ingeniería - Departamento de Informática - Taller de Nuevas Tecnologías</p>
  </div>
 </div>		
		<!-- Latest compiled and minified JavaScript -->
		<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
		<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>
		<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
	</body>
	</html>