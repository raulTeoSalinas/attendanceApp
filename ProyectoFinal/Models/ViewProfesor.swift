//
//  ViewProfesor.swift
//  ProyectoFinal
//
//  Created by Raul Salinas on 12/10/23.
//

import Foundation

class ViewProfesor: ObservableObject {
    
    @Published var profesores = [Profesor]()
    
    init() {
        let persistence = Persistence()
        self.profesores = persistence.profesores()
        
    }
}
