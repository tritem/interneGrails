<%@ page import="com.tritem.cvcreator.CurriculumVitae" %>


<!-- ThemeSwitcher  |  http://jqueryui.com/docs/Theming/ThemeSwitcher  -->
<style type="text/css">#ui-themeswitcher{position:absolute;top:0.5em;right:130px}</style>
<script src="http://jqueryui.com/themeroller/themeswitchertool/"></script>
<script>jQuery(function($){ $( "<div id='ui-themeswitcher'></div>" ).appendTo( "body" ).themeswitcher(); });</script>	
<script src="http://code.jquery.com/jquery-latest.js"></script>

<!-- Employé concerné -->
<div class="fieldcontain ${hasErrors(bean: curriculumVitaeInstance, field: 'employe', 'error')} required">
	<label for="employe">
		<g:message code="curriculumVitae.employe.label" default="Employe" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="employe" name="employe.id" from="${com.tritem.cvcreator.Employe.list()}" 
	optionKey="id" 
	optionValue="${{it.prenom + ' ' + it.nom}}"
	required="" value="${curriculumVitaeInstance?.employe?.id}" class="many-to-one"/>
</div>

<!-- Poste concerné -->
<div class="fieldcontain ${hasErrors(bean: curriculumVitaeInstance, field: 'libellePoste', 'error')} ">
	<label for="libellePoste">
		<g:message code="curriculumVitae.libellePoste.label" default="Libelle Poste" />
		
	</label>
	<g:textField name="libellePoste" value="${curriculumVitaeInstance?.libellePoste}"/>
</div>

<!-- Compétences liées à ce cv -->
<div class="fieldcontain ${hasErrors(bean: curriculumVitaeInstance, field: 'competences', 'error')} ">
	<label for="competences">
		<g:message code="curriculumVitae.competences.label" default="Competences" />
		
	</label>
	<div id="notaccordion">
		<g:each in="${toutesCompetencesTriees}">
			<g:if test="${it.value.size()>0 }">
				<h3><a href="#">${it.key}</a></h3>
				<div>
					<g:each in="${it.value }" var="competence">
						<label>${competence.libelle}
							<g:checkBox name="competences" value="${competence.id}" checked="${curriculumVitaeInstance.competences.contains(competence) }"/>
						</label>
					</g:each>
				</div>
			</g:if>
		</g:each>
	</div>
</div>

<!-- Expériences -->
<div class="fieldcontain ${hasErrors(bean: curriculumVitaeInstance, field: 'experiences', 'error')} ">
	<label for="experiences">
		<g:message code="curriculumVitae.experiences.label" default="Experiences" />
		
	</label>
<%--	<div id="experienceList">--%>
<%--	    <g:each var="experience" in="${curriculumVitaeInstance.experiences}" status="i">--%>
<%--	        <div id="experience${i}">--%>
<%--	        	<g:each var="ligneExperience" in="${experienceInstance.lignesExperience}" status="j">--%>
<%--			        <div id="ligneExperience${j}">--%>
<%--					    <g:textField name='lignesExperience[${j}].libelle' value='${ligneExperience.libelle}'/>--%>
<%--					    <input type="hidden" name='lignesExperience[${i}].deleted' id='lignesExperience[${j}].deleted' value='false'/>--%>
<%--					    <span onClick="$('#lignesExperience\\[${j}\\]\\.deleted').val('true'); $('#ligneExperience${j}').hide()">--%>
<%--					    	<img src="${resource(dir:'images/skin', file:'database_delete.png')}" />--%>
<%--					    </span>--%>
<%--					</div>--%>
<%--			    </g:each>--%>
<%--	    --%>
<%--	    --%>
<%--	    --%>
<%--			    <g:textField name='lignesExperience[${i}].libelle' value='${ligneExperience.libelle}'/>--%>
<%--			    <input type="hidden" name='lignesExperience[${i}].deleted' id='lignesExperience[${i}].deleted' value='false'/>--%>
<%--			    <span onClick="$('#lignesExperience\\[${i}\\]\\.deleted').val('true'); $('#ligneExperience${i}').hide()">--%>
<%--			    	<img src="${resource(dir:'images/skin', file:'database_delete.png')}" />--%>
<%--			    </span>--%>
<%--			</div>--%>
<%--	    </g:each>--%>
<%--	</div>--%>
<%--	<g:select name="experiences" from="${com.tritem.cvcreator.Experience.list()}" multiple="multiple" optionKey="id" size="5" value="${curriculumVitaeInstance?.experiences*.id}" class="many-to-many"/>--%>
</div>

<input type="hidden" name="lignesExperience[0].experienceId" value="1" />
<input type="hidden" name="lignesExperience[0].libelle" value="libellé 1" />
<input type="hidden" name="lignesExperience[0].experienceId" value="1" />
<input type="hidden" name="lignesExperience[0].libelle" value="libellé 2" />
<input type="hidden" name="lignesExperience[1].experienceId" value="2" />
<input type="hidden" name="lignesExperience[1].libelle" value="libelle 3" />


<!-- Formations / écoles -->
<div class="fieldcontain ${hasErrors(bean: curriculumVitaeInstance, field: 'formations', 'error')} ">
	<label for="formations">
		<g:message code="curriculumVitae.formations.label" default="Formations" />
		
	</label>
	<g:select name="formations" from="${com.tritem.cvcreator.Formation.list()}" multiple="multiple" optionKey="id" size="5" value="${curriculumVitaeInstance?.formations*.id}" class="many-to-many"/>
</div>

<script>
$("#notaccordion").addClass("ui-accordion ui-accordion-icons ui-widget ui-helper-reset")
  .find("h3")
    .addClass("ui-accordion-header ui-helper-reset ui-state-default ui-corner-top ui-corner-bottom")
    .hover(function() { $(this).toggleClass("ui-state-hover"); })
    .prepend('<span class="ui-icon ui-icon-triangle-1-e"></span>')
    .click(function() {
      $(this)
        .toggleClass("ui-accordion-header-active ui-state-active ui-state-default ui-corner-bottom")
        .find("> .ui-icon").toggleClass("ui-icon-triangle-1-e ui-icon-triangle-1-s").end()
        .next().toggleClass("ui-accordion-content-active").slideToggle();
      return false;
    })
    .next()
      .addClass("ui-accordion-content  ui-helper-reset ui-widget-content ui-corner-bottom")
      .hide();
</script>

