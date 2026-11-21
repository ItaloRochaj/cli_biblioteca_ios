//
//  Biblioteca.swift
//  ProjetoBiblioteca
//
//  Created by Assistant on 2026-11-19.
//

import Foundation

final class BibliotecaApp {

    // MARK: - Dependências

    private let biblioteca: Biblioteca
    private var executando: Bool

    // MARK: - Inicializador

    init(biblioteca: Biblioteca = Biblioteca()) {
        self.biblioteca = biblioteca
        self.executando = true
    }

    // MARK: - Iniciar aplicação

    func iniciar() {
        print(
            """
            
            ========================================
               SISTEMA DE GERENCIAMENTO DE BIBLIOTECA
            ========================================
            """
        )

        while executando {
            exibirMenu()

            let opcao = LeitorConsole.lerInt(
                mensagem: "Escolha uma opção: "
            )

            executarOpcao(opcao)
        }
    }

    // MARK: - Menu principal

    private func exibirMenu() {
        print(
            """
            
            ================ MENU ================
            1 - Cadastrar livro
            2 - Listar todos os livros
            3 - Buscar livro
            4 - Editar livro
            5 - Remover livro
            6 - Exibir resumo
            0 - Sair
            ======================================
            """
        )
    }

    // MARK: - Controle do menu

    private func executarOpcao(_ opcao: Int) {
        switch opcao {
        case 1:
            cadastrarLivro()

        case 2:
            biblioteca.listarTodos()

        case 3:
            exibirMenuBusca()

        case 4:
            editarLivro()

        case 5:
            removerLivro()

        case 6:
            biblioteca.exibirResumo()

        case 0:
            encerrar()

        default:
            print(
                "Opção inválida. Escolha uma opção entre 0 e 6."
            )
        }
    }

    // MARK: - Cadastrar

    private func cadastrarLivro() {
        print("\n===== CADASTRAR LIVRO =====")

        let id = LeitorConsole.lerInt(
            mensagem: "ID: ",
            minimo: 1
        )

        guard biblioteca.buscarPorID(id) == nil else {
            print(
                "Já existe um livro cadastrado com o ID \(id)."
            )
            return
        }

        let titulo = LeitorConsole.lerTexto(
            mensagem: "Título: "
        )

        let autor = LeitorConsole.lerTexto(
            mensagem: "Autor: "
        )

        let anoPublicacao = LeitorConsole.lerInt(
            mensagem: "Ano de publicação: ",
            minimo: 1
        )

        let isDigital = LeitorConsole.lerSimOuNao(
            mensagem: "É um livro digital? (S/N): "
        )

        let livro: Livro

        if isDigital {
            let tamanhoEmMB = LeitorConsole.lerDouble(
                mensagem: "Tamanho do arquivo em MB: ",
                minimo: 0.01
            )

            livro = LivroDigital(
                id: id,
                titulo: titulo,
                autor: autor,
                anoPublicacao: anoPublicacao,
                tamanhoEmMB: tamanhoEmMB
            )
        } else {
            livro = Livro(
                id: id,
                titulo: titulo,
                autor: autor,
                anoPublicacao: anoPublicacao
            )
        }

        if biblioteca.cadastrar(livro) {
            print("Livro cadastrado com sucesso.")
        } else {
            print("Não foi possível cadastrar o livro.")
        }
    }

    // MARK: - Busca

    private func exibirMenuBusca() {
        print(
            """
            
            ===== BUSCAR LIVRO =====
            1 - Buscar por ID
            2 - Buscar por título
            0 - Voltar
            """
        )

        let opcao = LeitorConsole.lerInt(
            mensagem: "Escolha uma opção: "
        )

        switch opcao {
        case 1:
            buscarLivroPorID()

        case 2:
            buscarLivroPorTitulo()

        case 0:
            return

        default:
            print("Opção de busca inválida.")
        }
    }

    private func buscarLivroPorID() {
        let id = LeitorConsole.lerInt(
            mensagem: "Digite o ID do livro: ",
            minimo: 1
        )

        guard let livro = biblioteca.buscarPorID(id) else {
            print("Livro não encontrado.")
            return
        }

        livro.exibirDetalhes()
    }

