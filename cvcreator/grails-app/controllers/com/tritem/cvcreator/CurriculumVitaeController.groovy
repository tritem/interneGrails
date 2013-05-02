package com.tritem.cvcreator

import org.codehaus.groovy.grails.web.util.StreamCharBuffer;
import org.springframework.dao.DataIntegrityViolationException
import org.xhtmlrenderer.pdf.ITextRenderer;

import com.sun.xml.internal.org.jvnet.mimepull.MIMEEvent.Content;

class CurriculumVitaeController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }
	
	def showCV(Long id){
		CurriculumVitae curriculumVitaeInstance = CurriculumVitae.get(id)
		if (!curriculumVitaeInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'cv.label', default: 'CurriculumVitae'), id])
		} else {
			[curriculumVitaeInstance: curriculumVitaeInstance, pdf : false]
		}
	}
			
	
	def downloadPdf(Long id){
		CurriculumVitae curriculumVitaeInstance = CurriculumVitae.get(id)
		if (!curriculumVitaeInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'cv.label', default: 'CurriculumVitae'), id])
		} else {
			def imageTritem = new File(getGrailsApplication().parentContext.servletContext.getRealPath("/images/logo_bandeau_tritem.gif"))
			renderPdf(template: "cv", model: [curriculumVitaeInstance: curriculumVitaeInstance, imageTritem : imageTritem.bytes, pdf : true], 
				filename: "cv_" + curriculumVitaeInstance.employe.nom + "_" + curriculumVitaeInstance.employe.prenom + ".pdf")
		}
	}
	
    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [curriculumVitaeInstanceList: CurriculumVitae.list(params), curriculumVitaeInstanceTotal: CurriculumVitae.count()]
    }
	
	def listParEmploye(Long id) {
		Employe employe = Employe.get(id)
		def curriculumVitaeInstanceList = CurriculumVitae.findAllByEmploye(employe)
		[curriculumVitaeInstanceList: curriculumVitaeInstanceList, curriculumVitaeInstanceTotal: curriculumVitaeInstanceList.size()]
	}

    def create() {
		log.debug("create --> params:${params}")
		Long idEmploye = params.long("idEmploye")
		Employe employe
		if (idEmploye != null)
		{
			employe = Employe.get(idEmploye)
		}
		else
		{
			employe = new Employe();
		}
		CurriculumVitae curriculumVitaeInstance = new CurriculumVitae()
		curriculumVitaeInstance.employe = employe
		curriculumVitaeInstance.formations = new ArrayList<Formation>()
		curriculumVitaeInstance.competences = new ArrayList<Competence>()
		
		
		if (idEmploye != null)
		{
			def curriculumVitaeInstanceList = CurriculumVitae.findAllByEmploye(employe)
		
			Formation formation
			if (curriculumVitaeInstanceList && curriculumVitaeInstanceList.size() > 0)
			{
				CurriculumVitae cvPlusrecent = curriculumVitaeInstanceList.get(0)
				if (cvPlusrecent.formations && cvPlusrecent.formations.size() > 0) {
					for (Formation f in cvPlusrecent.formations)
					{
						formation = new Formation()
						formation.periode = f.periode
						formation.libelle = f.libelle
						curriculumVitaeInstance.formations.add(formation)
					} 
				}else{
					curriculumVitaeInstance.formations.add(new Formation())
				}
				
				for (CurriculumVitae cv in curriculumVitaeInstanceList)
				{
					if (cv?.competences)
					{
						for (Competence c in cv.competences)
						{
							if (!curriculumVitaeInstance.competences.contains(c))
							{
								curriculumVitaeInstance.competences.add(c)
							}
						}
					}
				}
			}else{
				curriculumVitaeInstance.competences = new ArrayList<Competence>()
				curriculumVitaeInstance.formations.add(new Formation())
			}
		}
		else
		{
			curriculumVitaeInstance.competences = new ArrayList<Competence>()
			curriculumVitaeInstance.formations.add(new Formation())
		}
		
		
		LigneProjet ligneProjet = new LigneProjet()
		Projet projet = new Projet()
		projet.lignesProjet = new ArrayList<LigneProjet>()
		projet.lignesProjet.add(ligneProjet)
		Experience experience = new Experience()
		experience.projets = new ArrayList<Projet>()
		experience.projets.add(projet)
		curriculumVitaeInstance.experiences = new ArrayList<Experience>()
		curriculumVitaeInstance.experiences.add(experience)
		
		def toutesCompetencesTriees = [:]
		toutesCompetencesTriees = competenceService.getToutesCompetencesTriees()
		int nbLignesProjet = 1
		int nbProjet = 1
		
		[curriculumVitaeInstance: curriculumVitaeInstance,
			toutesCompetencesTriees:toutesCompetencesTriees,
			nbProjet:nbProjet,
			nbLignesProjet:nbLignesProjet]
    }

    def save() {
		log.debug("save --> params:${params}")
		
		params.remove "_competences"
        def curriculumVitaeInstance = new CurriculumVitae(params)
		curriculumVitaeInstance.dateCreated = new Date()
        
		def listesLignesProjet = [:]
		def listesProjets = [:]
		int i=0

		// Construction de la collection des projets
		i=0
		while (params."projets[${i}]") {
			Projet projet = new Projet()
			projet.periode = params."projets[${i}].periode"
			projet.poste = params."projets[${i}].poste"
			projet.titre = params."projets[${i}].titre"
			projet.description = params."projets[${i}].description"
			projet.competences = params."projets[${i}].competences"
			projet.htmlId = params."projets[${i}].htmlId"
			projet.htmlIdExperience = params."projets[${i}].htmlIdExperience"
			projet.idxExp =  params.long("projets[${i}].idxExp") ?: 0
			projet.toDelete = Boolean.valueOf("projets[${i}].toDelete").booleanValue()
			if (!listesProjets.get(params."projets[${i}].htmlIdExperience")){
				listesProjets.put(params."projets[${i}].htmlIdExperience", [])
			}
			listesProjets.get(params."projets[${i}].htmlIdExperience").add(projet)
			i++
		}
				
		// Construction de la collection des lignes de projet
		i=0
		while (params."lignesProjet[${i}]") {
			LigneProjet ligneProjet = new LigneProjet()
			ligneProjet.libelle =  params."lignesProjet[${i}].libelle"
			ligneProjet.toDelete =  Boolean.valueOf(params."lignesProjet[${i}].toDelete").booleanValue()
			ligneProjet.htmlIdProjet =  params."lignesProjet[${i}].htmlIdExperience"
			ligneProjet.idxProjet =  params.long("lignesProjet[${i}].idxProjet") ?: 0
			
			if (!listesLignesProjet.get(params."lignesProjet[${i}].htmlIdProjet")){
				listesLignesProjet.put(params."lignesProjet[${i}].htmlIdProjet", [])
			}
			listesLignesProjet.get(params."lignesProjet[${i}].htmlIdProjet").add(ligneProjet)
			log.debug "lignesProjet[${i}]:"+ligneProjet
			i++
		}
			
		List<Projet> listTemp
		List<LigneProjet> listLigneTemp
		
		curriculumVitaeInstance.experiences.each {Experience experience ->
			if (!experience.toDelete){
				listTemp = listesProjets.get(experience.htmlId)
				for (Projet projet in listTemp) {
					log.debug "projet: "+projet
					if (!projet.toDelete){
						experience.addToProjets(projet)
						listLigneTemp = listesLignesProjet.get(projet.htmlId)
						for (LigneProjet ligneProjet in listLigneTemp) {
							if (!ligneProjet.toDelete){
								projet.addToLignesProjet(ligneProjet)
							}
						}
					}
				}
			}
		}
		if (!curriculumVitaeInstance.save(flush: true)) {
            render(view: "create", model: [curriculumVitaeInstance: curriculumVitaeInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'curriculumVitae.label', default: 'CurriculumVitae'), curriculumVitaeInstance.id])
        redirect(action: "show", id: curriculumVitaeInstance.id)
		
		log.debug("--< save params:${params}")		
    }

    def show(Long id) {
        def curriculumVitaeInstance = CurriculumVitae.get(id)
        if (!curriculumVitaeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'curriculumVitae.label', default: 'CurriculumVitae'), id])
            redirect(action: "list")
            return
        }

        [curriculumVitaeInstance: curriculumVitaeInstance]
    }

    def edit(Long id) {
        def curriculumVitaeInstance = CurriculumVitae.get(id)
        if (!curriculumVitaeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'curriculumVitae.label', default: 'CurriculumVitae'), id])
            redirect(action: "list")
            return
        }
		
		def toutesCompetencesTriees = [:]
		toutesCompetencesTriees = competenceService.getToutesCompetencesTriees()
		def listesExperiencesTriees = [:]
		int nbLignesProjet = 0
		int nbProjet = 0
		curriculumVitaeInstance.experiences.each { Experience experience ->
			nbProjet += experience.projets.size()
			experience.projets.each{Projet projet ->
				nbLignesProjet += projet.lignesProjet.size()
			}
		}
        [curriculumVitaeInstance: curriculumVitaeInstance,
			toutesCompetencesTriees:toutesCompetencesTriees,
			nbProjet:nbProjet,
			nbLignesProjet:nbLignesProjet]
    }

    def update(Long id, Long version) {
		log.debug("update --> params:${params}")
		def listesLignesProjet = [:]
		def listesProjets = [:]
		def listesExperiences = []
		int i=0

		// Construction de la collection des projets
		/*while (params."experiences[${i}]") {
			Experience experience = new Experience()
			experience.periode = params."experiences[${i}].periode"
			experience.client = params."experiences[${i}].client"
			experience.htmlId = params."experiences[${i}].htmlId"
			experience.toDelete = Boolean.valueOf("experiences[${i}].toDelete").booleanValue()
			listesExperiences.add(experience)
			log.debug "experiences[${i}]:"+experience
			i++
		}*/
		
		// Construction de la collection des projets
		i=0
		while (params."projets[${i}]") {
			Projet projet = new Projet()
			projet.idTechnique = params.long("projets[${i}].idTechnique")
			projet.periode = params."projets[${i}].periode"
			projet.poste = params."projets[${i}].poste"
			projet.titre = params."projets[${i}].titre"
			projet.description = params."projets[${i}].description"
			projet.competences = params."projets[${i}].competences"
			projet.htmlId = params."projets[${i}].htmlId"
			projet.htmlIdExperience = params."projets[${i}].htmlIdExperience"
			projet.idxExp =  params.long("projets[${i}].idxExp") ?: 0
			projet.toDelete = Boolean.valueOf("projets[${i}].toDelete").booleanValue()
			if (!listesProjets.get(params."projets[${i}].htmlIdExperience")){
				listesProjets.put(params."projets[${i}].htmlIdExperience", [])
			}
			listesProjets.get(params."projets[${i}].htmlIdExperience").add(projet)
			log.debug "projets[${i}]:"+projet + "idTechnique :" + params."projets[${i}].idTechnique" + " htmlIdExp=" + params."projets[${i}].htmlIdExperience"
			i++
		}
		
		def test = listesProjets.get(0)
		log.debug "test1" + test
		
		def test2 = listesProjets.get("0")
		log.debug "test2" + test2
		
		// Construction de la collection des lignes de projet
		i=0
		while (params."lignesProjet[${i}]") {
			LigneProjet ligneProjet = new LigneProjet()
			ligneProjet.idTechnique = params.long("lignesProjet[${i}].idTechnique")
			ligneProjet.libelle =  params."lignesProjet[${i}].libelle"
			ligneProjet.toDelete =  Boolean.valueOf(params."lignesProjet[${i}].toDelete").booleanValue()
			ligneProjet.htmlIdProjet =  params."lignesProjet[${i}].htmlIdExperience"
			ligneProjet.idxProjet =  params.long("lignesProjet[${i}].idxProjet") ?: 0
			
			if (!listesLignesProjet.get(params."lignesProjet[${i}].htmlIdProjet")){
				listesLignesProjet.put(params."lignesProjet[${i}].htmlIdProjet", [])
			}
			listesLignesProjet.get(params."lignesProjet[${i}].htmlIdProjet").add(ligneProjet)
			log.debug "lignesProjet[${i}]:"+ligneProjet
			i++
		}
		
        def curriculumVitaeInstance = CurriculumVitae.get(id)
        if (!curriculumVitaeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'curriculumVitae.label', default: 'CurriculumVitae'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (curriculumVitaeInstance.version > version) {
                curriculumVitaeInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'curriculumVitae.label', default: 'CurriculumVitae')] as Object[],
                          "Already modified")
                render(view: "edit", model: [curriculumVitaeInstance: curriculumVitaeInstance])
                return
            }
        }
		
		params.remove "_competences"
		List<Experience> listTempExp = curriculumVitaeInstance.experiences
		curriculumVitaeInstance.properties = params
			
		List<Projet> listTemp
		Projet projettemp
		
		List<LigneProjet> listLigneTemp
		List<Experience> listesExperiencesASauvegarder = new ArrayList()
		
		curriculumVitaeInstance.experiences.each {Experience experience ->
			
			listTemp = listesProjets.get(experience.htmlId)

			for (Projet projet in listTemp) {
				log.debug "projet: "+projet
				
				if (!projet.idTechnique){
					experience.addToProjets(projet)
				} else {
					experience.projets[projet.idxExp].periode = projet.periode
					experience.projets[projet.idxExp].poste = projet.poste
					experience.projets[projet.idxExp].titre = projet.titre
					experience.projets[projet.idxExp].description = projet.description
					experience.projets[projet.idxExp].competences = projet.competences
					experience.projets[projet.idxExp].toDelete = projet.toDelete
				}
				
				listLigneTemp = listesLignesProjet.get(projet.htmlId)
				for (LigneProjet ligneProjet in listLigneTemp) {
					if (!ligneProjet.idTechnique){
						experience.projets[projet.idxExp].addToLignesProjet(ligneProjet)
					} else {
						experience.projets[projet.idxExp].lignesProjet[ligneProjet.idxProjet].libelle = ligneProjet.libelle
						experience.projets[projet.idxExp].lignesProjet[ligneProjet.idxProjet].toDelete = ligneProjet.toDelete
					}
				}
				
			}
		}	
		
        if (!curriculumVitaeInstance.save(flush: true)) {
            render(view: "edit", model: [curriculumVitaeInstance: curriculumVitaeInstance])
            return	
        }
		
		curriculumVitaeService.executerToDelete(curriculumVitaeInstance)
		println "controller : "+curriculumVitaeInstance.formations
        flash.message = message(code: 'default.updated.message', args: [message(code: 'curriculumVitae.label', default: 'CurriculumVitae'), curriculumVitaeInstance.id])
        redirect(action: "show", id: curriculumVitaeInstance.id)
		
		log.debug("--< update params:${params}")
    }

    def delete(Long id) {
        def curriculumVitaeInstance = CurriculumVitae.get(id)
        if (!curriculumVitaeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'curriculumVitae.label', default: 'CurriculumVitae'), id])
            redirect(action: "list")
            return
        }

        try {
            curriculumVitaeInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'curriculumVitae.label', default: 'CurriculumVitae'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'curriculumVitae.label', default: 'CurriculumVitae'), id])
            redirect(action: "show", id: id)
        }
    }
	
	def duplique(Long id) {
		log.debug("duplique --> params:${params}")
		
		def cvADupliquer = CurriculumVitae.get(id)
		if (!cvADupliquer) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'curriculumVitae.label', default: 'CurriculumVitae'), id])
			redirect(action: "list")
			return
		}
		
		def toutesCompetencesTriees = [:]
		toutesCompetencesTriees = competenceService.getToutesCompetencesTriees()
		int nbLignesProjet = 0
		int nbProjet = 0
		
		CurriculumVitae newCurriculumVitae = new CurriculumVitae()
		newCurriculumVitae.employe = cvADupliquer.employe
		
		for (Competence competenceADupliquer in cvADupliquer.competences)
		{
			newCurriculumVitae.addToCompetences(competenceADupliquer)
		}
		newCurriculumVitae.commentaire = "cv dupliqué"
		newCurriculumVitae.dateCreated = new Date()
		newCurriculumVitae.libellePoste = cvADupliquer.libellePoste
		
		Formation newFormation
		for (Formation formationADupliquer in cvADupliquer.formations)
		{
			newFormation = new Formation()
			newFormation.periode = formationADupliquer.periode
			newFormation.libelle = formationADupliquer.libelle
			newCurriculumVitae.addToFormations(newFormation)
		}
				
		Experience newExperience
		Projet newProjet
		LigneProjet newLigneProjet
		for (Experience experienceADupliquer in cvADupliquer.experiences)
		{
			newExperience = new Experience()
			newExperience.periode = experienceADupliquer.periode
			newExperience.client = experienceADupliquer.client
			
			newCurriculumVitae.addToExperiences(newExperience)
			
			for (Projet projetADupliquer in experienceADupliquer.projets)
			{
				newProjet = new Projet()
				newProjet.periode = projetADupliquer.periode
				newProjet.poste = projetADupliquer.poste
				newProjet.titre = projetADupliquer.titre
				newProjet.description = projetADupliquer.description
				newProjet.competences = projetADupliquer.competences
				
				newExperience.addToProjets(newProjet)
				for (LigneProjet ligneProjetADupliquer in projetADupliquer.lignesProjet)
				{
					newLigneProjet = new LigneProjet()
					newLigneProjet.libelle = ligneProjetADupliquer.libelle
					newProjet.addToLignesProjet(newLigneProjet)
					nbLignesProjet++
				}
				nbProjet++
			}
		}
		if (!newCurriculumVitae.save(flush: true)) {
			redirect(action: "list")
			return
		}

		flash.message = message(code: 'default.created.message', args: [message(code: 'curriculumVitae.label', default: 'CurriculumVitae'), newCurriculumVitae.id])
		render(view: "edit", model: [curriculumVitaeInstance: newCurriculumVitae,
			toutesCompetencesTriees:toutesCompetencesTriees,
			nbProjet:nbProjet,
			nbLignesProjet:nbLignesProjet])
		log.debug("--< save params:${params}")
	}
	
	def experienceService
	def competenceService
	def curriculumVitaeService
}
