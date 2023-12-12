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
                        NavigationLink(destination: AlumnoView( idRecord: alumno.id, record: alumno)) {
                               Text("\(alumno.name) \(alumno.lastname1) \(alumno.lastname2)")
                           }
                       }
                case "Grupos":
                    ForEach(viewModel.grupos) { grupo in
                        NavigationLink(destination: GrupoView(idRecord: grupo.id, record: grupo)) {
                            Text("\(grupo.id) (\(grupo.materia))")
                        }
                        
                    }
                case "Tarjetas":
                    ForEach(viewModel.tarjetas) { tarjeta in
                        NavigationLink(destination: TarjetaView( idRecord: tarjeta.id, record: tarjeta)) {
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
                    AnyView(GrupoView(idRecord: "", record: nil)) :
                    typeEntity == "Alumnos" ?
                    AnyView(AlumnoView(idRecord: "", record: nil)) :
                    AnyView(TarjetaView(idRecord: "", record: nil))
                ) {
                    Text("Crear")
                }
            )
        }
}

//#Preview {
//    EntityList(typeEntity: "Alumno", viewModel: <#ViewAlumno#>)
//}
