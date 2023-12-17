//
//  ProyectoFinalApp.swift
//  ProyectoFinal
//
//  Created by Raul Salinas on 12/8/23.
//

import SwiftUI

@main
struct ProyectoFinalApp: App {
    
    @StateObject var main = ServiceMain()
    
    var body: some Scene {
        WindowGroup {
            HomeView().environmentObject(main.serviceVm.mainViewModel)
        }
    }
}
