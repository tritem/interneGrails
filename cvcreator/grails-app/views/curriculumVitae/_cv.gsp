<%--<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">--%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>CV ${curriculumVitaeInstance.employe.prenom} ${curriculumVitaeInstance.employe.nom}</title>
<!--[if IE 7]>
<link href="css/ie7.css" rel="stylesheet" type="text/css" />
<![endif]-->
<!--[if IE 6]>
<link href="css/ie6.css" rel="stylesheet" type="text/css" />
<![endif]-->
<%--<link rel="stylesheet" href="${resource(dir: 'css', file: 'cv.css')}"--%>
<%--	type="text/css"/>--%>
<style text="css">
#cv {
	font-family: "Trebuchet MS", Helvetica, sans-serif;
	background-color: #e1e0db;
	background-image: url(../../images/cv/bg.jpg);
	background-repeat: repeat;
	font-size:13px;
	line-height: 17px;
	color:#000;
}

.contact {
	background-image: none;
	background-color:#e9e9e9;
}

a, a:visited, a:active {
	color:#FABD17;
	text-decoration: none;
}

a:hover {
	color:#FABD17;
	text-decoration: underline;
}

/* DOSSIER BACKGROUND */
/* ----------------------------------------- */

#wrapper {
	width:969px;
	margin:0 auto;
	margin-bottom:10px;
}

.wrapper-top {
	width:969px;
	height:19px;
	margin:0 auto;
	background-image:url(../../images/cv/btop.jpg);
	background-repeat:no-repeat;
}

.wrapper-mid {
	width:969px;
	margin:0 auto;
	background-image:url(../../images/cv/bmid.jpg);
	background-repeat: repeat-y;
	padding-bottom:40px;
}

.wrapper-bottom {
	width:969px;
	height:22px;
	padding:0;
	margin:0 auto;
	background-image:url(../../images/cv/bbottom.jpg);
	background-repeat:no-repeat;
}

/* PAPER BACKGROUND */
/* ----------------------------------------- */

#paper {
	width:828px;
	margin:0 auto;
}

.paper-top {
	width:828px;
	margin:0 auto;
	background-image:url(../../images/cv/ptop.jpg);
	background-repeat:no-repeat;
	height:126px;
}

#paper-mid {
	width:828px;
	margin:0 auto;
	background-image:url(../../images/cv/pmid.jpg);
	background-repeat:repeat-y;
	display:block;
	padding:0;
	overflow: hidden;
	padding-bottom:75px;
	padding-top:7px;
}

.paper-bottom {
	width:828px;
	height:18px;
	margin:0 auto;
	background-image:url(../../images/cv/pbottom.jpg);
	background-repeat:no-repeat;
}

/* ENTRIES */
/* ----------------------------------------- */

.entry {
	width:720px;
	display: block;
	padding-top:35px;
	clear: both;
	margin-left:4px;
}

h1  {
	width:400px;
	font-size:42px;
	color:#373737;
	margin-bottom:15px;
	clear:both;
}

h1 span {
	font-size:21px;
	display:block;
	color:#373737;
/* 	margin-top:-5px; */
}

h2 {
	width:180px;
	height: 23px;
	text-align: right;
	float:left;
	padding:0;
	margin:0;
	clear:both;
	font-size:22px;
	color:#373737;
	margin-bottom:0px;
}

p {
	width:500px;
	margin-left:40px;
	float:right;	
}

p img {
	float:right;
	margin-left:20px;
	padding-left:10px;
}

div.content {
	clear: both;
	padding:0;
	margin:0;
	overflow: hidden;
	display:block;
	padding-top:5px;
}

h3 {
	width:180px;
	text-align: right;
	float:left;
	padding:0;
	clear:both;
	font-size: 13px;
	color:#FABD17;
}

h4 {
	width:180px;
	text-align: right;
	float:left;
	padding:0;
	clear:both;
	font-size: 11px;
	color:#FABD17;
}

h5 {
	width:180px;
	text-align: right;
	float:left;
	padding:0;
	clear:both;
	font-size: 10px;
	color:#FABD17;
}

h6 {
	width:180px;
	text-align: right;
	float:left;
	padding:0;
	clear:both;
	font-size: 9px;
	color:#FABD17;
}

em {
	font-family: Georgia, "Times New Roman", serif;
	font-style: italic;
	color:#777777;
	font-size:12px;
	display: block;
	padding-top:3px;
}


