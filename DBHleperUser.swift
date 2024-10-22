//
//  DBHleperUser.swift
//  ToolApp
//
//  Created by Elisio Simao on 1/1/01.
//  Copyright © 2001 Martinho Macovere. All rights reserved.
//

import Foundation
import SQLite3
import UIKit

class DBHleperUser {
    
    var db: OpaquePointer?
    
    init() {
        db = openDatabase()
        createTable()
    }
    
    // Função para abrir/criar o banco de dados
    func openDatabase() -> OpaquePointer? {
        var db: OpaquePointer? = nil
        let fileURL = try! FileManager.default
            .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("usuariosTo.sqlite")
        
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("Erro ao abrir o banco de dados")
            return nil
        } else {
            print("Banco de dados aberto com sucesso")
            return db
        }
    }
    
    // Função para criar a tabela Usuario
    func createTable() {
        let createTableQuery = """
        CREATE TABLE IF NOT EXISTS Usuario(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        email TEXT,
        senha TEXT,
        dataNac TEXT,
        nomeCompleto TEXT,
        genero TEXT,
        morada TEXT,
        telefone TEXT,
        nomeFerramenta TEXT DEFAULT 'none',
        precoFerramenta REAL DEFAULT 0.0
        );
        """
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableQuery, -1, &createTableStatement, nil) == SQLITE_OK {
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                print("Tabela criada com sucesso")
            } else {
                print("Erro ao criar a tabela")
            }
        } else {
            print("Erro ao preparar a criação da tabela")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    // Função para adicionar um novo usuário
    func insertUsuario(email: String, senha: String, dataNac: String, nomeCompleto: String, genero: String, morada: String, telefone: String, nomeFerramenta: String, precoFerramenta: Double) {
        let insertQuery = "INSERT INTO Usuario (email, senha, dataNac, nomeCompleto, genero, morada, telefone, nomeFerramenta, precoFerramenta) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?);"
        var statement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, insertQuery, -1, &statement, nil) == SQLITE_OK {
            sqlite3_bind_text(statement, 1, (email as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 2, (senha as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 3, (dataNac as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 4, (nomeCompleto as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 5, (genero as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 6, (morada as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 7, (telefone as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 8, (nomeFerramenta as NSString).utf8String, -1, nil)
            sqlite3_bind_double(statement, 9, precoFerramenta)
            
            if sqlite3_step(statement) == SQLITE_DONE {
                print("Usuário adicionado com sucesso")
            } else {
                print("Erro ao adicionar o usuário")
            }
        } else {
            print("Erro ao preparar a inserção")
        }
        sqlite3_finalize(statement)
    }
    
    // Função para atualizar os campos de nomeFerramenta e precoFerramenta
    func updateFerramenta(id: Int, nomeFerramenta: String, precoFerramenta: Double) {
        let updateQuery = "UPDATE Usuario SET nomeFerramenta = ?, precoFerramenta = ? WHERE id = ?;"
        var updateStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, updateQuery, -1, &updateStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(updateStatement, 1, nomeFerramenta, -1, nil)
            sqlite3_bind_double(updateStatement, 2, precoFerramenta)
            sqlite3_bind_int(updateStatement, 3, Int32(id))
            
            if sqlite3_step(updateStatement) == SQLITE_DONE {
                print("Ferramenta atualizada com sucesso")
            } else {
                print("Erro ao atualizar ferramenta")
            }
        } else {
            print("Erro ao preparar a atualização")
        }
        sqlite3_finalize(updateStatement)
    }
    
    // Função para buscar todos os usuários
    func fetchAllUsuarios() -> [(Int, String, String, String, String, String, String, String, String, Double)] {
        let query = "SELECT * FROM Usuario;"
        var fetchStatement: OpaquePointer? = nil
        var usuarios: [(Int, String, String, String, String, String, String, String, String, Double)] = []
        
        if sqlite3_prepare_v2(db, query, -1, &fetchStatement, nil) == SQLITE_OK {
            while sqlite3_step(fetchStatement) == SQLITE_ROW {
                // Convertendo o id (coluna 0)
                let id = sqlite3_column_int(fetchStatement, 0)
                
                // Convertendo as colunas de texto
                let email = String(cString: sqlite3_column_text(fetchStatement, 1))
                let senha = String(cString: sqlite3_column_text(fetchStatement, 2))
                let dataNac = String(cString: sqlite3_column_text(fetchStatement, 3))
                let nomeCompleto = String(cString: sqlite3_column_text(fetchStatement, 4))
                let genero = String(cString: sqlite3_column_text(fetchStatement, 5))
                let morada = String(cString: sqlite3_column_text(fetchStatement, 6))
                let telefone = String(cString: sqlite3_column_text(fetchStatement, 7))
                let nomeFerramenta = String(cString: sqlite3_column_text(fetchStatement, 8))
                
                // Convertendo a coluna de preço (double)
                let precoFerramenta = sqlite3_column_double(fetchStatement, 9)
                
                // Adicionando o usuário à lista
                usuarios.append((Int(id), email, senha, dataNac, nomeCompleto, genero, morada, telefone, nomeFerramenta, precoFerramenta))
            }
        } else {
            print("Erro ao buscar usuários")
        }
        sqlite3_finalize(fetchStatement)
        return usuarios
    }
    // Função para deletar um usuário pelo ID
    func deleteUsuario(id: Int) {
        let deleteQuery = "DELETE FROM Usuario WHERE id = ?;"
        var deleteStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, deleteQuery, -1, &deleteStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(deleteStatement, 1, Int32(id))
            
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("Usuário deletado com sucesso")
            } else {
                print("Erro ao deletar usuário")
            }
        } else {
            print("Erro ao preparar a deleção")
        }
        sqlite3_finalize(deleteStatement)
    }
    
    func countUser() -> Int {
        let countQuery = "SELECT COUNT(*) FROM Usuario;"
        var countStatement: OpaquePointer? = nil
        var count: Int = 0
        
        if sqlite3_prepare_v2(db, countQuery, -1, &countStatement, nil) == SQLITE_OK {
            if sqlite3_step(countStatement) == SQLITE_ROW {
                count = Int(sqlite3_column_int(countStatement, 0))
            } else {
                print("Erro ao contar os serviços")
            }
        } else {
            print("Erro ao preparar a contagem")
        }
        sqlite3_finalize(countStatement)
        return count
    }
}
