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
			experience.projets.findAll{it.toDelete}.each {Projet projet ->
				experience.removeFromProjets(projet)
				projet.delete()
			}
		}
		cv.experiences.each {Experience experience ->
			experience.projets.each {Projet projet ->
				projet.lignesProjet.findAll {it.toDelete}.each {LigneProjet ligneProjet ->
					projet.removeFromLignesProjet(ligneProjet)
					ligneProjet.delete()
				}
			}
		}
		
		cv.save(true)
	}
}
