<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>CV</title>
<!--[if IE 7]>
<link href="css/ie7.css" rel="stylesheet" type="text/css" />
<![endif]-->
<!--[if IE 6]>
<link href="css/ie6.css" rel="stylesheet" type="text/css" />
<![endif]-->
<script type="text/javascript" src="../../js/cv/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="../../js/cv/scrollTo.js"></script>
<script type="text/javascript" src="../../js/cv/custom.js"></script>


</head>
<body>
<!-- Begin Social -->
					<div class="social">
						<ul>
							<li><g:link class="show" action="showCV" id="${curriculumVitaeInstance?.id}"><img
									src="../../images/cv/icn-save.jpg" title="Télécharger le CV" /></g:link></li>
							<li><a class='north' href="javascript:window.print()"
								title="Print"><img src="../../images/cv/icn-print.jpg" alt="" /></a></li>
						</ul>
					</div>
					<!-- End Social -->
<g:render template="cv" />
<div id="message">
	<a href="#top" id="top-link">Go to Top</a>
</div>
</body>