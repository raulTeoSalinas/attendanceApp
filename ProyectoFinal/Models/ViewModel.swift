//
//  ViewModel.swift
//  ProyectoFinal
//
//  Created by Raul Salinas on 12/10/23.
//

import Foundation


class ViewModel: ObservableObject {
    
    @Published var alumnos = [Alumno]()
    @Published var profesores = [Profesor]()
    private let persistence: Persistence
    
    init() {
        self.persistence = Persistence()
        self.alumnos = persistence.alumnos()
        self.profesores = persistence.profesores()
        
    }
    
    func updateAlumno(withId id: String, record: Alumno) {
        persistence.updateAlumno(withId: id, record: record)
        // Actualizar la lista de alumnos después de la modificación en la base de datos
        self.alumnos = persistence.alumnos()
    }
    
    func updateProfesor(withId id: String, record: Profesor) {
        persistence.updateProfesor(withId: id, record: record)
        // Actualizar la lista de profesores después de la modificación en la base de datos
        self.profesores = persistence.profesores()
    }
    
    func deleteAlumno(withId id: String){
        persistence.deleteAlumno(withId: id)
        self.alumnos = persistence.alumnos()
    }
    
    func deleteProfesor(withId id: String){
        persistence.deleteProfesor(withId: id)
        self.profesores = persistence.profesores()
    }
    
    func createAlumno(alumno: Alumno){
        persistence.createAlumno(alumno: alumno)
        self.alumnos = persistence.alumnos()
    }
    
    func createProfesor(profesor: Profesor){
        persistence.createProfesor(profesor: profesor)
        self.profesores = persistence.profesores()
    }
}
