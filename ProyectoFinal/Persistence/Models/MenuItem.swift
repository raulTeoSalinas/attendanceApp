//
//  MenuItem.swift
//  ProyectoFinal
//
//  Created by Raul Salinas on 12/10/23.
//

import Foundation

/// Esta es una estructura la cual nos permite crear elementos del menu para pasarlos por un componente `List`.
struct MenuItem: Identifiable {
    var id = UUID()
    var name: String
}
