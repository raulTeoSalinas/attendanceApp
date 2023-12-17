//
//  EntityList.swift
//  ProyectoFinal
//
//  Created by Raul Salinas on 12/10/23.
//

import SwiftUI

struct EntityList: View {
    
    @EnvironmentObject var alumnoViewModel: AlumnoViewModel
    @EnvironmentObject var grupoViewModel: GrupoViewModel
    @EnvironmentObject var tarjetasViewModel: TarjetaViewModel
    
    let typeEntity: String
    
    var body: some View {
        List {
            switch typeEntity {
            case "Alumnos":
                ForEach(alumnoViewModel.alumnos) { alumno in
                    NavigationLink(destination: AlumnoView(alumno: alumno)) {
                        Text("\(alumno.name) \(alumno.lastname1) \(alumno.lastname2)")
                    }
                }
            case "Grupos":
                ForEach(grupoViewModel.grupos) { grupo in
                    NavigationLink(destination: GrupoView(grupo: grupo)) {
                        Text("\(grupo.materia)")
                    }
                    
                }
            case "Tarjetas":
                ForEach(tarjetasViewModel.tarjetas) { tarjeta in
                    NavigationLink(destination: TarjetaView( tarjeta: tarjeta)) {
                        Text("\(tarjeta.id)")
                    }
                    
                }
            case "Asistencia":
                ForEach(grupoViewModel.grupos) { grupo in
                    NavigationLink(destination: MenuAsistenciaView( grupoSelected: grupo)) {
                        Text("\(grupo.materia)")
                    }
                    
                }
            default:
                Text("Tipo de entidad no reconocido")
            }
        }.navigationTitle(typeEntity)
            .navigationBarItems(
                trailing: {
                    Group {
                        if typeEntity != "Asistencia" {
                            NavigationLink(destination:
                                typeEntity == "Grupos" ?
                                AnyView(GrupoView(grupo: nil)) :
                                typeEntity == "Alumnos" ?
                                AnyView(AlumnoView(alumno: nil)) :
                                AnyView(TarjetaView(tarjeta: nil))
                            ) {
                                Text("Crear")
                            }
                        } else {
                            EmptyView()
                        }
                    }
                }()
            )
    }
}
