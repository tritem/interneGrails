<%@ page import="com.tritem.cvcreator.Employe" %>



<div class="fieldcontain ${hasErrors(bean: employeInstance, field: 'nom', 'error')} ">
	<label for="nom">
		<g:message code="employe.nom.label" default="Nom" />
		
	</label>
	<g:textField name="nom" value="${employeInstance?.nom}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: employeInstance, field: 'prenom', 'error')} ">
	<label for="prenom">
		<g:message code="employe.prenom.label" default="Prenom" />
		
	</label>
	<g:textField name="prenom" value="${employeInstance?.prenom}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: employeInstance, field: 'dateNaissance', 'error')} required">
	<label for="dateNaissance">
		<g:message code="employe.dateNaissance.label" default="Date Naissance" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="dateNaissance" precision="day"  value="${employeInstance?.dateNaissance}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: employeInstance, field: 'agence', 'error')} required">
	<label for="agence">
		<g:message code="curriculumVitae.agence.label" default="Agence" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="agence" name="agence.id" from="${com.tritem.cvcreator.Agence.list()}" optionKey="id" optionValue="nom" required="" value="${employeInstance?.agence?.id}" class="one-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: employeInstance, field: 'estDisponible', 'error')} ">
	<label for="estDisponible">
		<g:message code="employe.estDisponible.label" default="Disponible" />
		
	</label>
	<g:checkBox name="estDisponible" value="${employeInstance.estDisponible}" />
	
</div>

