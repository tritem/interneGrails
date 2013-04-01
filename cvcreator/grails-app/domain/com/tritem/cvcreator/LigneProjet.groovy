package com.tritem.cvcreator

class LigneProjet {

	String libelle
	boolean toDelete
	String htmlIdProjet
	String htmlId
	Long idTechnique
	int idxProjet
	
	static belongsTo=[projet:Projet]
	
	static transients = [ 'htmlIdProjet', 'idTechnique', 'idxProjet', 'htmlId']
	
    static constraints = {
		libelle nullable:false
    }
	
	String toString(){
		return libelle
	}
}
