<%@ page import="com.tritem.cvcreator.TypeEmploye" %>



<div class="fieldcontain ${hasErrors(bean: typeEmployeInstance, field: 'libelle', 'error')} ">
	<label for="libelle">
		<g:message code="typeEmploye.libelle.label" default="Libelle" />
		
	</label>
	<g:textField name="libelle" value="${typeEmployeInstance?.libelle}"/>
</div>

