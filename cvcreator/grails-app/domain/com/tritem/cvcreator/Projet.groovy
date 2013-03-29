package com.tritem.cvcreator

import java.util.List;

class Projet {
	
	String periode
	String poste
	String titre
	String description
	String competences
	String htmlId
	String htmlIdExperience
	boolean toDelete
	
	List lignesProjet
	static hasMany=[lignesProjet:LigneProjet]
	
	static constraints = {
		periode nullable:false
		description nullable:false
		poste nullable:false
		competences nullable:false
	}
	
	static belongsTo=[experience:Experience]
	
	static mapping =  {
		lignesProjet indexColumn:"idx"
	}
	
	static transients = [ 'htmlId', 'htmlIdExperience' ]
}
