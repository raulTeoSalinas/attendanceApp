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
}
