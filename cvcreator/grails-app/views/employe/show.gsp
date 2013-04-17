
<%@ page import="com.tritem.cvcreator.Employe" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'employe.label', default: 'Employe')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-employe" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-employe" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list employe">
			
				<g:if test="${employeInstance?.nom}">
				<li class="fieldcontain">
					<span id="nom-label" class="property-label"><g:message code="employe.nom.label" default="Nom" /></span>
					
						<span class="property-value" aria-labelledby="nom-label"><g:fieldValue bean="${employeInstance}" field="nom"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${employeInstance?.prenom}">
				<li class="fieldcontain">
					<span id="prenom-label" class="property-label"><g:message code="employe.prenom.label" default="Prenom" /></span>
					
						<span class="property-value" aria-labelledby="prenom-label"><g:fieldValue bean="${employeInstance}" field="prenom"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${employeInstance?.dateNaissance}">
				<li class="fieldcontain">
					<span id="dateNaissance-label" class="property-label"><g:message code="employe.dateNaissance.label" default="Date Naissance" /></span>
					
						<span class="property-value" aria-labelledby="dateNaissance-label"><g:formatDate date="${employeInstance?.dateNaissance}" /></span>
					
				</li>
				</g:if>
				
				<g:if test="${employeInstance?.agence?.nom}">
				<li class="fieldcontain">
					<span id="agence-label" class="property-label"><g:message code="employe.agence.label" default="Agence" /></span>
					
						<span class="property-value" aria-labelledby="nom-label"><g:fieldValue bean="${employeInstance}" field="agence.nom"/></span>
					
				</li>
				</g:if>
				
				<g:if test="${employeInstance?.typeEmploye?.libelle}">
				<li class="fieldcontain">
					<span id="agence-label" class="property-label"><g:message code="employe.typeEmploye.label" default="Type Employé" /></span>
					
						<span class="property-value" aria-labelledby="nom-label"><g:fieldValue bean="${employeInstance}" field="typeEmploye.libelle"/></span>
					
				</li>
				</g:if>
				
				<li class="fieldcontain">
					<span id="estDisponible-label" class="property-label"><g:message code="employe.estDisponible.label" default="Disponible" /></span>
					
						<span class="property-value" aria-labelledby="estDisponible-label"><g:checkBox value="${employeInstance.estDisponible}" disabled="disabled" /></span>
					
				</li>
				
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${employeInstance?.id}" />
					<g:link class="edit" action="edit" id="${employeInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
					<g:link class="save" controller="curriculumVitae" action="create" params="[idEmploye:employeInstance?.id]">Créer un CV from scratch</g:link>
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
