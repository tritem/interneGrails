<%@ page import="com.tritem.cvcreator.CurriculumVitae" %>

<div class="fieldcontain ${hasErrors(bean: curriculumVitaeInstance, field: 'employe', 'error')} required">
	<label for="employe">
		<g:message code="curriculumVitae.employe.label" default="Employe" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="employe" name="employe.id" from="${com.tritem.cvcreator.Employe.list()}" optionKey="id" optionValue="${{it.prenom + ' '+ it.nom} }" required="" value="${curriculumVitaeInstance?.employe?.id}" class="many-to-one"/>
</div>

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
	<div id="notaccordion" class="competences">
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

<div>
	<div id="formationList">
		<p class="titreForm">Formations</p>
		<g:each var="formation" in="${curriculumVitaeInstance.formations}" status="k">
			<div id="formation${k}">
		        <label class="sousLabel">
		        	Formation ${k+1}
		        </label>
		        <div class="champSaisieSousLabel">
			        <span onClick="$('#formations\\[${k}\\]\\.toDelete').val('true'); $('#formation${k}').hide()">
						<img src="${resource(dir:'images/skin', file:'database_delete.png')}" />
					</span>
				</div>
				<label for="formations[${k}].periode" class="sousLabel">Période</label>
				<g:textField name="formations[${k}].periode" value="${formation.periode}" class="champSaisieSousLabel"/>
				<label for="formations[${k}].libelle" class="sousLabel">Libellé</label>
				<g:textField name="formations[${k}].libelle" value="${formation.libelle}" class="champSaisieSousLabel"/>
				<label for="formations[${k}].diplome" class="sousLabel">Diplôme</label>
				<g:textField name="formations[${k}].diplome" value="${formation.diplome}" class="champSaisieSousLabel"/>
				<input type="hidden" name='formations[${k}].toDelete' id='formations[${k}].toDelete' value="false"/>
			</div>
		</g:each>
	</div>
	<div class="sousLabel"></div>
   	<div class="champSaisieSousLabel">
    	<input type="button" value="Ajouter Formation" onclick="addFormation();" />
    </div>
</div>

<div>
	<div id="experienceList">
		<p class="titreForm">Expériences</p>
		<g:set var="counterLigneExperience" value="${0}" />
	    <g:each var="experience" in="${curriculumVitaeInstance.experiences}" status="i">
	        <div id="experience${i}">
		        <label class="sousLabel">
		        	Expérience ${i+1}
		        </label>
		        <div class="champSaisieSousLabel">
			        <span onClick="$('#experiences\\[${i}\\]\\.toDelete').val('true'); $('#experience${i}').hide()">
						<img src="${resource(dir:'images/skin', file:'database_delete.png')}" />
					</span>
				</div>
	        	<label for="experiences[${i}].periode" class="sousLabel">Période</label>
	        	<g:textField name='experiences[${i}].periode' value='${experience.periode}' class="champSaisieSousLabel" required="required"/>
	        	<label for="experiences[${i}].poste" class="sousLabel">Poste</label>
				<g:textField name='experiences[${i}].poste' value='${experience.poste}' class="champSaisieSousLabel" required="required"/>
				<label for="experiences[${i}].libelle" class="sousLabel">Libellé</label>
				<g:textField name='experiences[${i}].libelle' value='${experience.libelle}' class="champSaisieSousLabel" required="required"/>
			    <input type="hidden" name='experiences[${i}].toDelete' id='experiences[${i}].toDelete' value="false"/>
			    <input type="hidden" name='experiences[${i}].htmlId' id='experiences[${i}].htmlId' value='${i}'/>
			    <label class="lignesExperiences">Lignes Expérience</label>
			    <div>
				    <div id="lignesExperiencesList${i}">
					    <g:each var="ligneExperience" in="${experience.lignesExperience}" status="j">
					    	<div id="ligneExperience${counterLigneExperience}">
						    	<div class="sousLabel"></div>
						    	<g:textField name='lignesExperience[${counterLigneExperience}].libelle' value='${ligneExperience.libelle }' class="champSaisieSousLabel"/>
						    	<input type="hidden" name="lignesExperience[${counterLigneExperience}].experienceId" value="${experience.id}"/>
						    	<input type="hidden" name="lignesExperience[${counterLigneExperience}].idTechnique" value="${ligneExperience.id}"/>
						    	<input type="hidden" name="lignesExperience[${counterLigneExperience}].htmlIdExperience" value="${i}"/>
						    	<input type="hidden" name="lignesExperience[${counterLigneExperience}].toDelete" id="lignesExperience[${counterLigneExperience}].toDelete" value="false"/>
						    	<input type="hidden" name="lignesExperience[${counterLigneExperience}].idxExp" id="lignesExperience[${counterLigneExperience}].idxExp" value="${j}"/>
						    	<span onClick="$('#lignesExperience\\[${counterLigneExperience}\\]\\.toDelete').val('true'); $('#ligneExperience${counterLigneExperience}').hide()">
							    	<img src="${resource(dir:'images/skin', file:'database_delete.png')}" />
							    </span>
							</div>
							<g:set var="counterLigneExperience" value="${counterLigneExperience + 1}" />
					    </g:each>
			    	</div>
			    	<div class="sousLabel"></div>
			    	<div class="champSaisieSousLabel">
				    	<input type="button" value="Ajouter Ligne Expérience" onclick="addLigneExperience(${experience.id}, ${i});" />
				    </div>
			    </div>
			</div>
	    </g:each>
	</div>
