package com.tritem.cvcreator

import org.apache.commons.collections.FactoryUtils
import org.apache.commons.collections.list.LazyList
import org.h2.table.IndexColumn;

class Experience {

	String periode
	String client
	List projets
	String htmlId
	boolean toDelete
	
    static constraints = {
		periode nullable:false
		client nullable:false
    }

	static hasMany=[projets:Projet]
	
	static belongTo = [curriculumVitae:CurriculumVitae]
	
	static mapping =  {
		projets indexColumn:"idx"
	}
	
	static transients = [ 'htmlId' ]
}
