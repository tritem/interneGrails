package com.tritem.cvcreator

import java.util.List;

class CurriculumVitaeService {
	
	def executerToDelete(CurriculumVitae cv){
		// R�cup�ration de toutes les formations � supprimer
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