ol {
	float:right;
	width:500px;
	margin-left:40px;
	list-style: decimal;
	
}

ol li {
	width:500px;
	list-style-type: decimal;
	list-style-position: inside;
}

dl {
	float:right;
	width:500px;
	margin-left:40px;
	
}

dt {
	float:left;
	display: block;
	width:500px;
		color:#FABD17;
}

dd {
	float:left;
	display: block;
	width:480px;
	text-indent:20px;
}

ul.unordered {
	float:right;
	width:500px;
	margin-left:40px;
	
}

ul.unordered li {
	margin:0;
	padding:0;
	float:left;
	display: block;
	width:500px;
	background-image:url(../../images/cv/bullet.gif);
	background-repeat: no-repeat;
	padding-left:10px;
	background-position: 0 .5em;
	margin-top:0;
}

ul.info {
	float:right;
	width:510px;
	margin-left:40px;
	list-style-type: none; 
}

ul.info li {
	margin:0;
	padding:0;
	float:left;
	display: block;
	width:500px;
	background-image:url(../../images/cv/bullet.gif);
	background-repeat: no-repeat;
	padding-left:10px;
	background-position: 0 .5em;
	margin-top:7px;
	text-align:justify;
}

ul.skills {
	margin:0;
	padding:0;
	float:right;
	width:500px;
	margin-left:40px;
	margin-top:2px;
	list-style-type: none;
	
}

ul.skills li {
	margin:0;
	padding:0;
	float:left;
	width:156px;
	background-image:url(../../images/cv/bullet.gif);
	background-repeat: no-repeat;
	padding-left:10px;
	background-position: 0 .5em;
	margin-top:0px;
}

ul.works {
	margin:0;
	padding:0;
	float:right;
	width:500px;
	margin-left:40px;
	list-style-type: none;
}

ul.works li {
	margin:0;
	padding:0;
	float:left;
}

ul.works li img {
	padding:4px;
	background-color:#fff;
	width:95px;
	height:95px;
	border:1px solid #bdc7da;
	margin-right:20px;
	margin-bottom:16px;
}

ul.works li img:hover {
	border:1px solid #373737;
	cursor: pointer;
}

img.portrait {
	background-image:url(../../images/cv/frame.jpg);
	background-repeat: no-repeat;
	width:109px;
	height:135px;
	padding-top:20px;
	padding-left:11px;
	padding-right:11px;
	padding-bottom:36px;
	margin-left:50px;
	float:left;
	
}


/* SELF INFORMATION */
/* ----------------------------------------- */

.self {
	width:400px;
	float:left;
	padding-top:11px;
	margin-left:38px;
	margin-bottom:15px;
}

.self ul {
	padding-top: 10px;
}

.self ul li.ad {
	background-image:url(../../images/cv/icn-ad.gif);
}

.self ul li.mail {
	background-image:url(../../images/cv/icn-mail.gif);
}

.self ul li.tel {
	background-image:url(../../images/cv/icn-tel.gif);
}

.self ul li.web {
	background-image:url(../../images/cv/icn-web.gif);
}

.self ul li {
	background-repeat: no-repeat;
	padding-left:26px;
	background-position: 0 .1em;
	height:25px;
	display:block;
	margin-top:-2px;
}

/* SOCIAL ICONS */
/* ----------------------------------------- */

.social {
	width:135px;
	float:right;
	padding-top:10px;
}

.social ul {
	list-style: none;
}

.social ul li {
	float:left;
	width:21px;
	height:24px;
	margin:0;
	padding:0;
	margin-left:6px;
}

/* TIPSY */
/* ----------------------------------------- */

