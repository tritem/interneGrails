package com.tritem.cvcreator

import org.springframework.dao.DataIntegrityViolationException

class CurriculumVitaeController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

	def pdf(Long id){
		CurriculumVitae cv = CurriculumVitae.get(id)
		if (!cv) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'cv.label', default: 'CurriculumVitae'), id])
		} else {
			def listesExperiences = [:]
			cv.lignesExperience.each {
				if (!listesExperiences.get(it.experienceId)){
					listesExperiences.put(it.experienceId, [])
				}
				listesExperiences.get(it.experienceId).add(it)
			}
			renderPdf(template: "cv",
				model:[cv: cv, listesExperiences:listesExperiences],
				filename: "cv.pdf")
		}
	}
	
	def showCV(Long id){
		CurriculumVitae curriculumVitaeInstance = CurriculumVitae.get(id)
		if (!curriculumVitaeInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'cv.label', default: 'CurriculumVitae'), id])
		} else {
			def listesExperiences = [:]
			curriculumVitaeInstance.lignesExperience.each {
				if (!listesExperiences.get(it.experienceId)){
					listesExperiences.put(it.experienceId, [])
				}
				listesExperiences.get(it.experienceId).add(it)
			}
			[curriculumVitaeInstance: curriculumVitaeInstance, listesExperiences:listesExperiences]
		}
	}
	
    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [curriculumVitaeInstanceList: CurriculumVitae.list(params), curriculumVitaeInstanceTotal: CurriculumVitae.count()]
    }

    def create() {
        [curriculumVitaeInstance: new CurriculumVitae(params)]
    }

    def save() {
        def curriculumVitaeInstance = new CurriculumVitae(params)
        if (!curriculumVitaeInstance.save(flush: true)) {
            render(view: "create", model: [curriculumVitaeInstance: curriculumVitaeInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'curriculumVitae.label', default: 'CurriculumVitae'), curriculumVitaeInstance.id])
        redirect(action: "show", id: curriculumVitaeInstance.id)
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
		def listesLignesExp = [:]
		def listesProjets = [:]
		int i=0

		// Construction de la collection des projets
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
			projet.toDelete = params."projets[${i}].toDelete"
			if (!listesProjets.get(params."lignesExperience[${i}].htmlIdExperience")){
				listesProjets.put(params."lignesExperience[${i}].htmlIdExperience", [])
			}
			listesProjets.get(params."lignesExperience[${i}].htmlIdExperience").add(projet)
			log.debug "projets[${i}]:"+projet
			i++
		}
		
		// Construction de la collection des lignes de projet
		i=0
		while (params."lignesProjet[${i}]") {
			LigneProjet ligneProjet = new LigneProjet()
			ligneProjet.idTechnique = params.long("lignesProjet[${i}].idTechnique")
			ligneProjet.libelle =  params."lignesProjet[${i}].libelle"
			ligneProjet.toDelete =  Boolean.valueOf(params."lignesProjet[${i}].toDelete").booleanValue()
			ligneProjet.htmlIdProjet =  params."lignesProjet[${i}].htmlIdExperience"
			ligneProjet.idxProjet =  params.long("lignesProjet[${i}].idxExp") ?: 0
			
			if (!listesLignesExp.get(params."lignesProjet[${i}].htmlIdExperience")){
				listesLignesExp.put(params."lignesProjet[${i}].htmlIdExperience", [])
			}
			listesLignesExp.get(params."lignesProjet[${i}].htmlIdExperience").add(ligneProjet)
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
		curriculumVitaeInstance.properties = params
		
		curriculumVitaeInstance.experiences.each {Experience experience ->
			listesLignesExp.get(experience.htmlId).each {LigneProjet ligneExperience ->
				if (!ligneExperience.idTechnique){
					experience.addToLignesExperience(ligneExperience)
				} else {
					experience.lignesExperience[ligneExperience.idxExp].libelle = ligneExperience.libelle
					experience.lignesExperience[ligneExperience.idxExp].toDelete = ligneExperience.toDelete
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
	
	def experienceService
	def competenceService
	def curriculumVitaeService
}
