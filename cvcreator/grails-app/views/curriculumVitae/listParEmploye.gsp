
<%@ page import="com.tritem.cvcreator.CurriculumVitae" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'curriculumVitae.label', default: 'CurriculumVitae')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-curriculumVitae" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-curriculumVitae" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<th>Lien vers l'employé</th>
						<g:sortableColumn property="libellePoste" title="${message(code: 'curriculumVitae.libellePoste.label', default: 'Libelle Poste')}" />
						<th>Date de création</th>
						<th>Date dernière Modification</th>
						<th>Editer</th>
						<th>Consulter</th>
						<th>Dupliquer</th>
					</tr>
				</thead>
				<tbody>
				<g:each in="${curriculumVitaeInstanceList}" status="i" var="curriculumVitaeInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link controller="employe" action="show" id="${curriculumVitaeInstance.employe.id}">${curriculumVitaeInstance.employe.prenom} ${curriculumVitaeInstance.employe.nom}</g:link></td>
						<td>${fieldValue(bean: curriculumVitaeInstance, field: "libellePoste")}</td>
						<td>${curriculumVitaeInstance.dateCreated}</td>
						<td>${curriculumVitaeInstance.lastUpdated}</td>
						<td><g:link action="edit" id="${curriculumVitaeInstance.id}"><g:img  uri="/images/skin/database_edit.png"/></g:link></td>
						<td><g:link action="showCV" id="${curriculumVitaeInstance.id}">Voir le CV</g:link></td>
						<td><g:link action="duplique" id="${curriculumVitaeInstance.id}"><g:img  uri="/images/skin/database_add.png"/></g:link></td>
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${curriculumVitaeInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
