//
//  Pelicula.swift
//  ejercicio_peliculas
//
//  Created by Carlos Alfredo Call on 21/11/25.
//

import UIKit

class Pelicula {
    var titulo: String
    var caratula: String
    var fecha: String
    var descripcion: String?

    init(titulo: String, caratula: String, fecha: String, descripcion: String?) {
        self.titulo = titulo
        self.caratula = caratula
        self.fecha = fecha
        self.descripcion = descripcion
    }
}
