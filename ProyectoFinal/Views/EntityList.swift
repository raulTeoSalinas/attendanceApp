//
//  EntityList.swift
//  ProyectoFinal
//
//  Created by Raul Salinas on 12/10/23.
//

import SwiftUI

struct EntityList: View {
    
    let typeEntity: String
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
            List {
                switch typeEntity {
                case "Alumnos":
                    ForEach(viewModel.alumnos) { alumno in
                        NavigationLink(destination: AlumnoView(alumno: alumno)) {
                               Text("\(alumno.name) \(alumno.lastname1) \(alumno.lastname2)")
                           }
                       }
                case "Grupos":
                    ForEach(viewModel.grupos) { grupo in
                        NavigationLink(destination: GrupoView(grupo: grupo)) {
                            Text("\(grupo.materia)")
                        }
                        
                    }
                case "Tarjetas":
                    ForEach(viewModel.tarjetas) { tarjeta in
                        NavigationLink(destination: TarjetaView( tarjeta: tarjeta)) {
                            Text("\(tarjeta.id)")
                        }
                        
                    }
                default:
                    Text("Tipo de entidad no reconocido")
                }
            }.navigationTitle(typeEntity)
            .navigationBarItems(
                trailing: NavigationLink(destination:
                    typeEntity == "Grupos" ?
                    AnyView(GrupoView(grupo: nil)) :
                    typeEntity == "Alumnos" ?
                    AnyView(AlumnoView(alumno: nil)) :
                    AnyView(TarjetaView(tarjeta: nil))
                ) {
                    Text("Crear")
                }
            )
        }
}
