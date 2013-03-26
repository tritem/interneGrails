package com.tritem.cvcreator

import org.springframework.dao.DataIntegrityViolationException

class TypeCompetenceController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
	
    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [typeCompetenceInstanceList: TypeCompetence.list(params), typeCompetenceInstanceTotal: TypeCompetence.count()]
    }

    def create() {
        [typeCompetenceInstance: new TypeCompetence(params)]
    }

    def save() {
        def typeCompetenceInstance = new TypeCompetence(params)
        if (!typeCompetenceInstance.save(flush: true)) {
            render(view: "create", model: [typeCompetenceInstance: typeCompetenceInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'typeCompetence.label', default: 'TypeCompetence'), typeCompetenceInstance.id])
        redirect(action: "show", id: typeCompetenceInstance.id)
    }

    def show(Long id) {
        def typeCompetenceInstance = TypeCompetence.get(id)
        if (!typeCompetenceInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'typeCompetence.label', default: 'TypeCompetence'), id])
            redirect(action: "list")
            return
        }

        [typeCompetenceInstance: typeCompetenceInstance]
    }

    def edit(Long id) {
        def typeCompetenceInstance = TypeCompetence.get(id)
        if (!typeCompetenceInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'typeCompetence.label', default: 'TypeCompetence'), id])
            redirect(action: "list")
            return
        }

        [typeCompetenceInstance: typeCompetenceInstance]
    }

    def update(Long id, Long version) {
        def typeCompetenceInstance = TypeCompetence.get(id)
        if (!typeCompetenceInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'typeCompetence.label', default: 'TypeCompetence'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (typeCompetenceInstance.version > version) {
                typeCompetenceInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'typeCompetence.label', default: 'TypeCompetence')] as Object[],
                          "Another user has updated this TypeCompetence while you were editing")
                render(view: "edit", model: [typeCompetenceInstance: typeCompetenceInstance])
                return
            }
        }

        typeCompetenceInstance.properties = params

        if (!typeCompetenceInstance.save(flush: true)) {
            render(view: "edit", model: [typeCompetenceInstance: typeCompetenceInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'typeCompetence.label', default: 'TypeCompetence'), typeCompetenceInstance.id])
        redirect(action: "show", id: typeCompetenceInstance.id)
    }

    def delete(Long id) {
        def typeCompetenceInstance = TypeCompetence.get(id)
        if (!typeCompetenceInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'typeCompetence.label', default: 'TypeCompetence'), id])
            redirect(action: "list")
            return
        }

        try {
            typeCompetenceInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'typeCompetence.label', default: 'TypeCompetence'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'typeCompetence.label', default: 'TypeCompetence'), id])
            redirect(action: "show", id: id)
        }
    }
}
