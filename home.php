<HTML>
<HEAD>
<TITLE>Calling SWI-Prolog from PHP (short)</TITLE>
</HEAD>

<H1>Calling SWI-Prolog from PHP (short)</H1>

<? 
  $cmd = "nice -n15 /software/bin/pl -f /home/popx/cgi-bin/test.pl -g test,halt";
?>

<P>
<PRE>
<? 
  system( $cmd );
  echo "\n";

  $output = exec( $cmd );
  echo $output;
  echo "\n";

  exec( $cmd, $output );
  print_r( $output );
  echo "\n";

  $output = shell_exec( $cmd );
  echo $output;
  echo "\n";
?> 
</PRE>
</P>

</BODY>
</HTML>