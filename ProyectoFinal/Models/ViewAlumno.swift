//
//  ViewAlumno.swift
//  ProyectoFinal
//
//  Created by Raul Salinas on 12/10/23.
//

import Foundation

class ViewAlumno: ObservableObject {
    
    @Published var alumnos = [Alumno]()
    
    init() {
        let persistence = Persistence()
        self.alumnos = persistence.alumnos()
        
    }
}
