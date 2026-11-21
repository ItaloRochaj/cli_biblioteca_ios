//
//  Livro.swift
//  cli_biblioteca_ios
//
//  Created by Italo Rocha on 19/11/26.
//

import Foundation

class Livro: Documento {

    // MARK: - Propriedades

    let id: Int

    private(set) var titulo: String
    private(set) var autor: String
    private(set) var anoPublicacao: Int
    private(set) var isEmprestado: Bool

    // MARK: - Inicializador

    init(
        id: Int,
        titulo: String,
        autor: String,
        anoPublicacao: Int,
        isEmprestado: Bool = false
    ) {
        self.id = id
        self.titulo = titulo
        self.autor = autor
        self.anoPublicacao = anoPublicacao
        self.isEmprestado = isEmprestado
    }

    // MARK: - Atualização dos dados

    func atualizarDados(
        titulo: String,
        autor: String,
        anoPublicacao: Int
    ) {
        self.titulo = titulo
        self.autor = autor
        self.anoPublicacao = anoPublicacao
    }

    // MARK: - Empréstimo

    func emprestar() -> Bool {
        guard !isEmprestado else {
            return false
        }

        isEmprestado = true
        return true
    }

    // MARK: - Devolução

    func devolver() -> Bool {
        guard isEmprestado else {
            return false
        }

        isEmprestado = false
        return true
    }

    // MARK: - Exibição

    func exibirDetalhes() {
        let status = isEmprestado
            ? "Emprestado"
            : "Disponível"

        print(
            """
            
            ----------------------------------------
            ID: \(id)
            Título: \(titulo)
            Autor: \(autor)
            Ano de publicação: \(anoPublicacao)
            Status: \(status)
            Tipo: Livro físico
            ----------------------------------------
            """
        )
    }
}
