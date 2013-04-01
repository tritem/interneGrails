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
		<g:set var="counterLigneProjet" value="${0}" />
		<g:set var="counterProjets" value="${0}" />
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
	        	<label for="experiences[${i}].client" class="sousLabel">Client</label>
	        	<g:textField name='experiences[${i}].client' value='${experience.client}' class="champSaisieSousLabel" required="required"/>
			    <input type="hidden" name='experiences[${i}].toDelete' id='experiences[${i}].toDelete' value="false"/>
			    <input type="hidden" name='experiences[${i}].htmlId' id='experiences[${i}].htmlId' value='${i}'/>
			    
			    <label class="lignesExperiences">Projets</label>
			    <g:each var="projet" in="${experience.projets}" status="j">
			    	<div id="projet${counterProjets}">
					    <label class="sousLabel">
				        	Projet ${j+1}
				        </label>
				        <div class="champSaisieSousLabel">
					        <span onClick="$('#projets\\[${counterProjets}\\]\\.toDelete').val('true'); $('#projet${counterProjets}').hide()">
								<img src="${resource(dir:'images/skin', file:'database_delete.png')}" />
							</span>
						</div>
				    	<label for="projets[${counterProjets}].periode" class="sousLabel">Période</label>
		        		<g:textField name='projets[${counterProjets}].periode' value='${projet.periode}' class="champSaisieSousLabel" required="required"/>
		        		<label for="projets[${counterProjets}].poste" class="sousLabel">Poste</label>
		        		<g:textField name='projets[${counterProjets}].poste' value='${projet.poste}' class="champSaisieSousLabel" required="required"/>
		        		<label for="projets[${counterProjets}].titre" class="sousLabel">Titre</label>
		        		<g:textField name='projets[${counterProjets}].titre' value='${projet.titre}' class="champSaisieSousLabel" required="required"/>
		        		<label for="projets[${counterProjets}].description" class="sousLabel">Description</label>
		        		<g:textField name='projets[${counterProjets}].description' value='${projet.description}' class="champSaisieSousLabel" required="required"/>
		        		<label for="projets[${counterProjets}].competences" class="sousLabel">Env. Technique</label>
		        		<g:textField name='projets[${counterProjets}].competences' value='${projet.competences}' class="champSaisieSousLabel" required="required"/>
		        		<input type="hidden" name="projets[${counterProjets}].experienceId" value="${experience.id}"/>
		        		<input type="hidden" name="projets[${counterProjets}].idTechnique" value="${projet.id}"/>
		        		<input type="hidden" name="projets[${counterProjets}].htmlIdExperience" value="${j}"/>
		        		<input type="hidden" name="projets[${counterProjets}].toDelete" id="projets[${counterProjets}].toDelete" value="false"/>
		        		<input type="hidden" name="projets[${counterProjets}].idxExp" value="${i}"/>
						<label class="lignesExperiences">Lignes Projet</label>
						<div>
							<div id="lignesProjetsList${counterProjets}">
								<g:each var="ligneProjet" in="${projet.lignesProjet}" status="k">
									<div id="ligneProjet${counterLigneProjet}">
										<div class="sousLabel"></div>
										<g:textField name='lignesProjet[${counterLigneProjet}].libelle' value='${ligneProjet.libelle}' class="champSaisieSousLabel"/>
								    	<input type="hidden" name="lignesProjet[${counterLigneProjet}].projetId" value="${projet.id}"/>
								    	<input type="hidden" name="lignesProjet[${counterLigneProjet}].idTechnique" value="${ligneProjet.id}"/>
								    	<input type="hidden" name="lignesProjet[${counterLigneProjet}].htmlIdProjet" value="${k}"/>
								    	<input type="hidden" name="lignesProjet[${counterLigneProjet}].toDelete" id="lignesProjet[${counterLigneProjet}].toDelete" value="false"/>
								    	<input type="hidden" name="lignesProjet[${counterLigneProjet}].idxProjet" id="lignesProjet[${counterLigneProjet}].idxProjet" value="${j}"/>
								    	<span onClick="$('#lignesProjet\\[${counterLigneProjet}\\]\\.toDelete').val('true'); $('#ligneProjet${counterLigneProjet}').hide()">
							    			<img src="${resource(dir:'images/skin', file:'database_delete.png')}" />
				   						</span>
									</div>
									<g:set var="counterLigneProjet" value="${counterLigneProjet + 1}" />
								</g:each>
							</div>
							<div class='sousLabel'></div>
							<div class="champSaisieSousLabel">
								<input type="button" value="Ajouter Ligne Projet" onclick="addLigneProjet(${projet.id}, ${j});" />
							</div>
						</div>
	        		</div>
	        		<g:set var="counterProjets" value="${counterProjets + 1}" />
			    </g:each>
			</div>
			<div class="champSaisieSousLabel">
				<input type="button" value="Ajouter Projet" onclick="addProjet(${experience.id}, ${i});" />
			</div>
	    </g:each>
	</div>