.tipsy { padding: 5px; font-size: 10px; background-repeat: no-repeat;  background-image: url(../../images/cv/tipsy.gif); }
.tipsy-inner { padding: 5px 8px 4px 8px; background-color: #080626; color: #fff; max-width: 200px; text-align: center; }
.tipsy-inner { -moz-border-radius:3px; -webkit-border-radius:3px; }
.tipsy-north { background-position: top center; }
.tipsy-south { background-position: bottom center; margin-bottom:20px; }
.tipsy-east { background-position: right center; }
.tipsy-west { background-position: left center; }


/* COLORBOX */
/* ----------------------------------------- */

#colorbox, #cboxOverlay, #cboxWrapper{position:absolute; top:0; left:0; z-index:9999; overflow:hidden;}
#cboxOverlay{position:fixed; width:100%; height:100%;}
#cboxMiddleLeft, #cboxBottomLeft{clear:left;}
#cboxContent{position:relative; overflow:hidden;}
#cboxLoadedContent{overflow:auto;}
#cboxLoadedContent iframe{display:block; width:100%; height:100%; border:0;}
#cboxTitle{margin:0; display:none;}
#cboxLoadingOverlay, #cboxLoadingGraphic{position:absolute; top:0; left:0; width:100%;}
#cboxPrevious, #cboxNext, #cboxClose, #cboxSlideshow{cursor:pointer;}

#cboxOverlay{background:#666;}

#colorBox{}
#cboxTopLeft{width:25px; height:25px; background:url(../../images/cv/border1.png) 0 0 no-repeat;}
#cboxTopCenter{height:25px; background:url(../../images/cv/border1.png) 0 -50px repeat-x;}
#cboxTopRight{width:25px; height:25px; background:url(../../images/cv/border1.png) -25px 0 no-repeat;}
#cboxBottomLeft{width:25px; height:25px; background:url(../../images/cv/border1.png) 0 -25px no-repeat;}
#cboxBottomCenter{height:25px; background:url(../../images/cv/border1.png) 0 -75px repeat-x;}
#cboxBottomRight{width:25px; height:25px; background:url(../../images/cv/border1.png) -25px -25px no-repeat;}
#cboxMiddleLeft{width:25px; background:url(../../images/cv/border2.png) 0 0 repeat-y;}
#cboxMiddleRight{width:25px; background:url(../../images/cv/border2.png) -25px 0 repeat-y;}
#cboxContent{background:#fff;}
#cboxLoadedContent{margin-bottom:20px;}
#cboxTitle{position:absolute; bottom:0px; left:0; text-align:center; width:100%; color:#373737;}
#cboxCurrent{position:absolute; bottom:0px; left:100px; color:#000;}
#cboxSlideshow{position:absolute; bottom:0px; right:42px; color:#444;}
#cboxPrevious{position:absolute; bottom:0px; left:0; color:#444;}
#cboxNext{position:absolute; bottom:0px; left:63px; color:#444;}
#cboxLoadingOverlay{background:url(../../images/cv/loading.gif) 5px 5px no-repeat #fff;}
#cboxClose{position:absolute; bottom:0; right:0; display:block; color:#444;}


/* GO TO TOP */
/* ----------------------------------------- */

#message {
	display: block;
	display: none;
	z-index: 999;
	opacity: .8;
	position: fixed;
	top: 100%;
	margin-top: -40px;
	right: 0%;
	margin-right:10px;
	-moz-border-radius: 3px;
	-webkit-border-radius: 3px;
	width: 77px;
	line-height: 20px;
	height: 20px;
	padding: 5px;
	background-color: #080626;
	font-size: 11px;
	text-align: center;
}

#message a {
	color: #fff;
}
	
/* ELEMENTS */
/* ----------------------------------------- */

table {
	width: 500px;
	margin-left:40px;
	float:right;
	border-collapse: collapse;
	border-bottom:1px dashed #999;
	border-top:1px dashed #999;
}

table td {
	padding: 10px;
	padding-top:0;
	border-right:1px dashed #999;
}

table td:hover {
	background-color: #f2f2f2;
}

table th {
	padding: 10px;
	padding-top:0;
	color:#FABD17;
	text-align: left;
	border-right:1px dashed #999;
}

table td.center {
	text-align: center;
}

table td.last {
	background: none;
}

table th.center {
	text-align: center;
}

table th.last {
	background: none;
}

table tr {
	border-left:1px dashed #999;
	border-top:1px dashed #999;
}

table tr.caption {
	border-left:1px dashed #999;
}

blockquote {
	border-left:3px solid #FABD17;
	padding-left:8px;
	width:489px;
	margin-left:40px;
	float:right;
}

abbr, acronym {
	border-bottom:1px dashed #FABD17;
}

strong {
	font-weight: bold;
}

small {
	font-size:70%;
}

big {
	font-size:1.2em;
}


/* CONTACT */

fieldset, legend {
	float:right;
	width:500px;
	padding:0;
	margin:0;
	margin-left:40px;
}

h1.warn {
	color:#373737;
	font-size:18px;
	margin-top:30px;
	padding:50px;
	text-align: center;
}

#contactform {
	width:320px;
	height:370px;
	margin:0 auto;
	padding:50px;
	overflow: hidden;
}

label {
	float:left;
	width:40px;
	height:28px;
	margin-bottom:10px;
	clear:both;
	color:#373737; 
}

