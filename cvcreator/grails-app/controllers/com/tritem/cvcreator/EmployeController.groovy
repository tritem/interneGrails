package com.tritem.cvcreator

import org.springframework.dao.DataIntegrityViolationException

class EmployeController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [employeInstanceList: Employe.list(params), employeInstanceTotal: Employe.count()]
    }

    def create() {
        [employeInstance: new Employe(params)]
    }

    def save() {
        def employeInstance = new Employe(params)
		employeInstance.agence = Agence.get(params.agence.id)
		employeInstance.typeEmploye = TypeEmploye.get(params.typeEmploye.id)
		
        if (!employeInstance.save(flush: true)) {
            render(view: "create", model: [employeInstance: employeInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'employe.label', default: 'Employe'), employeInstance.id])
        redirect(action: "show", id: employeInstance.id)
    }

    def show(Long id) {
        def employeInstance = Employe.get(id)
        if (!employeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'employe.label', default: 'Employe'), id])
            redirect(action: "list")
            return
        }

        [employeInstance: employeInstance]
    }

    def edit(Long id) {
        def employeInstance = Employe.get(id)
        if (!employeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'employe.label', default: 'Employe'), id])
            redirect(action: "list")
            return
        }

        [employeInstance: employeInstance]
    }

    def update(Long id, Long version) {
        def employeInstance = Employe.get(id)
        if (!employeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'employe.label', default: 'Employe'), id])
            redirect(action: "list")
            return
        }

		println params
        if (version != null) {
            if (employeInstance.version > version) {
                employeInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'employe.label', default: 'Employe')] as Object[],
                          "Another user has updated this Employe while you were editing")
                render(view: "edit", model: [employeInstance: employeInstance])
                return
            }
        }

        employeInstance.properties = params
		employeInstance.agence = Agence.get(params.agence.id)
		employeInstance.typeEmploye = TypeEmploye.get(params.typeEmploye.id)
		
        if (!employeInstance.save(flush: true)) {
            render(view: "edit", model: [employeInstance: employeInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'employe.label', default: 'Employe'), employeInstance.id])
        redirect(action: "show", id: employeInstance.id)
    }

    def delete(Long id) {
        def employeInstance = Employe.get(id)
        if (!employeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'employe.label', default: 'Employe'), id])
            redirect(action: "list")
            return
        }

        try {
            employeInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'employe.label', default: 'Employe'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'employe.label', default: 'Employe'), id])
            redirect(action: "show", id: id)
        }
    }
}
