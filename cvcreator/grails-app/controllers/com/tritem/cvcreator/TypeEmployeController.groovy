package com.tritem.cvcreator

import org.springframework.dao.DataIntegrityViolationException;

class TypeEmployeController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
	
    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [typeEmployeInstanceList: TypeEmploye.list(params), typeEmployeInstanceTotal: TypeEmploye.count()]
    }

    def create() {
        [typeEmployeInstance: new TypeEmploye(params)]
    }

    def save() {
        def typeEmployeInstance = new TypeEmploye(params)
        if (!typeEmployeInstance.save(flush: true)) {
            render(view: "create", model: [typeEmployeInstance: typeEmployeInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'typeEmploye.label', default: 'TypeEmploye'), typeEmployeInstance.id])
        redirect(action: "show", id: typeEmployeInstance.id)
    }

    def show(Long id) {
        def typeEmployeInstance = TypeEmploye.get(id)
        if (!typeEmployeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'typeEmploye.label', default: 'TypeEmploye'), id])
            redirect(action: "list")
            return
        }

        [typeEmployeInstance: typeEmployeInstance]
    }

    def edit(Long id) {
        def typeEmployeInstance = TypeEmploye.get(id)
        if (!typeEmployeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'typeEmploye.label', default: 'TypeEmploye'), id])
            redirect(action: "list")
            return
        }

        [typeEmployeInstance: typeEmployeInstance]
    }

    def update(Long id, Long version) {
        def typeEmployeInstance = TypeEmploye.get(id)
        if (!typeEmployeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'typeEmploye.label', default: 'TypeEmploye'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (typeEmployeInstance.version > version) {
                typeEmployeInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'typeEmploye.label', default: 'TypeEmploye')] as Object[],
                          "Another user has updated this TypeEmploye while you were editing")
                render(view: "edit", model: [typeEmployeInstance: typeEmployeInstance])
                return
            }
        }

        typeEmployeInstance.properties = params

        if (!typeEmployeInstance.save(flush: true)) {
            render(view: "edit", model: [typeEmployeInstance: typeEmployeInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'typeEmploye.label', default: 'TypeEmploye'), typeEmployeInstance.id])
        redirect(action: "show", id: typeEmployeInstance.id)
    }

    def delete(Long id) {
        def typeEmployeInstance = TypeEmploye.get(id)
        if (!typeEmployeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'typeEmploye.label', default: 'TypeEmploye'), id])
            redirect(action: "list")
            return
        }

        try {
            typeEmployeInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'typeEmploye.label', default: 'TypeEmploye'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'typeEmploye.label', default: 'TypeEmploye'), id])
            redirect(action: "show", id: id)
        }
    }
}
