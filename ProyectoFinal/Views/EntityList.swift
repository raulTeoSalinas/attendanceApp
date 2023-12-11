//
//  EntityList.swift
//  ProyectoFinal
//
//  Created by Raul Salinas on 12/10/23.
//

import SwiftUI

struct EntityList: View {
    
    let typeEntity: String
    @StateObject var viewModel: ViewModel
    
    init(typeEntity: String, viewModel: ViewModel) {
        self.typeEntity = typeEntity
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
            List {
                switch typeEntity {
                case "Alumnos":
                    ForEach(viewModel.alumnos) { alumno in
                        NavigationLink(destination: RecordView(idRecord: alumno.id, record: alumno, viewModel: ViewModel())) {
                               Text("\(alumno.name) \(alumno.lastname1) \(alumno.lastname2)")
                           }
                       }
                case "Profesores":
                    ForEach(viewModel.profesores) { profesor in
                        NavigationLink(destination: RecordView(idRecord: profesor.id, record: profesor, viewModel: ViewModel())) {
                            Text("\(profesor.name) \(profesor.lastname1) \(profesor.lastname2)")
                        }
                    }
//                case "Materias":
//                    ForEach(viewModel.materias) { materia in
//                        Text("Materia: \(materia.name)")
//                    }
                default:
                    Text("Tipo de entidad no reconocido")
                }
            }
        }
}

//#Preview {
//    EntityList(typeEntity: "Alumno", viewModel: <#ViewAlumno#>)
//}
