package com.tritem.cvcreator

import java.util.List;

class CurriculumVitaeService {
	
	def executerToDelete(CurriculumVitae cv){
		// Récupération de toutes les formations à supprimer
		cv.formations.removeAll{
			it.toDelete
		}
		
		cv.experiences.removeAll{
			it.toDelete
		}
		
		cv.experiences.each {
			it.lignesExperience.removeAll{
				it.toDelete
			}
		}
		
		cv.save(true)		
	}
}
