package com.tritem.cvcreator

import org.springframework.dao.DataIntegrityViolationException

class CompetenceController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
		Long typeCompetenceId = params.typeCompetenceId?.toLong()
		println params
		println typeCompetenceId
		def competenceInstanceList
		def competenceInstanceTotal
		if (typeCompetenceId){
			competenceInstanceList = Competence.findAll("from Competence as comp where comp.typeCompetence=:typeComp",
				[typeComp: TypeCompetence.get(typeCompetenceId)], params)
			competenceInstanceTotal=Competence.findAll("from Competence as comp where comp.typeCompetence=:typeComp",
				[typeComp: TypeCompetence.get(typeCompetenceId)]).size()
		} else {
			competenceInstanceList=Competence.findAll(params)
			competenceInstanceTotal=Competence.count
		}
		println competenceInstanceList
        [competenceInstanceList:competenceInstanceList, 
			competenceInstanceTotal: competenceInstanceTotal,
			typeCompetenceList:TypeCompetence.list(),
			typeCompetenceId:typeCompetenceId]
    }

    def create() {
        [competenceInstance: new Competence(params)]
    }

    def save() {
        def competenceInstance = new Competence(params)
        if (!competenceInstance.save(flush: true)) {
            render(view: "create", model: [competenceInstance: competenceInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'competence.label', default: 'Competence'), competenceInstance.id])
        redirect(action: "show", id: competenceInstance.id)
    }

    def show(Long id) {
        def competenceInstance = Competence.get(id)
        if (!competenceInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'competence.label', default: 'Competence'), id])
            redirect(action: "list")
            return
        }

        [competenceInstance: competenceInstance]
    }

    def edit(Long id) {
        def competenceInstance = Competence.get(id)
        if (!competenceInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'competence.label', default: 'Competence'), id])
            redirect(action: "list")
            return
        }

        [competenceInstance: competenceInstance]
    }

    def update(Long id, Long version) {
        def competenceInstance = Competence.get(id)
        if (!competenceInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'competence.label', default: 'Competence'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (competenceInstance.version > version) {
                competenceInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'competence.label', default: 'Competence')] as Object[],
                          "Another user has updated this Competence while you were editing")
                render(view: "edit", model: [competenceInstance: competenceInstance])
                return
            }
        }

        competenceInstance.properties = params

        if (!competenceInstance.save(flush: true)) {
            render(view: "edit", model: [competenceInstance: competenceInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'competence.label', default: 'Competence'), competenceInstance.id])
        redirect(action: "show", id: competenceInstance.id)
    }

    def delete(Long id) {
        def competenceInstance = Competence.get(id)
        if (!competenceInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'competence.label', default: 'Competence'), id])
            redirect(action: "list")
            return
        }

        try {
            competenceInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'competence.label', default: 'Competence'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'competence.label', default: 'Competence'), id])
            redirect(action: "show", id: id)
        }
    }
}
