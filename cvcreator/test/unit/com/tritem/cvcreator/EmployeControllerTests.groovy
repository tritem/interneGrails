package com.tritem.cvcreator



import org.junit.*
import grails.test.mixin.*

@TestFor(EmployeController)
@Mock(Employe)
class EmployeControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/employe/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.employeInstanceList.size() == 0
        assert model.employeInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.employeInstance != null
    }

    void testSave() {
        controller.save()

        assert model.employeInstance != null
        assert view == '/employe/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/employe/show/1'
        assert controller.flash.message != null
        assert Employe.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/employe/list'

        populateValidParams(params)
        def employe = new Employe(params)

        assert employe.save() != null

        params.id = employe.id

        def model = controller.show()

        assert model.employeInstance == employe
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/employe/list'

        populateValidParams(params)
        def employe = new Employe(params)

        assert employe.save() != null

        params.id = employe.id

        def model = controller.edit()

        assert model.employeInstance == employe
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/employe/list'

        response.reset()

        populateValidParams(params)
        def employe = new Employe(params)

        assert employe.save() != null

        // test invalid parameters in update
        params.id = employe.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/employe/edit"
        assert model.employeInstance != null

        employe.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/employe/show/$employe.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        employe.clearErrors()

        populateValidParams(params)
        params.id = employe.id
        params.version = -1
        controller.update()

        assert view == "/employe/edit"
        assert model.employeInstance != null
        assert model.employeInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/employe/list'

        response.reset()

        populateValidParams(params)
        def employe = new Employe(params)

        assert employe.save() != null
        assert Employe.count() == 1

        params.id = employe.id

        controller.delete()

        assert Employe.count() == 0
        assert Employe.get(employe.id) == null
        assert response.redirectedUrl == '/employe/list'
    }
}
