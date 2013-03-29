package com.tritem.cvcreator

class LigneProjet {

	String libelle
	boolean toDelete
	String htmlIdProjet
	Long idTechnique
	int idxProjet
	
	static belongsTo=[projet:Projet]
	
	static transients = [ 'htmlIdProjet', 'idTechnique', 'idxProjet']
	
    static constraints = {
		libelle nullable:false
    }
	
	String toString(){
		return libelle
	}
}
