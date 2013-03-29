package com.tritem.cvcreator

class Formation {

	String periode
	String libelle
	
	boolean toDelete
	
	static belongsTo=[curriculumVitae:CurriculumVitae]
	
	static transients = [ 'htmlIdExperience' ]
	
    static constraints = {
    }
}
