
<%@ page import="com.tritem.cvcreator.Employe" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'employe.label', default: 'Employe')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-employe" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-employe" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="nom" title="${message(code: 'employe.nom.label', default: 'Nom')}" />
						<g:sortableColumn property="prenom" title="${message(code: 'employe.prenom.label', default: 'Prenom')}" />
						<g:sortableColumn property="dateNaissance" title="${message(code: 'employe.dateNaissance.label', default: 'Date Naissance')}" />
						<g:sortableColumn property="agence" title="${message(code: 'employe.agence.label', default: 'Agence')}" />
						<g:sortableColumn property="typeEmploye" title="${message(code: 'employe.agence.label', default: 'Type Employé')}" />
						<g:sortableColumn property="estDisponible" title="${message(code: 'employe.estDisponible.label', default: 'Employé disponible')}" />
						<th>Editer</th>
						<th>Voir les CV</th>
						<th>Ajouter un CV</th>
					</tr>
				</thead>
				<tbody>
				<g:each in="${employeInstanceList}" status="i" var="employeInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="edit" id="${employeInstance.id}">${fieldValue(bean: employeInstance, field: "nom")}</g:link></td>
						<td>${fieldValue(bean: employeInstance, field: "prenom")}</td>
						<td><g:formatDate date="${employeInstance.dateNaissance}" /></td>
						<td>${employeInstance.agence.nom}</td>
						<td>${employeInstance.typeEmploye.libelle}</td>
						<td><g:checkBox value="${employeInstance.estDisponible}" disabled="disabled" /></td>
						<td><g:link action="edit" id="${employeInstance.id}"><g:img  uri="/images/skin/database_edit.png"/></g:link></td>
						<td><g:link controller="curriculumVitae" action="listParEmploye" id="${employeInstance.id}"><g:img  uri="/images/skin/database_table.png"/></g:link></td>
						<td><g:link controller="curriculumVitae" action="create" params="[idEmploye:employeInstance?.id]"><g:img  uri="/images/skin/database_add.png"/></g:link></td>
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${employeInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