input {
	width:228px;
	float:right;
	height:18px;
	margin-bottom:10px;
	border-top:1px solid #c8c8c8;
	border-left:1px solid #c8c8c8;
	border-right:1px solid #dadada;
	border-bottom:1px solid #f2f2f2;
	background-color: #e4e4e4;
	font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
	font-size: 13px;
	padding:5px;
	outline: none;
}

input:focus {
	background-color: #dddddd;
	border-top:1px solid #c8c8c8;
	border-left:1px solid #c8c8c8;
	border-right:1px solid #dadada;
	border-bottom:1px solid #f2f2f2;
}

textarea {
	border-top:1px solid #c8c8c8;
	border-left:1px solid #c8c8c8;
	border-right:1px solid #dadada;
	border-bottom:1px solid #f2f2f2;
	background-color: #e4e4e4;
	width:228px;
	float:right;
	margin-bottom:10px;
	font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
	font-size: 13px;
	padding:5px;
	outline: none;
}

textarea:focus {
	background-color: #dddddd;
	border-top:1px solid #c8c8c8;
	border-left:1px solid #c8c8c8;
	border-right:1px solid #dadada;
	border-bottom:1px solid #f2f2f2;
}

.submit-button {
	background: transparent url(../../images/cv/submit.jpg) no-repeat 0 0;
	display: block;
	clear: both;
	width:90px;
	height: 33px; 
	border:none;
	float:left;
	margin-left: 80px;
	text-indent: -9999px;
	outline: 0;
	cursor: pointer;
	padding:0;
}

.submit-button:hover {
	background: transparent url(../../images/cv/submit.jpg) no-repeat 0 -33px;
	outline: 0;
	border: none;
}

label.error {
	clear: both;
	padding:0;
	margin-top:-5px;
	color:#FABD17;
	font-size: 1.0em;
	font-style: italic;
	font-weight: normal;
	margin-left:80px;
	width:238px;
}
</style>
</head>
<body>

<!-- Begin Wrapper -->
<div id="wrapper">
	<div class="wrapper-top"></div>
	<div class="wrapper-mid">
		<!-- Begin Paper -->
		<div id="paper">
			<div class="paper-top"></div>
			<div id="paper-mid">
				<div class="entry">
					<g:img width="100%" uri="/images/logo_bandeau_tritem.gif"/>
				</div>
				<div class="entry">
					<!-- Begin Image -->
					<g:img class="portrait" uri="/images/cv/image.jpg" alt="${curriculumVitaeInstance.employe.prenom} ${curriculumVitaeInstance.employe.nom}"/>
					<!-- End Image -->
					<!-- Begin Personal Information -->
					<div class="self">
						<h1 class="name">
							${curriculumVitaeInstance.employe.prenom} ${curriculumVitaeInstance.employe.nom}
							<span> ${curriculumVitaeInstance.libellePoste}</span>
						</h1>
					</div>
					<!-- End Personal Information -->
					
				</div>
				
				<div class="entry">
					<h2>COMPETENCES</h2>
					<g:each in="${curriculumVitaeInstance.competencesTriees}">
						<g:if test="${it.value.size() >  0}">
							<div class="content">
								<h3>${it.key}</h3>
								<ul class="skills">
									<g:each in="${it.value}">
										<li>${it.libelle}</li>
									</g:each>
								</ul>
							</div>
						</g:if>
					</g:each>
				</div>
				<div class="entry">
					<h2>FORMATION</h2>
					<g:each in="${curriculumVitaeInstance.formations}">
						<div class="content">
							<h3>${it.periode}</h3>
							<p>
								${it.libelle}
								<em>${it.diplome}</em>
							</p>
						</div>
					</g:each>
				</div>
				<div class="entry">
					<h2>EXPERIENCE</h2>	
					<g:each in="${curriculumVitaeInstance.experiences}">
						<div class="content">
							<h3>${it.periode}</h3>
							<p>
								${it.libelle}
								<em>${it.poste}</em>
							</p>
							<ul class="info">
								<g:each in="${listesExperiences.get(it.id)}">
									<li>${it.libelle }</li>
								</g:each>
							</ul>
						</div>
					</g:each>
				</div>
			</div>
			<div class="clear"></div>
			<div class="paper-bottom"></div>
		</div>
		<!-- End Paper -->
	</div>
	<div class="wrapper-bottom"></div>
</div>
<!-- End Wrapper -->
</body>
</html>