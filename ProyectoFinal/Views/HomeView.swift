//
//  ContentView.swift
//  ProyectoFinal
//
//  Created by Raul Salinas on 12/8/23.
//

import SwiftUI

/// `HomeView` es una vista principal que muestra un menú de opciones para gestionar entidades y asistencias en un sistema escolar.
struct HomeView: View {
    
    /// Menú de opciones CRUD para gestionar entidades como Alumnos, Tarjetas y Grupos.
    let menuItemsCrud: [MenuItem] = [
            MenuItem(name: "Alumnos"),
            MenuItem(name: "Tarjetas"),
            MenuItem(name: "Grupos")
    ]
    /// Menú de opciones para gestionar asistencias.
    let menuItemsAsistencia: [MenuItem] = [
            MenuItem(name: "Asistencia"),
    ]
   
    var body: some View {
        NavigationStack {
            List{
                Section(header: Text("CRUD")) {
                    ForEach(menuItemsCrud) { menuItem in
                        NavigationLink(destination: EntityList(typeEntity: menuItem.name)){
                            Text(menuItem.name)
                                .padding()
                                .foregroundColor(.white)
                            
                        }
                        .listRowBackground(Color(red: 0.44, green: 0.27, blue: 0.96))
                        .listRowSeparatorTint(.white)
                        
                        
                    }
                }
                Section(header: Text("Asistencias")) {
                    ForEach(menuItemsAsistencia) { menuItem in
                        NavigationLink(destination: EntityList(typeEntity: menuItem.name)){
                            
                            Text(menuItem.name)
                                .padding()
                                .foregroundColor(.white)
                            
                        }
                        .listRowBackground(Color(red: 0.44, green: 0.27, blue: 0.96))
                        .listRowSeparatorTint(.white)
                        
                        
                    }
                }
                .navigationTitle("Sistema Escolar")
                
            }
        }
    }
}