</div>
<div class="sousLabel"><input type="button" value="Ajouter Expérience" onclick="addExperience();" /></div>

<script type="text/javascript">

	var experienceCount = ${curriculumVitaeInstance?.experiences.size()} + 0;
    var lignesExperienceCount = ${nbLignesExp} + 0;
	var formationsCount = ${curriculumVitaeInstance?.formations.size()} + 0;
	var deleteIcon = "${resource(dir:'images/skin', file:'database_delete.png')}";
	
	function addFormation() {
		var htmlId = "formation" + formationsCount;
		var templateHtml = "<div id='" + htmlId + "'>\n";
		templateHtml += "<label class='sousLabel'>Formation "+(formationsCount+1) +"</label>\n";
		templateHtml += "<div class='champSaisieSousLabel'>\n";
		templateHtml += "<span onClick='$(\"#" + htmlId + "\").remove();'><img src='" + deleteIcon + "' /></span>\n";
		templateHtml += "</div>\n";
		templateHtml += "<label for='formations["+formationsCount+"].periode' class='sousLabel'>Période</label>\n";
        templateHtml += "<input type='text' name='formations["+formationsCount+"].periode' class='champSaisieSousLabel' id='formations[" + formationsCount + "].periode' required='required'/>\n";
        templateHtml += "<label for='formations["+formationsCount+"].libelle' class='sousLabel'>Libellé</label>\n";
        templateHtml += "<input type='text' name='formations["+formationsCount+"].libelle' class='champSaisieSousLabel' id='formations[" + formationsCount + "].libelle' required='required'/>\n";
        templateHtml += "<label for='formations["+formationsCount+"].diplome' class='sousLabel'>Diplôme</label>\n";
        templateHtml += "<input type='text' name='formations["+formationsCount+"].diplome' class='champSaisieSousLabel' id='formations[" + formationsCount + "].diplome' required='required'/>\n";
        $("#formationList").append(templateHtml);
		formationsCount++;
	}
    
    function addLigneExperience(experienceId, htmlIdExperience) {
        var htmlId = "ligneExperience" + lignesExperienceCount;
        var idDivToAppend="#lignesExperiencesList"+htmlIdExperience
        var templateHtml = "<div id='" + htmlId + "'>\n";
        templateHtml += "<div class='sousLabel'></div>"
        templateHtml += "<input type='text' name='lignesExperience[" + lignesExperienceCount + "].libelle' class='champSaisieSousLabel' id='lignesExperience[" + lignesExperienceCount + "].libelle'/>\n";
        if (experienceId != null){
        	templateHtml += "<input type='hidden' name='lignesExperience["+ lignesExperienceCount + "].experienceId' value='"+experienceId+"'/>";
        }
        templateHtml += "<input type='hidden' name='lignesExperience["+ lignesExperienceCount + "].htmlIdExperience' value='"+htmlIdExperience+"'/>";
        templateHtml += "<input type='hidden' id='lignesExperience["+ lignesExperienceCount + "].toDelete' name='lignesExperience["+ lignesExperienceCount + "].toDelete' value='"+false+"'/>";
        templateHtml += "<span onClick='$(\"#lignesExperience\\\\["+ lignesExperienceCount + "\\\\]\\\\.toDelete\").val(\"true\");$(\"#" + htmlId + "\").hide();'><img src='" + deleteIcon + "' /></span>\n";
        templateHtml += "</div>\n";
        $(idDivToAppend).append(templateHtml);
        lignesExperienceCount++;
    }

    function addExperience() {
        var htmlId = "experience" + experienceCount;
        var templateHtml = "<div id='" + htmlId + "'>\n";
        templateHtml += "<label class='sousLabel'>Expérience "+(experienceCount+1) +"</label>\n";
        templateHtml += "<div class='champSaisieSousLabel'>\n";
        templateHtml += "<span onClick='$(\"#" + htmlId + "\").remove();'><img src='" + deleteIcon + "' /></span>\n";
        templateHtml += "</div>\n";
        templateHtml += "<label for='experiences["+experienceCount+"].periode' class='sousLabel'>Période</label>\n";
        templateHtml += "<input type='text' name='experiences["+experienceCount+"].periode' class='champSaisieSousLabel' id='experiences[" + experienceCount + "].periode' required='required'/>\n";
        templateHtml += "<label for='experiences["+experienceCount+"].poste' class='sousLabel'>Poste</label>\n";
        templateHtml += "<input type='text' name='experiences["+experienceCount+"].poste' class='champSaisieSousLabel' id='experiences[" + experienceCount + "].poste' required='required'/>\n";
        templateHtml += "<label for='experiences["+experienceCount+"].libelle' class='sousLabel'>Libellé</label>\n";
        templateHtml += "<input type='text' name='experiences["+experienceCount+"].libelle' class='champSaisieSousLabel' id='experiences[" + experienceCount + "].libelle' required='required'/>\n";
        templateHtml += "<input type='hidden' name='experiences["+experienceCount+"].htmlId' id='experiences["+experienceCount+"].htmlId' value='"+experienceCount+"'/>";
        templateHtml += "<label class='lignesExperiences'>Lignes Expérience</label>\n";
        templateHtml += "<div>\n";
        templateHtml += "	<div id='lignesExperiencesList"+experienceCount+"'>\n";
        templateHtml += "		<div id='ligneExperience"+lignesExperienceCount+"'>\n";
        templateHtml += "			<div class='sousLabel'></div>\n";
        templateHtml += "				<input type='text' name='lignesExperience["+lignesExperienceCount+"].libelle' class='champSaisieSousLabel' id='lignesExperience["+lignesExperienceCount+"].libelle'>\n ";
        templateHtml += "				<input type='hidden' name='lignesExperience["+ lignesExperienceCount + "].htmlIdExperience' value='"+experienceCount+"'/>";
        templateHtml += "				<input type='hidden' id='lignesExperience["+ lignesExperienceCount + "].toDelete' name='lignesExperience["+ lignesExperienceCount + "].toDelete' value='"+false+"'/>";
        templateHtml += "				<span onClick='$(\"#lignesExperience\\\\["+ lignesExperienceCount + "\\\\]\\\\.toDelete\").val(\"true\");$(\"#" + htmlId + "\").hide();'><img src='" + deleteIcon + "' /></span>\n";
        templateHtml += "			</div>\n";
        templateHtml += "		</div>";
        templateHtml += "		<div class='sousLabel'></div>";
        templateHtml += "		<div class='champSaisieSousLabel'>";
        templateHtml += "			<input type='button' value='Ajouter Ligne Expérience' onclick='addLigneExperience(null,"+experienceCount+");' />";
        templateHtml += "		</div>";
        templateHtml += "	</div>";
        templateHtml += "</div>\n";
        $("#experienceList").append(templateHtml);
        experienceCount++;
        lignesExperienceCount++;
    }
</script>
        					

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
