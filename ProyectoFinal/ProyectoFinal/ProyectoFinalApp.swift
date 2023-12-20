//
//  ProyectoFinalApp.swift
//  ProyectoFinal
//
//  Created by Raul Salinas on 12/8/23.
//

import SwiftUI

/// La estructura principal que representa la aplicación ProyectoFinal.
@main
struct ProyectoFinalApp: App {
    
    /// El objeto `ServiceMain` que gestiona la lógica principal de la aplicación.
    @StateObject var main = ServiceMain()
    
    /// Define la estructura de la interfaz de usuario de la aplicación.
    var body: some Scene {
        WindowGroup {
            /// La vista principal de la aplicación, alimentada por el ViewModel principal.
            HomeView().environmentObject(main.serviceVm.mainViewModel)
        }
    }
}
