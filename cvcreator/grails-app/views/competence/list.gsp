
<%@ page import="com.tritem.cvcreator.Competence" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'competence.label', default: 'Competence')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-competence" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-competence" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:form action="list" >
				<fieldset class="form">				
					<div class="fieldcontain ${hasErrors(bean: competenceInstance, field: 'typeCompetence', 'error')} required">
						<label for="typeCompetence">
							Type de compétence
							<span class="required-indicator">*</span>
						</label>
						<g:select id="typeCompetence" name="typeCompetenceId" 
						from="${com.tritem.cvcreator.TypeCompetence.list()}" 
						optionKey="id" required="" value="${competenceInstance?.typeCompetence?.id}" 
						optionValue="libelle"
						noSelection="['':'-Choisissez un type de compétence-']"
						class="many-to-one"/>
					</div>
				</fieldset>
				<fieldset class="buttons">
					<g:submitButton name="create" class="save" value="Rechercher" />
				</fieldset>
			</g:form>
			<table>
				<thead>
					<tr>
						<g:sortableColumn property="libelle" title="${message(code: 'competence.libelle.label', default: 'Libelle')}" />
						<th><g:message code="competence.typeCompetence.label" default="Type Competence" /></th>
					</tr>
				</thead>
				<tbody>
				<g:each in="${competenceInstanceList}" status="i" var="competenceInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${competenceInstance.id}">${fieldValue(bean: competenceInstance, field: "libelle")}</g:link></td>
					
						<td>${fieldValue(bean: competenceInstance, field: "typeCompetence.libelle")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${competenceInstanceTotal}"/>
			</div>
		</div>
	</body>
</html>
