package com.tritem.cvcreator

import java.util.List;

class CurriculumVitae {

	String commentaire
	Employe employe
	String libellePoste
	List experiences
	List formations
	List competences
	
	Date dateCreated
	Date lastUpdated
	
	static hasMany=[competences:Competence, 
		experiences:Experience,
		formations:Formation]
	
    static constraints = {
		employe nullable:false
		libellePoste nullable:false
		dateCreated nullable:false
		lastUpdated nullable:true
		commentaire nullable:true
    }
	
	static mapping = {
		experiences indexColumn:"idx"
		formations indexColumn:"idx"
		sort dateCreated: "desc"
	}
	
	
	def getCompetencesTriees(){
		def compTriees = [:]
		TypeCompetence.list().each{
			compTriees.put(it.libelle, [])
		}
		competences.each {
			compTriees.get(it.typeCompetence.libelle).add(it)
		}
		return compTriees
	}
}

