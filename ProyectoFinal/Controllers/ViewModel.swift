//
//  ViewModel.swift
//  ProyectoFinal
//
//  Created by Raul Salinas on 12/10/23.
//

import Foundation


class ViewModel: ObservableObject {
    
    @Published var alumnos = [Alumno]()

    @Published var grupos = [Grupo]()
    @Published var tarjetas = [Tarjeta]()
    private let persistence: Persistence
    
    init() {
        self.persistence = Persistence()
        self.alumnos = persistence.alumnos()
        self.grupos = persistence.grupos()
        self.tarjetas = persistence.tarjetas()
    }
    
    func updateAlumno(withId id: String, record: Alumno) {
        persistence.updateAlumno(withId: id, record: record)
        // Actualizar la lista de alumnos después de la modificación en la base de datos
        self.alumnos = persistence.alumnos()
    }
    
    func updateGrupo(withId id: String, record: Grupo) {
        persistence.updateGrupo(withId: id, record: record)
        // Actualizar la lista de grupos después de la modificación en la base de datos
        self.grupos = persistence.grupos()
    }
    
    func deleteAlumno(withId id: String){
        persistence.deleteAlumno(withId: id)
        self.alumnos = persistence.alumnos()
    }
    
    func deleteGrupo(withId id: String){
        persistence.deleteGrupo(withId: id)
        self.grupos = persistence.grupos()
    }
    
    func createAlumno(alumno: Alumno){
        persistence.createAlumno(alumno: alumno)
        self.alumnos = persistence.alumnos()
    }
    
    func createGrupo(grupo: Grupo){
        persistence.createGrupo(grupo: grupo)
        self.grupos = persistence.grupos()
    }
}
