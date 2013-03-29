package com.tritem.cvcreator

import java.util.List;

class CurriculumVitaeService {
	
	def executerToDelete(CurriculumVitae cv){
		cv.formations.findAll{it.toDelete}.each {Formation formation ->
			cv.removeFromFormations(formation)
			formation.delete()
		}
		
		cv.experiences.findAll{it.toDelete}.each {Experience experience ->
			cv.removeFromExperiences(experience)
			experience.delete()
		}
		
		cv.experiences.each {Experience experience ->
			experience.lignesExperience.findAll{it.toDelete}.each {LigneProjet ligneExperience ->
				experience.removeFromLignesExperience(ligneExperience)
				ligneExperience.delete()
			}
		}

		cv.save(true)
	}
}
