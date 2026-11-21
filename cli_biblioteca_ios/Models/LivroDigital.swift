//
//  LivroDigital.swift
//  cli_biblioteca_ios
//
//  Created by Italo Rocha on 19/11/26.
//

import Foundation

final class LivroDigital: Livro {

    // MARK: - Propriedade

    private(set) var tamanhoEmMB: Double

    // MARK: - Inicializador

    init(
        id: Int,
        titulo: String,
        autor: String,
        anoPublicacao: Int,
        tamanhoEmMB: Double,
        isEmprestado: Bool = false
    ) {
        self.tamanhoEmMB = tamanhoEmMB

        super.init(
            id: id,
            titulo: titulo,
            autor: autor,
            anoPublicacao: anoPublicacao,
            isEmprestado: isEmprestado
        )
    }

    // MARK: - Atualização do tamanho

    func atualizarTamanho(_ novoTamanho: Double) -> Bool {
        guard novoTamanho > 0 else {
            return false
        }

        tamanhoEmMB = novoTamanho
        return true
    }

    // MARK: - Sobrescrita

    override func exibirDetalhes() {
        let status = isEmprestado
            ? "Emprestado"
            : "Disponível"

        let tamanhoFormatado = String(
            format: "%.2f",
            tamanhoEmMB
        )

        print(
            """
            
            ----------------------------------------
            ID: \(id)
            Título: \(titulo)
            Autor: \(autor)
            Ano de publicação: \(anoPublicacao)
            Status: \(status)
            Tipo: Livro digital
            Tamanho: \(tamanhoFormatado) MB
            ----------------------------------------
            """
        )
    }
}