</div>
<div class="sousLabel"><input type="button" value="Ajouter Expérience" onclick="addExperience();" /></div>

<script type="text/javascript">

	var experienceCount = ${curriculumVitaeInstance?.experiences.size()} + 0;
	var projetCount = ${nbProjet} + 0;
    var lignesProjetCount = ${nbLignesProjet} + 0;
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
        $("#formationList").append(templateHtml);
		formationsCount++;
	}
    
    function addLigneProjet(projetId, htmlIdProjet) {
        var htmlId = "ligneProjet" + lignesProjetCount;
        var idDivToAppend="#lignesProjetsList"+htmlIdProjet
        var templateHtml = "<div id='" + htmlId + "'>\n";
        templateHtml += "<div class='sousLabel'></div>"
        templateHtml += "<input type='text' name='lignesProjet[" + lignesProjetCount + "].libelle' class='champSaisieSousLabel' id='lignesProjet[" + lignesProjetCount + "].libelle'/>\n";
        if (projetId != null){
        	templateHtml += "<input type='hidden' name='lignesProjet["+ lignesProjetCount + "].projetId' value='"+projetId+"'/>";
        }
        templateHtml += "<input type='hidden' name='lignesProjet["+ lignesProjetCount + "].htmlIdProjet' value='"+htmlIdProjet+"'/>";
        templateHtml += "<input type='hidden' id='lignesProjet["+ lignesProjetCount + "].toDelete' name='lignesProjet["+ lignesProjetCount + "].toDelete' value='"+false+"'/>";
        templateHtml += "<span onClick='$(\"#lignesProjet\\\\["+ lignesProjetCount + "\\\\]\\\\.toDelete\").val(\"true\");$(\"#" + htmlId + "\").hide();'><img src='" + deleteIcon + "' /></span>\n";
        templateHtml += "</div>\n";
        $(idDivToAppend).append(templateHtml);
        lignesProjetCount++;
    }

    function addProjet(experienceId, htmlIdExperience) {
    	var htmlId = "projet" + projetCount;
    	var htmlIdLigneProjet =  "ligneProjet" + lignesProjetCount
    	var idDivToAppend="#projet"+htmlIdExperience
        var templateHtml = "<div id='" + htmlId + "'>\n";
        templateHtml += "<label class='sousLabel'>Projet "+(projetCount+1) +"</label>\n";
        templateHtml += "<div class='champSaisieSousLabel'>\n";
        templateHtml += "<span onClick='$(\"#" + htmlId + "\").remove();'><img src='" + deleteIcon + "' /></span>\n";
        templateHtml += "</div>\n";
        templateHtml += "<label for='projets["+projetCount+"].periode' class='sousLabel'>Période</label>\n";
        templateHtml += "<input type='text' name='projets["+projetCount+"].periode' class='champSaisieSousLabel' id='projets[" + projetCount + "].periode'/>\n";
        templateHtml += "<label for='projets["+projetCount+"].poste' class='sousLabel'>Poste</label>\n";
        templateHtml += "<input type='text' name='projets["+projetCount+"].poste' class='champSaisieSousLabel' id='projets[" + projetCount + "].poste'/>\n";
        templateHtml += "<label for='projets["+projetCount+"].titre' class='sousLabel'>Titre</label>\n";
        templateHtml += "<input type='text' name='projets["+projetCount+"].titre' class='champSaisieSousLabel' id='projets[" + projetCount + "].titre'/>\n";
        templateHtml += "<label for='projets["+projetCount+"].description' class='sousLabel'>Description</label>\n";
        templateHtml += "<input type='text' name='projets["+projetCount+"].description' class='champSaisieSousLabel' id='projets[" + projetCount + "].description'/>\n";
        templateHtml += "<label for='projets["+projetCount+"].competences' class='sousLabel'>Env. Technique</label>\n";
        templateHtml += "<input type='text' name='projets["+projetCount+"].competences' class='champSaisieSousLabel' id='projets[" + projetCount + "].competences'/>\n";
		templateHtml += "<input type='hidden' name='projets["+ projetCount + "].experienceId' value='"+experienceId+"'/>";
		templateHtml += "<input type='hidden' name='projets["+ projetCount + "].experienceId' value='"+experienceId+"'/>";
		templateHtml += "<input type='hidden' name='projets["+ projetCount + "].htmlIdExperience' value='"+htmlIdExperience+"'/>";
		templateHtml += "<input type='hidden' name='projets["+ projetCount + "].toDelete' value='false'/>";
		templateHtml += "<input type='hidden' name='projets["+ projetCount + "].idxExp' value='"+experienceCount+"'/>";
        templateHtml += "<input type='hidden' name='projets["+projetCount+"].htmlId' id='projets["+projetCount+"].htmlId' value='"+projetCount+"'/>";
        templateHtml += "<label class='lignesExperiences'>Lignes Projet</label>\n";
        templateHtml += "<div>\n";
        templateHtml += "	<div id='lignesProjetsList"+projetCount+"'>\n";
        templateHtml += "		<div id='ligneProjet"+lignesProjetCount+"'>\n";
        templateHtml += "			<div class='sousLabel'></div>\n";
        templateHtml += "				<input type='text' name='lignesProjet["+lignesProjetCount+"].libelle' class='champSaisieSousLabel' id='lignesProjet["+lignesProjetCount+"].libelle'>\n ";
        templateHtml += "				<input type='hidden' name='lignesProjet["+ lignesProjetCount + "].htmlIdProjet' value='"+lignesProjetCount+"'/>";
        templateHtml += "				<input type='hidden' id='lignesProjet["+ lignesProjetCount + "].toDelete' name='lignesProjet["+ lignesProjetCount + "].toDelete' value='"+false+"'/>";
        templateHtml += "				<span onClick='$(\"#lignesProjet\\\\["+ lignesProjetCount + "\\\\]\\\\.toDelete\").val(\"true\");$(\"#" + htmlIdLigneProjet + "\").hide();'><img src='" + deleteIcon + "' /></span>\n";
        templateHtml += "			</div>\n";
        templateHtml += "		</div>";
        templateHtml += "		<div class='sousLabel'></div>";
        templateHtml += "		<div class='champSaisieSousLabel'>";
        templateHtml += "			<input type='button' value='Ajouter Ligne Projet' onclick='addLigneProjet(null,"+projetCount+");' />";
        templateHtml += "		</div>";
        templateHtml += "	</div>";
        templateHtml += "</div>\n";
        $(idDivToAppend).append(templateHtml);
        projetCount++;
        lignesProjetCount++;
    }

    function addExperience() {
        var htmlId = "experience" + experienceCount;
        var htmlIdProjet = "projet" + projetCount;
        var htmlIdLigneProjet =  "ligneProjet" + lignesProjetCount
        var templateHtml = "<div id='" + htmlId + "'>\n";
        templateHtml += "<label class='sousLabel'>Expérience "+(experienceCount+1) +"</label>\n";
        templateHtml += "<div class='champSaisieSousLabel'>\n";
        templateHtml += "<span onClick='$(\"#" + htmlId + "\").remove();'><img src='" + deleteIcon + "' /></span>\n";
        templateHtml += "</div>\n";
        templateHtml += "<label for='experiences["+experienceCount+"].periode' class='sousLabel'>Période</label>\n";
        templateHtml += "<input type='text' name='experiences["+experienceCount+"].periode' class='champSaisieSousLabel' id='experiences[" + experienceCount + "].periode' required='required'/>\n";
        templateHtml += "<label for='experiences["+experienceCount+"].client' class='sousLabel'>Client</label>\n";
        templateHtml += "<input type='text' name='experiences["+experienceCount+"].client' class='champSaisieSousLabel' id='experiences[" + experienceCount + "].client' required='required'/>\n";
        templateHtml += "<input type='hidden' name='experiences["+experienceCount+"].htmlId' id='experiences["+experienceCount+"].htmlId' value='"+experienceCount+"'/>";

        templateHtml += "<label class='lignesExperiences'>Projets</label>";
        templateHtml +=	"<div id='projet" + (projetCount) +"'>\n";
		
        templateHtml += "<label class='sousLabel'>Projet "+(projetCount+1) +"</label>\n";
        templateHtml += "<div class='champSaisieSousLabel'>\n";
        templateHtml += "<span onClick='$(\"#" + htmlIdProjet + "\").remove();'><img src='" + deleteIcon + "' /></span>\n";
        templateHtml += "</div>\n";
        templateHtml += "<label for='projets["+projetCount+"].periode' class='sousLabel'>Période</label>\n";
        templateHtml += "<input type='text' name='projets["+projetCount+"].periode' class='champSaisieSousLabel' id='projets[" + projetCount + "].periode' required='required'/>\n";
        templateHtml += "<label for='projets["+projetCount+"].poste' class='sousLabel'>Poste</label>\n";
        templateHtml += "<input type='text' name='projets["+projetCount+"].poste' class='champSaisieSousLabel' id='projets[" + projetCount + "].poste' required='required'/>\n";
        templateHtml += "<label for='projets["+projetCount+"].titre' class='sousLabel'>Titre</label>\n";
        templateHtml += "<input type='text' name='projets["+projetCount+"].titre' class='champSaisieSousLabel' id='projets[" + projetCount + "].titre' required='required'/>\n";
        templateHtml += "<label for='projets["+projetCount+"].description' class='sousLabel'>Description</label>\n";
        templateHtml += "<input type='text' name='projets["+projetCount+"].description' class='champSaisieSousLabel' id='projets[" + projetCount + "].description' required='required'/>\n";
        templateHtml += "<input type='hidden' name='projets["+projetCount+"].htmlId' id='projets["+projetCount+"].htmlId' value='"+projetCount+"'/>";
        templateHtml += "<label class='lignesExperiences'>Lignes Projet</label>\n";
        templateHtml += "<div>\n";
        templateHtml += "	<div id='lignesProjetsList"+projetCount+"'>\n";
        templateHtml += "		<div id='ligneProjet"+lignesProjetCount+"'>\n";
        templateHtml += "			<div class='sousLabel'></div>\n";
        templateHtml += "				<input type='text' name='lignesProjet["+lignesProjetCount+"].libelle' class='champSaisieSousLabel' id='lignesProjet["+lignesProjetCount+"].libelle'>\n ";
        templateHtml += "				<input type='hidden' name='lignesProjet["+ lignesProjetCount + "].htmlIdProjet' value='"+lignesProjetCount+"'/>";
        templateHtml += "				<input type='hidden' id='lignesProjet["+ lignesProjetCount + "].toDelete' name='lignesProjet["+ lignesProjetCount + "].toDelete' value='"+false+"'/>";
        templateHtml += "				<span onClick='$(\"#lignesProjet\\\\["+ lignesProjetCount + "\\\\]\\\\.toDelete\").val(\"true\");$(\"#" + htmlIdLigneProjet + "\").hide();'><img src='" + deleteIcon + "' /></span>\n";
        templateHtml += "			</div>\n";
        templateHtml += "		</div>";
        templateHtml += "		<div class='sousLabel'></div>";
        templateHtml += "		<div class='champSaisieSousLabel'>";
        templateHtml += "			<input type='button' value='Ajouter Ligne Projet' onclick='addLigneProjet(null,"+projetCount+");' />";
        templateHtml += "		</div>";
        templateHtml += "	</div>";
        templateHtml += "</div>\n";
        
        templateHtml += "</div>";
        
        $("#experienceList").append(templateHtml);
        experienceCount++;
        projetCount++;
        lignesProjetCount++;
    }
