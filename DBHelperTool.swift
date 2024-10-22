//
//  DBHelperTool.swift
//  ToolApp
//
//  Created by Elisio Simao on 1/1/01.
//  Copyright © 2001 Martinho Macovere. All rights reserved.
//

import Foundation
import SQLite3

class DBHelperTool {
    var db: OpaquePointer?
    
    // Inicializa e cria o banco de dados e tabela
    init() {
        db = openDatabase()
        createToolTable()
    }
    
    // Função para abrir o banco de dados
    func openDatabase() -> OpaquePointer? {
        var db: OpaquePointer? = nil
        let fileURL = try! FileManager.default
            .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("ToolsDatabas.sqlite")
        
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("Erro ao abrir o banco de dados")
            return nil
        } else {
            print("Banco de dados aberto com sucesso")
            return db
        }
    }
    
    // Função para criar a tabela Tool
    func createToolTable() {
        let createTableQuery = """
        CREATE TABLE IF NOT EXISTS Tool (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nomeTool TEXT,
            descricaoTool TEXT,
            precoTool DOUBLE
        );
        """
        
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableQuery, -1, &createTableStatement, nil) == SQLITE_OK {
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                print("Tabela Tool criada com sucesso")
            } else {
                print("Erro ao criar a tabela Tool")
            }
        } else {
            print("Erro ao preparar a criação da tabela")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    // Função para adicionar uma ferramenta no banco de dados
    func insertTool(nomeTool: String, descricaoTool: String, precoTool: Double) {
        let insertQuery = "INSERT INTO Tool (nomeTool, descricaoTool, precoTool) VALUES (?, ?, ?);"
        var insertStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, insertQuery, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(insertStatement, 1, (nomeTool as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 2, (descricaoTool as NSString).utf8String, -1, nil)
            sqlite3_bind_double(insertStatement, 3, precoTool)
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Ferramenta adicionada com sucesso")
            } else {
                print("Erro ao adicionar ferramenta")
            }
        } else {
            print("Erro ao preparar a inserção")
        }
        sqlite3_finalize(insertStatement)
    }
    
    // Função para listar todas as ferramentas
    func fetchAllTools() -> [(Int, String, String, Double)] {
        let query = "SELECT * FROM Tool;"
        var fetchStatement: OpaquePointer? = nil
        var tools: [(Int, String, String, Double)] = []
        
        if sqlite3_prepare_v2(db, query, -1, &fetchStatement, nil) == SQLITE_OK {
            while sqlite3_step(fetchStatement) == SQLITE_ROW {
                let id = sqlite3_column_int(fetchStatement, 0)
                let nomeTool = String(cString: sqlite3_column_text(fetchStatement, 1))
                let descricaoTool = String(cString: sqlite3_column_text(fetchStatement, 2))
                let precoTool = sqlite3_column_double(fetchStatement, 3)
                
                tools.append((Int(id), nomeTool, descricaoTool, precoTool))
            }
        } else {
            print("Erro ao buscar ferramentas")
        }
        sqlite3_finalize(fetchStatement)
        return tools
    }
    
    // Função para atualizar uma ferramenta
    func updateTool(id: Int, nomeTool: String, descricaoTool: String, precoTool: Double) {
        let updateQuery = "UPDATE Tool SET nomeTool = ?, descricaoTool = ?, precoTool = ? WHERE id = ?;"
        var updateStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, updateQuery, -1, &updateStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(updateStatement, 1, (nomeTool as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updateStatement, 2, (descricaoTool as NSString).utf8String, -1, nil)
            sqlite3_bind_double(updateStatement, 3, precoTool)
            sqlite3_bind_int(updateStatement, 4, Int32(id))
            
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
    
    // Função para apagar uma ferramenta
    func deleteTool(id: Int) {
        let deleteQuery = "DELETE FROM Tool WHERE id = ?;"
        var deleteStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, deleteQuery, -1, &deleteStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(deleteStatement, 1, Int32(id))
            
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("Ferramenta removida com sucesso")
            } else {
                print("Erro ao remover ferramenta")
            }
        } else {
            print("Erro ao preparar a remoção")
        }
        sqlite3_finalize(deleteStatement)
    }
    
    func countTools() -> Int {
        let countQuery = "SELECT COUNT(*) FROM Tool;"
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
