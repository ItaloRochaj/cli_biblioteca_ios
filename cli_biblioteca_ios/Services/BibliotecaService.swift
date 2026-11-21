//
//  Biblioteca.swift
//  cli_biblioteca_ios
//
//  Created by Italo Rocha on 19/11/26.
//

import Foundation

/// Serviço/gerenciador responsável por manter o acervo de livros em memória
final class Biblioteca {

    // MARK: - Armazenamento
    private var livros: [Livro] = []

    // MARK: - Create
    /// Cadastra um novo livro, garantindo que o ID não esteja duplicado
    /// - Returns: true se cadastrou com sucesso; false se ID já existe
    @discardableResult
    func cadastrar(livro: Livro) -> Bool {
        guard buscarPorID(livro.id) == nil else {
            return false
        }
        livros.append(livro)
        return true
    }

    // MARK: - Read (Listar/Buscar)
    /// Lista todos os livros cadastrados, imprimindo detalhes no console
    func listarTodos() {
        if livros.isEmpty {
            print("\nNenhum livro cadastrado no momento.\n")
            return
        }
        livros.forEach { $0.exibirDetalhes() }
    }

    /// Busca um livro por ID
    func buscarPorID(_ id: Int) -> Livro? {
        return livros.first(where: { $0.id == id })
    }

    /// Busca livros cujo título contém o termo informado (case-insensitive)
    func buscarPorTitulo(contem termo: String) -> [Livro] {
        let termoLower = termo.lowercased()
        return livros.filter { $0.titulo.lowercased().contains(termoLower) }
    }

    // MARK: - Update
    /// Atualiza campos básicos do livro
    /// - Returns: true se atualizou; false se ID não encontrado
    @discardableResult
    func atualizar(id: Int, novoTitulo: String?, novoAutor: String?, novoAno: Int?) -> Bool {
        guard let index = livros.firstIndex(where: { $0.id == id }) else {
            return false
        }
        let livro = livros[index]
        let titulo = novoTitulo ?? livro.titulo
        let autor = novoAutor ?? livro.autor
        let ano = novoAno ?? livro.anoPublicacao
        livro.atualizarDados(titulo: titulo, autor: autor, anoPublicacao: ano)
        return true
    }

    // MARK: - Delete
    /// Remove um livro pelo ID
    /// - Returns: true se removeu; false se não encontrado
    @discardableResult
    func remover(id: Int) -> Bool {
        guard let index = livros.firstIndex(where: { $0.id == id }) else {
            return false
        }
        livros.remove(at: index)
        return true
    }

    // MARK: - Empréstimos
    /// Tenta emprestar um livro pelo ID
    /// - Returns: true se emprestou; false se não encontrado ou já emprestado
    @discardableResult
    func emprestar(id: Int) -> Bool {
        guard let livro = buscarPorID(id) else { return false }
        return livro.emprestar()
    }

    /// Tenta devolver um livro pelo ID
    /// - Returns: true se devolveu; false se não encontrado ou já disponível
    @discardableResult
    func devolver(id: Int) -> Bool {
        guard let livro = buscarPorID(id) else { return false }
        return livro.devolver()
    }
}

// MARK: - Resumo da biblioteca
extension Biblioteca {
    func exibirResumo() {
        print("\n===== RESUMO DA BIBLIOTECA =====")
        print("Funcionalidade de resumo em desenvolvimento.")
        print("================================")
    }
}
