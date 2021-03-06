
<%@ page import="com.tritem.cvcreator.CurriculumVitae" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'curriculumVitae.label', default: 'CurriculumVitae')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-curriculumVitae" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-curriculumVitae" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list curriculumVitae">
			
				<g:if test="${curriculumVitaeInstance?.employe}">
				<li class="fieldcontain">
					<span id="employe-label" class="property-label"><g:message code="curriculumVitae.employe.label" default="Employe" /></span>
					<span class="property-value" aria-labelledby="employe-label"><g:fieldValue bean="${curriculumVitaeInstance.employe}" field="prenom"/>&nbsp;<g:fieldValue bean="${curriculumVitaeInstance.employe}" field="nom"/></span>
				</li>
				<li class="fieldcontain">
					<span id="employe-label" class="property-label"><g:message code="curriculumVitae.employe.dateNaissance" default="Date de naissance" /></span>
					<span class="property-value" aria-labelledby="employe-label"><g:formatDate format="dd/MM/yyyy" date="${curriculumVitaeInstance.employe.dateNaissance}"/></span>
				</li>
				</g:if>
			
				<g:if test="${curriculumVitaeInstance?.libellePoste}">
				<li class="fieldcontain">
					<span id="libellePoste-label" class="property-label"><g:message code="curriculumVitae.libellePoste.label" default="Poste" /></span>
					<span class="property-value" aria-labelledby="libellePoste-label"><g:fieldValue bean="${curriculumVitaeInstance}" field="libellePoste"/></span>	
				</li>
				</g:if>
				
				<g:if test="${curriculumVitaeInstance?.commentaire}">
				<li class="fieldcontain">
					<span id="commentaire-label" class="property-label"><g:message code="curriculumVitae.commentaire.label" default="Commentaire" /></span>
					<span class="property-value" aria-labelledby="commentaire-label"><g:fieldValue bean="${curriculumVitaeInstance}" field="commentaire"/></span>	
				</li>
				</g:if>
			
				<g:if test="${curriculumVitaeInstance?.competences}">
				<li class="fieldcontain">
					<span id="competences-label" class="property-label"><g:message code="curriculumVitae.competences.label" default="Competences" /></span>
					
					<g:each in="${curriculumVitaeInstance.competences}" var="c">
					<span class="property-value" aria-labelledby="competences-label"><g:fieldValue bean="${c}" field="libelle"/></span>
					</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${curriculumVitaeInstance?.formations}">
				<li class="fieldcontain">
					<span id="formations-label" class="property-label"><g:message code="curriculumVitae.formations.label" default="Formations" /></span>
					
						<g:each in="${curriculumVitaeInstance.formations}" var="f">
							<span class="property-value" aria-labelledby="experiences-label"><g:fieldValue bean="${f}" field="periode"/></span>
							<span class="property-value" aria-labelledby="experiences-label"><g:fieldValue bean="${f}" field="libelle"/></span>
							<br />	
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${curriculumVitaeInstance?.experiences}">
				<li class="fieldcontain">
					<span id="lignesExperience-label" class="property-label"><g:message code="curriculumVitae.experience.label" default="Experience" /></span>
						<g:each in="${curriculumVitaeInstance.experiences}" var="e" status="i">
							<label class="sousLabel">
					        	Expérience ${i+1}
					        </label>
							<span class="property-value" aria-labelledby="lignesExperience-label"><g:fieldValue bean="${e}" field="periode"/></span>
							<span class="property-value" aria-labelledby="lignesExperience-label"><g:fieldValue bean="${e}" field="client"/></span>
							<g:if test="${e?.projets}">
									<span id="lignesExperience-label" class="property-label">&nbsp;</span>
									<g:each in="${e.projets}" var="p" status="j">
										<label class="sousLabel">
						        			Projet ${j+1} 
						        		</label>
										<span class="property-value" aria-labelledby="lignesExperience-label"><g:fieldValue bean="${p}" field="periode"/></span>
										<span class="property-value" aria-labelledby="lignesExperience-label"><g:fieldValue bean="${p}" field="poste"/></span>
										<span class="property-value" aria-labelledby="lignesExperience-label"><g:fieldValue bean="${p}" field="titre"/></span>
										<span class="property-value" aria-labelledby="lignesExperience-label"><pre><font face="Verdana" color="#515151" size="1" ><g:fieldValue bean="${p}" field="description"/></font></pre></span>
										<g:if test="${p?.lignesProjet}">
										<g:each in="${p.lignesProjet}" var="l">
											<span class="property-value" aria-labelledby="lignesExperience-label"><pre><font face="Verdana" color="#515151" size="1" ><g:fieldValue bean="${l}" field="libelle"/></font></pre></span>
										</g:each>
										<span class="property-value" aria-labelledby="lignesExperience-label"><g:fieldValue bean="${p}" field="competences"/></span>
										</g:if>
									</g:each>
							</g:if>
						</g:each>
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${curriculumVitaeInstance?.id}" />
					<g:link class="edit" action="edit" id="${curriculumVitaeInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
					<g:link class="show" action="showCV" id="${curriculumVitaeInstance?.id}">Voir le CV</g:link>
					<g:link class="show" action="pdf" id="${curriculumVitaeInstance?.id}">Télécharger le CV</g:link>
					<g:link class="show" action="duplique" id="${curriculumVitaeInstance?.id}">Dupliquer le CV</g:link>
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