</script>
        					

<script>
<%--$("#notaccordion").addClass("ui-accordion ui-accordion-icons ui-widget ui-helper-reset")--%>
<%--  .find("h3")--%>
<%--    .addClass("ui-accordion-header ui-helper-reset ui-state-default ui-corner-top ui-corner-bottom")--%>
<%--    .hover(function() { $(this).toggleClass("ui-state-hover"); })--%>
<%--    .prepend('<span class="ui-icon ui-icon-triangle-1-e"></span>')--%>
<%--    .click(function() {--%>
<%--      $(this)--%>
<%--        .toggleClass("ui-accordion-header-active ui-state-active ui-state-default ui-corner-bottom")--%>
<%--        .find("> .ui-icon").toggleClass("ui-icon-triangle-1-e ui-icon-triangle-1-s").end()--%>
<%--        .next().toggleClass("ui-accordion-content-active").slideToggle();--%>
<%--      return false;--%>
<%--    })--%>
<%--    .next()--%>
<%--      .addClass("ui-accordion-content  ui-helper-reset ui-widget-content ui-corner-bottom")--%>
<%--      .hide();--%>
<%--ui-accordion-header ui-helper-reset ui-state-default ui-corner-top ui-corner-bottom--%>
<%--ui-accordion-header ui-helper-reset ui-corner-top ui-accordion-header-active ui-state-active--%>
	$("#notaccordion").addClass("ui-accordion ui-accordion-icons ui-widget ui-helper-reset")
	.find("h3")
	  .addClass("ui-accordion-header ui-helper-reset ui-corner-top ui-accordion-header-active ui-state-active")
	  .hover(function() { $(this).toggleClass("ui-state-hover"); })
	  .prepend('<span class="ui-icon ui-icon-triangle-1-s"></span>')
	  .click(function() {
	    $(this)
	      .toggleClass("ui-accordion-header-active ui-state-active ui-state-default ui-corner-bottom")
	      .find("> .ui-icon").toggleClass("ui-icon-triangle-1-e ui-icon-triangle-1-s").end()
	      .next().toggleClass("ui-accordion-content-active");
	    return false;
	  })
	  .next()
	    .addClass("ui-accordion-content  ui-helper-reset ui-widget-content ui-corner-bottom ui-accordion-content-active");
</script>