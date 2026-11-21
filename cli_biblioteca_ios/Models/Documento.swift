//
//  Documento.swift
//  cli_biblioteca_ios
//
//  Created by Italo Rocha on 19/11/26.
//

import Foundation

protocol Documento {
    var id: Int { get }

    func exibirDetalhes()
}
