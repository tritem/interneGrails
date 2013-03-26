package com.tritem.cvcreator

class BootstrapService {

    def initModele() {
		// initialisation des agences
		Agence niort = new Agence(nom:"Niort")
		niort.save(true)
		Agence nantes = new Agence(nom:"Nantes")
		nantes.save(true)
		Agence bordeaux = new Agence(nom:"Bordeaux")
		bordeaux.save(true)
		assert Agence.count==3
				
		// initialisation des Personnes
		Employe sebastien = new Employe(prenom:"Sebastien", nom:"Talmant", dateNaissance:new Date(), estDisponible:true)
		sebastien.agence = nantes
		println sebastien.validate()
		println sebastien.errors
		sebastien.save(true)
		Employe loic = new Employe(prenom:"Loïc", nom:"Cara", dateNaissance:new Date(), estDisponible:true)
		loic.agence = nantes
		loic.save(true)
		Employe thierry = new Employe(prenom:"Dimitri", nom:"Lucas", dateNaissance:new Date(), estDisponible:true)
		thierry.agence = nantes
		thierry.save(true)
		Employe dimitri = new Employe(prenom:"Thierry", nom:"Hugolin", dateNaissance:new Date(), estDisponible:true)
		dimitri.agence = nantes
		dimitri.save(true)
		assert Employe.count==4
		
		// initialisation des types de compétence
		TypeCompetence langageProgrammation = new TypeCompetence(libelle:"Langages de programmation")
		langageProgrammation.save(true)
		TypeCompetence framework = new TypeCompetence(libelle:"Frameworks, librairies")
		framework.save(true)
		TypeCompetence methode = new TypeCompetence(libelle:"Méthodes")
		methode.save(true)
		TypeCompetence outil = new TypeCompetence(libelle:"Outils")
		outil.save(true)
		TypeCompetence sgbd = new TypeCompetence(libelle:"SGBD")
		sgbd.save(true)
		TypeCompetence langue = new TypeCompetence(libelle:"Langues")
		langue.save(true)
		TypeCompetence connaissanceFonctionnelle = new TypeCompetence(libelle:"Compétences fonctionnelles")
		connaissanceFonctionnelle.save(true)
		assert TypeCompetence.count == 7
		
		// initialisation des compétences
		Competence compJava = new Competence(typeCompetence:langageProgrammation, libelle:"Java")
		compJava.save()
		Competence compJava5 = new Competence(typeCompetence:langageProgrammation, libelle:"Java 5")
		compJava5.save()
		Competence compJava6 = new Competence(typeCompetence:langageProgrammation, libelle:"Java 6")
		compJava6.save()
		Competence compJava7 = new Competence(typeCompetence:langageProgrammation, libelle:"Java 7")
		compJava7.save()
		Competence compGroovy = new Competence(typeCompetence:langageProgrammation, libelle:"Groovy")
		compGroovy.save()
		Competence compGroovy18 = new Competence(typeCompetence:langageProgrammation, libelle:"Groovy 1.8")
		compGroovy18.save()
		Competence compGroovy20 = new Competence(typeCompetence:langageProgrammation, libelle:"Groovy 2.0")
		compGroovy20.save()
		Competence compJavascript = new Competence(typeCompetence:langageProgrammation,  libelle:"Javascript")
		compJavascript.save()
		Competence compHTML = new Competence(typeCompetence:langageProgrammation,  libelle:"HTML")
		compHTML.save()
		Competence compHTML5 = new Competence(typeCompetence:langageProgrammation,  libelle:"HTML 5")
		compHTML5.save()
		Competence compCSS3 = new Competence(typeCompetence:langageProgrammation,  libelle:"CSS 3")
		compCSS3.save()
		Competence compC = new Competence(typeCompetence:langageProgrammation,  libelle:"C")
		compC.save()
		Competence compCplusplus = new Competence(typeCompetence:langageProgrammation,  libelle:"C++")
		compCplusplus.save()
		Competence compPHP = new Competence(typeCompetence:langageProgrammation,  libelle:"PHP")
		compPHP.save()
		Competence compCSharp = new Competence(typeCompetence:langageProgrammation,  libelle:"C#")
		compCSharp.save()
		assert Competence.count == 15
		
		Competence compGrails22 = new Competence(typeCompetence:framework, libelle:"Grails 2.2")
		compGrails22.save()
		assert Competence.count == 16	
		
		// initialisation des formations
//		Formation formation1 = new Formation(periode:"2000 - 2002", libelle:"Ecole de commerce", diplome:"Master 2 en commerce")
//		formation1.save(true)
//		Formation formation2 = new Formation(periode:"1998 - 2000", libelle:"Autre école", diplome:"Autre diplôme")
//		formation2.save(true)
//		assert Formation.count == 2
		
		// Initialisation des expériences
		Experience experience1 = new Experience(periode:"Août 2012 - Février 2013", libelle:"Tritem, Nantes :", poste:"Ingénieur Commercial")
		experience1.addToLignesExperience(new LigneExperience(exp:experience1, libelle:"l 11"))
		experience1.save()
		assert Experience.count == 1
		
		// initialisation d'un cv
		CurriculumVitae cvSebastienTalmant = new CurriculumVitae(employe: sebastien, libellePoste: "Commercial", dateCreated:new Date(), lastUpdated:null)
		cvSebastienTalmant.addToCompetences(compJava7)
		cvSebastienTalmant.addToCompetences(compJava6)
		cvSebastienTalmant.addToCompetences(compGroovy20)
		cvSebastienTalmant.addToCompetences(compGrails22)
		
		cvSebastienTalmant.addToExperiences(experience1)
		cvSebastienTalmant.addToFormations(new Formation(periode:"2000 - 2002", libelle:"Ecole de commerce", diplome:"Master 2 en commerce"))
		cvSebastienTalmant.addToFormations(new Formation(periode:"1998 - 2000", libelle:"Autre école", diplome:"Autre diplôme"))
		cvSebastienTalmant.save()
		
		assert CurriculumVitae.count == 1
    }
}
