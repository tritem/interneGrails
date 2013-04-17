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
	Long idTechnique
	int idxExp
	boolean toDelete
	
	List lignesProjet
	static hasMany=[lignesProjet:LigneProjet]
	
	static constraints = {
		periode nullable:true
		poste nullable:true
		titre nullable:true 
		description nullable:true
		competences nullable:true
	}
	
	static belongsTo=[experience:Experience]
	
	static mapping =  {
		lignesProjet indexColumn:"idx"
	}
	
	static transients = [ 'htmlId', 'htmlIdExperience', 'idTechnique', 'idxExp']
	
	String toString(){
		return "id[${id}] periode[${periode}] poste[${poste}] titre[${titre}]"
	}
}
