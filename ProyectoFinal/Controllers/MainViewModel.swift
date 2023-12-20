//
//  ViewModel.swift
//  ProyectoFinal
//
//  Created by Raul Salinas on 12/10/23.
//

import Foundation
import GRDB

/// `MainViewModel` es una clase observable que agrupa los view models relacionados con diferentes entidades.
class MainViewModel: ObservableObject {
    
    /// El view model para la entidad Alumno.
    @Published var alumnoViewModel: AlumnoViewModel
    
    /// El view model para la entidad Grupo.
    @Published var grupoViewModel: GrupoViewModel
    
    /// El view model para la entidad Tarjeta.
    @Published var tarjetaViewModel: TarjetaViewModel
    
    /// El view model para la entidad Asistencia.
    @Published var asistenciaViewModel: AsistenciaViewModel
    
    /// Inicializa una nueva instancia de `MainViewModel`.
        ///
        /// - Parameters:
        ///   - alumnoViewmodel: El view model para la entidad Alumno.
        ///   - tarjetaViewmodel: El view model para la entidad Tarjeta.
        ///   - grupoViewmodel: El view model para la entidad Grupo.
        ///   - asistenciaViewmodel: El view model para la entidad Asistencia.
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
