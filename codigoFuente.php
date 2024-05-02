<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title>Código Fuente</title>
	<link rel="shortcut icon" href="favicon.ico">
	<!-- Latest compiled and minified CSS -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">
	<!-- Optional theme -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap-theme.min.css" integrity="sha384-fLW2N01lMqjakBkx3l/M9EahuwpSfeNvV63J5ezn3uZzapT0u7EYsXMjQV+0En5r" crossorigin="anonymous">
	<!-- Include required JS files -->
	<script type="text/javascript" src="http://alexgorbatchev.com/pub/sh/current/scripts/shCore.js"></script>
	<!--    At least one brush, here we choose JS. You need to include a brush for every language you want to highlight-->
	<script type="text/javascript" src="http://alexgorbatchev.com/pub/sh/current/scripts/shBrushBash.js"></script>
	<script type="text/javascript" src="http://alexgorbatchev.com/pub/sh/current/scripts/shBrushJScript.js"></script>
	<script type="text/javascript" src="http://alexgorbatchev.com/pub/sh/current/scripts/shBrushCpp.js"></script>
	<script type="text/javascript" src="http://alexgorbatchev.com/pub/sh/current/scripts/shBrushPython.js"></script>
	<script type="text/javascript" src="http://dl.dropbox.com/u/84194941/SyntaxHighlighter/shBrushSWIProlog.js"></script>
	<!-- Include *at least* the core style and default theme -->
	<link href="http://alexgorbatchev.com/pub/sh/current/styles/shCore.css" rel="stylesheet" type="text/css" />
	<link href="http://alexgorbatchev.com/pub/sh/current/styles/shThemeDefault.css" rel="stylesheet" type="text/css" />
	<!-- Finally, to actually run the highlighter, you need to include this JS on your page -->
	<script type="text/javascript">
	SyntaxHighlighter.config.bloggerMode = true;
	SyntaxHighlighter.defaults['tab-size'] = 4;
	SyntaxHighlighter.all()
	</script>	
</head>
<body>
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
						<li><a href="aplicacion.php">Aplicación</a></li>
						<li class="active"><a href="codigoFuente.php">Código Fuente</a></li>
					</ul>
				</div><!--/.nav-collapse -->
			</div><!--/.container-fluid -->
		</nav>
		<div class="container well">
			<h2>Código fuente</h2>
			<br>
			<br>
			<br>
			<div class="panel panel-primary"> 
				<div class="panel-heading"> <h3 class="panel-title">Prolog</h3> 
				</div> <div class="panel-body">
				<pre class="brush: swipl">
					<?php include("tnt.pl");?>
				</pre>
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




