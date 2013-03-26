package com.tritem.cvcreator

class CompetenceService {

    def getToutesCompetencesTriees() {
		def compTriees = [:]
		TypeCompetence.list().each{
			compTriees.put(it.libelle, [])
		}
		Competence.list().each {
			compTriees.get(it.typeCompetence.libelle).add(it)
		}
		return compTriees
    }
}
