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
                        NavigationLink(destination: RecordView(typeEntity: typeEntity, idRecord: alumno.id, record: alumno)) {
                               Text("\(alumno.name) \(alumno.lastname1) \(alumno.lastname2)")
                           }
                       }
                case "Profesores":
                    ForEach(viewModel.profesores) { profesor in
                        NavigationLink(destination: RecordView(typeEntity: typeEntity, idRecord: profesor.id, record: profesor)) {
                            Text("\(profesor.name) \(profesor.lastname1) \(profesor.lastname2)")
                        }
                    }
                case "Grupos":
                    ForEach(viewModel.grupos) { grupo in
                        NavigationLink(destination: GrupoView(idRecord: grupo.id, record: grupo)) {
                            Text("\(grupo.id) (\(grupo.materia))")
                        }
                        
                    }
                default:
                    Text("Tipo de entidad no reconocido")
                }
            }.navigationTitle(typeEntity)
            .navigationBarItems(
                trailing: NavigationLink(destination:
                    typeEntity == "Grupos" ?
                        AnyView(GrupoView(idRecord: "", record: nil)) :
                        AnyView(RecordView(typeEntity: typeEntity, idRecord: "", record: {}))
                ) {
                    Text("Crear")
                }
            )
        }
}

//#Preview {
//    EntityList(typeEntity: "Alumno", viewModel: <#ViewAlumno#>)
//}
