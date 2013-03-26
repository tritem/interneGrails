<%@ page import="com.tritem.cvcreator.Competence" %>



<div class="fieldcontain ${hasErrors(bean: competenceInstance, field: 'libelle', 'error')} ">
	<label for="libelle">
		<g:message code="competence.libelle.label" default="Libelle" />
		
	</label>
	<g:textField name="libelle" value="${competenceInstance?.libelle}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: competenceInstance, field: 'typeCompetence', 'error')} required">
	<label for="typeCompetence">
		<g:message code="competence.typeCompetence.label" default="Type Competence" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="typeCompetence" name="typeCompetence.id" 
	from="${com.tritem.cvcreator.TypeCompetence.list()}" 
	optionKey="id" required="" value="${competenceInstance?.typeCompetence?.id}" 
	optionValue="libelle"
	class="many-to-one"/>
</div>

