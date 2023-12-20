//
//  ServiceViewModels.swift
//  ProyectoFinal
//
//  Created by Cristian Cardoso on 12/12/23.
//

import Foundation

/// `ServiceViewModels` es una clase que agrupa y gestiona los distintos view models relacionados con el servicio y la persistencia.
class ServiceViewModels {
    
    /// El servicio de persistencia utilizado por los view models.
    var servicePersistence: ServicePersistence
    /// El view model principal que contiene subview models para diferentes entidades.
    var mainViewModel: MainViewModel

    /// Inicializa una nueva instancia de `ServiceViewModels`.
        ///
        /// - Parameter servicePersistence: El servicio de persistencia a utilizar.
    init(servicePersistence: ServicePersistence) {
        self.servicePersistence = servicePersistence
        /// Se crean los view models para las distintas entidades y se pasan los DAO correspondientes.
        let alumnoViewModel = AlumnoViewModel(alumnosDAO: AlumnoDAO(persistence: servicePersistence.persistence))
        let grupoViewModel = GrupoViewModel(grupoDAO: GrupoDAO(persistence: servicePersistence.persistence))
        let tarjetaViewModel = TarjetaViewModel(tarjetaDAO: TarjetaDAO(persistence: servicePersistence.persistence))
        let asistenciaViewModel = AsistenciaViewModel(asistenciaDAO: AsistenciaDAO(persistence: servicePersistence.persistence))
        /// Se inicializa el view model principal con los subview models creados.
        mainViewModel = MainViewModel(alumnoViewmodel: alumnoViewModel, tarjetaViewmodel: tarjetaViewModel, grupoViewmodel: grupoViewModel, asistenciaViewmodel: asistenciaViewModel)
        
    }
}
