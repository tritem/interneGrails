package com.tritem.cvcreator



import org.junit.*
import grails.test.mixin.*

@TestFor(TypeCompetenceController)
@Mock(TypeCompetence)
class TypeCompetenceControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/typeCompetence/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.typeCompetenceInstanceList.size() == 0
        assert model.typeCompetenceInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.typeCompetenceInstance != null
    }

    void testSave() {
        controller.save()

        assert model.typeCompetenceInstance != null
        assert view == '/typeCompetence/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/typeCompetence/show/1'
        assert controller.flash.message != null
        assert TypeCompetence.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/typeCompetence/list'

        populateValidParams(params)
        def typeCompetence = new TypeCompetence(params)

        assert typeCompetence.save() != null

        params.id = typeCompetence.id

        def model = controller.show()

        assert model.typeCompetenceInstance == typeCompetence
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/typeCompetence/list'

        populateValidParams(params)
        def typeCompetence = new TypeCompetence(params)

        assert typeCompetence.save() != null

        params.id = typeCompetence.id

        def model = controller.edit()

        assert model.typeCompetenceInstance == typeCompetence
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/typeCompetence/list'

        response.reset()

        populateValidParams(params)
        def typeCompetence = new TypeCompetence(params)

        assert typeCompetence.save() != null

        // test invalid parameters in update
        params.id = typeCompetence.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/typeCompetence/edit"
        assert model.typeCompetenceInstance != null

        typeCompetence.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/typeCompetence/show/$typeCompetence.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        typeCompetence.clearErrors()

        populateValidParams(params)
        params.id = typeCompetence.id
        params.version = -1
        controller.update()

        assert view == "/typeCompetence/edit"
        assert model.typeCompetenceInstance != null
        assert model.typeCompetenceInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/typeCompetence/list'

        response.reset()

        populateValidParams(params)
        def typeCompetence = new TypeCompetence(params)

        assert typeCompetence.save() != null
        assert TypeCompetence.count() == 1

        params.id = typeCompetence.id

        controller.delete()

        assert TypeCompetence.count() == 0
        assert TypeCompetence.get(typeCompetence.id) == null
        assert response.redirectedUrl == '/typeCompetence/list'
    }
}
