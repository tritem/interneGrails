package com.tritem.cvcreator

class Formation {

	String periode
	String libelle
	String diplome
	
	boolean toDelete
	
	static belongsTo=[curriculumVitae:CurriculumVitae]
	
	static transients = [ 'htmlIdExperience' ]
	
    static constraints = {
    }
}
