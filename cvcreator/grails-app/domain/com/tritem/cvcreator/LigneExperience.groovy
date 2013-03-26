package com.tritem.cvcreator

class LigneExperience {

	String libelle
	boolean toDelete
	String htmlIdExperience
	Long idTechnique
	int idxExp
	
	static belongsTo=[experience:Experience]
	
	static transients = [ 'htmlIdExperience', 'idTechnique', 'idxExp']
	
    static constraints = {
		libelle nullable:false
    }
	
	String toString(){
		return libelle
	}
}
