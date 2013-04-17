package com.tritem.cvcreator

class Employe {

	String nom
	String prenom
	Date dateNaissance
	boolean estDisponible
	Agence agence
	TypeEmploye typeEmploye
	
    static constraints = {
		nom nullable:false
		prenom nullable:false
		dateNaissance nullable:false
    }
}