    private func buscarLivroPorTitulo() {
        let titulo = LeitorConsole.lerTexto(
            mensagem: "Digite o título ou parte dele: "
        )

        let livrosEncontrados = biblioteca.buscarPorTitulo(
            titulo
        )

        guard !livrosEncontrados.isEmpty else {
            print("Nenhum livro foi encontrado.")
            return
        }

        print(
            "\nForam encontrados \(livrosEncontrados.count) livro(s)."
        )

        for livro in livrosEncontrados {
            livro.exibirDetalhes()
        }
    }

    // MARK: - Editar

    private func editarLivro() {
        print("\n===== EDITAR LIVRO =====")

        let id = LeitorConsole.lerInt(
            mensagem: "Digite o ID do livro: ",
            minimo: 1
        )

        guard let livro = biblioteca.buscarPorID(id) else {
            print("Livro não encontrado.")
            return
        }

        livro.exibirDetalhes()

        exibirMenuEdicao()

        let opcao = LeitorConsole.lerInt(
            mensagem: "Escolha uma opção: "
        )

        executarOpcaoEdicao(
            opcao,
            livro: livro
        )
    }

    private func exibirMenuEdicao() {
        print(
            """
            
            ===== OPÇÕES DE EDIÇÃO =====
            1 - Alterar título, autor e ano
            2 - Emprestar livro
            3 - Devolver livro
            4 - Alterar tamanho do livro digital
            0 - Cancelar
            """
        )
    }

    private func executarOpcaoEdicao(
        _ opcao: Int,
        livro: Livro
    ) {
        switch opcao {
        case 1:
            alterarDadosDoLivro(livro)

        case 2:
            emprestarLivro(livro)

        case 3:
            devolverLivro(livro)

        case 4:
            alterarTamanhoDoLivroDigital(livro)

        case 0:
            print("Edição cancelada.")

        default:
            print("Opção de edição inválida.")
        }
    }

    private func alterarDadosDoLivro(_ livro: Livro) {
        let novoTitulo = LeitorConsole.lerTexto(
            mensagem: "Novo título: "
        )

        let novoAutor = LeitorConsole.lerTexto(
            mensagem: "Novo autor: "
        )

        let novoAno = LeitorConsole.lerInt(
            mensagem: "Novo ano de publicação: ",
            minimo: 1
        )

        livro.atualizarDados(
            titulo: novoTitulo,
            autor: novoAutor,
            anoPublicacao: novoAno
        )

        print("Dados do livro atualizados com sucesso.")
    }

    private func emprestarLivro(_ livro: Livro) {
        if livro.emprestar() {
            print("Empréstimo realizado com sucesso.")
        } else {
            print("O livro já está emprestado.")
        }
    }

    private func devolverLivro(_ livro: Livro) {
        if livro.devolver() {
            print("Devolução realizada com sucesso.")
        } else {
            print("O livro já está disponível.")
        }
    }

    private func alterarTamanhoDoLivroDigital(
        _ livro: Livro
    ) {
        guard let livroDigital = livro as? LivroDigital else {
            print(
                "Essa opção está disponível somente para livros digitais."
            )
            return
        }

        let novoTamanho = LeitorConsole.lerDouble(
            mensagem: "Digite o novo tamanho em MB: ",
            minimo: 0.01
        )

        if livroDigital.atualizarTamanho(novoTamanho) {
            print("Tamanho atualizado com sucesso.")
        } else {
            print("O tamanho informado é inválido.")
        }
    }

    // MARK: - Remover

    private func removerLivro() {
        print("\n===== REMOVER LIVRO =====")

        let id = LeitorConsole.lerInt(
            mensagem: "Digite o ID do livro: ",
            minimo: 1
        )

        guard let livro = biblioteca.buscarPorID(id) else {
            print("Livro não encontrado.")
            return
        }

        livro.exibirDetalhes()

        let confirmar = LeitorConsole.lerSimOuNao(
            mensagem: "Confirma a remoção? (S/N): "
        )

        guard confirmar else {
            print("Remoção cancelada.")
            return
        }

        if biblioteca.remover(id: id) {
            print("Livro removido com sucesso.")
        } else {
            print("Não foi possível remover o livro.")
        }
    }

    // MARK: - Encerrar

    private func encerrar() {
        executando = false

        print(
            """
            
            Programa encerrado.
            Obrigado por utilizar o sistema!
            """
        )
    }
}
