package com.tritem.cvcreator



import org.junit.*
import grails.test.mixin.*

@TestFor(CurriculumVitaeController)
@Mock(CurriculumVitae)
class CurriculumVitaeControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/curriculumVitae/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.curriculumVitaeInstanceList.size() == 0
        assert model.curriculumVitaeInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.curriculumVitaeInstance != null
    }

    void testSave() {
        controller.save()

        assert model.curriculumVitaeInstance != null
        assert view == '/curriculumVitae/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/curriculumVitae/show/1'
        assert controller.flash.message != null
        assert CurriculumVitae.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/curriculumVitae/list'

        populateValidParams(params)
        def curriculumVitae = new CurriculumVitae(params)

        assert curriculumVitae.save() != null

        params.id = curriculumVitae.id

        def model = controller.show()

        assert model.curriculumVitaeInstance == curriculumVitae
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/curriculumVitae/list'

        populateValidParams(params)
        def curriculumVitae = new CurriculumVitae(params)

        assert curriculumVitae.save() != null

        params.id = curriculumVitae.id

        def model = controller.edit()

        assert model.curriculumVitaeInstance == curriculumVitae
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/curriculumVitae/list'

        response.reset()

        populateValidParams(params)
        def curriculumVitae = new CurriculumVitae(params)

        assert curriculumVitae.save() != null

        // test invalid parameters in update
        params.id = curriculumVitae.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/curriculumVitae/edit"
        assert model.curriculumVitaeInstance != null

        curriculumVitae.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/curriculumVitae/show/$curriculumVitae.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        curriculumVitae.clearErrors()

        populateValidParams(params)
        params.id = curriculumVitae.id
        params.version = -1
        controller.update()

        assert view == "/curriculumVitae/edit"
        assert model.curriculumVitaeInstance != null
        assert model.curriculumVitaeInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/curriculumVitae/list'

        response.reset()

        populateValidParams(params)
        def curriculumVitae = new CurriculumVitae(params)

        assert curriculumVitae.save() != null
        assert CurriculumVitae.count() == 1

        params.id = curriculumVitae.id

        controller.delete()

        assert CurriculumVitae.count() == 0
        assert CurriculumVitae.get(curriculumVitae.id) == null
        assert response.redirectedUrl == '/curriculumVitae/list'
    }
}
