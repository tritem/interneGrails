<%@ page import="com.tritem.cvcreator.TypeCompetence" %>



<div class="fieldcontain ${hasErrors(bean: typeCompetenceInstance, field: 'libelle', 'error')} ">
	<label for="libelle">
		<g:message code="typeCompetence.libelle.label" default="Libelle" />
		
	</label>
	<g:textField name="libelle" value="${typeCompetenceInstance?.libelle}"/>
</div>

