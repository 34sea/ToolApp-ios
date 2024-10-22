//
//  ProdutosViewController.swift
//  ToolApp
//
//  Created by Elisio Simao on 10/21/24.
//  Copyright © 2024 Martinho Macovere. All rights reserved.
//

import UIKit

class ToolAlugadaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var idUser: Int = 0
    var dados = [(nome: String, idUsers: Int, preco: Double)]()
    let dbHelperUser = DBHleperUser()
    let dbHelper = DBHelperTool()
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        print("Id: \(idUser)")
        layout()
        // Configuração da TableView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        
        let usuarios = dbHelperUser.fetchAllUsuarios()
        for usuario in usuarios {
            if(idUser == usuario.0){
                let imprimirTodos = usuario.8.split(separator: "#")
                
                let imprimirCada = imprimirTodos.map{ String($0) }
                print(imprimirCada)
                for item in imprimirCada {
                    print("Itema: \(item)")
                    
                    dados.append((nome: item, idUsers: idUser, preco: precoTool(nome: item)))
                    
                }
                //let nomeL = usuario.4
                //let ferra = usuario.8
            }
            
            
            // print("Nome: \(usuario.4), Ferramenta: \(usuario.8), Preço: \(usuario.9)")
            
        }
        // Do any additional setup after loading the view.
    }
    
    // Função obrigatória para número de linhas
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dados.count
    }
    
    // Função que configura cada célula da tabela
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let dado = dados[indexPath.row]
        cell.textLabel?.text = "\(dado.nome)"
        print(dado)
        return cell
    }
    
    // Função que trata o clique em uma célula
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let detalheVC = DevolucaoViewController()
//        detalheVC.idUser = idUser
//        detalheVC.nomeSele = dados[indexPath.row].nome
//        detalheVC.precoSele = dados[indexPath.row].preco
//        detalheVC.modalPresentationStyle = .fullScreen
//        //detalheVC.tool = tool
//        //detalheVC.dadoSelecionado = dados[indexPath.row] // Passar os dados para o próximo ViewController
//        navigationController?.pushViewController(detalheVC, animated: true) // Navegar para a nova tela
    }
    
    func countTools(_ nomesTools: String){
        
        let imprimirTodos = nomesTools.split(separator: "#")
        
        let imprimirCada = imprimirTodos.map{ String($0) }
        //        print("-----------------------")
        //        print(imprimirCada)
    }
    
    func layout() {
        let largura = view.frame.size.width
        let altura = view.frame.size.height
        tableView.frame = CGRect(x: 20, y: 140, width: largura-20, height: altura-100)
    }
    
    func precoTool(nome: String) -> Double{
        let ferramentas = dbHelper.fetchAllTools()
        for ferramenta in ferramentas {
            if (nome == ferramenta.1){
                return ferramenta.3
            }
        }
        
        return 0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
