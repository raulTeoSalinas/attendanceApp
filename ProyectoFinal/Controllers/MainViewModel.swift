//
//  ViewModel.swift
//  ProyectoFinal
//
//  Created by Raul Salinas on 12/10/23.
//

import Foundation
import GRDB

class MainViewModel: ObservableObject {
    
    @Published var alumnoViewModel: AlumnoViewModel
    @Published var grupoViewModel: GrupoViewModel
    @Published var tarjetaViewModel: TarjetaViewModel
    @Published var asistenciaViewModel: AsistenciaViewModel
    
    init(
        alumnoViewmodel: AlumnoViewModel,
        tarjetaViewmodel: TarjetaViewModel,
        grupoViewmodel: GrupoViewModel,
        asistenciaViewmodel: AsistenciaViewModel
    ) {
        self.alumnoViewModel = alumnoViewmodel
        self.grupoViewModel = grupoViewmodel
        self.tarjetaViewModel = tarjetaViewmodel
        self.asistenciaViewModel = asistenciaViewmodel
    
    }

    
}
