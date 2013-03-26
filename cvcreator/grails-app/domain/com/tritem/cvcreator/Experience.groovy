package com.tritem.cvcreator

import org.apache.commons.collections.FactoryUtils
import org.apache.commons.collections.list.LazyList
import org.h2.table.IndexColumn;

class Experience {

	String periode
	String libelle
	String poste
	String htmlId
	boolean toDelete
	
    static constraints = {
		periode nullable:false
		libelle nullable:false
		poste nullable:false
    }

	List lignesExperience
	static hasMany=[lignesExperience:LigneExperience]
	
	static belongTo = [curriculumVitae:CurriculumVitae]
	
	static mapping =  {
		lignesExperience indexColumn:"idx"
	}
	
	static transients = [ 'htmlId' ]
}
