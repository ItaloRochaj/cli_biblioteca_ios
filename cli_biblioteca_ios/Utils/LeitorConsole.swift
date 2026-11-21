//
//  LeitorConsole.swift
//  cli_biblioteca_ios
//
//  Created by Italo Rocha on 19/11/26.
//

import Foundation

struct LeitorConsole {

    // MARK: - Leitura de String

    static func lerTexto(
        mensagem: String,
        permitirVazio: Bool = false
    ) -> String {
        while true {
            print(mensagem, terminator: "")

            guard let entrada = readLine() else {
                print("Não foi possível ler a entrada.")
                continue
            }

            let valor = entrada.trimmingCharacters(
                in: .whitespacesAndNewlines
            )

            if permitirVazio || !valor.isEmpty {
                return valor
            }

            print("O valor não pode ficar vazio.")
        }
    }

    // MARK: - Leitura de Int

    static func lerInt(
        mensagem: String,
        minimo: Int? = nil
    ) -> Int {
        while true {
            let entrada = lerTexto(mensagem: mensagem)

            guard let valor = Int(entrada) else {
                print("Digite um número inteiro válido.")
                continue
            }

            if let minimo, valor < minimo {
                print(
                    "Digite um número maior ou igual a \(minimo)."
                )
                continue
            }

            return valor
        }
    }

    // MARK: - Leitura de Double

    static func lerDouble(
        mensagem: String,
        minimo: Double? = nil
    ) -> Double {
        while true {
            let entrada = lerTexto(mensagem: mensagem)
                .replacingOccurrences(
                    of: ",",
                    with: "."
                )

            guard let valor = Double(entrada) else {
                print("Digite um número decimal válido.")
                continue
            }

            if let minimo, valor < minimo {
                print(
                    "Digite um número maior ou igual a \(minimo)."
                )
                continue
            }

            return valor
        }
    }

    // MARK: - Leitura de confirmação

    static func lerSimOuNao(
        mensagem: String
    ) -> Bool {
        while true {
            let resposta = lerTexto(
                mensagem: mensagem
            ).lowercased()

            switch resposta {
            case "s", "sim":
                return true

            case "n", "nao", "não":
                return false

            default:
                print("Digite S para sim ou N para não.")
            }
        }
    }
}
