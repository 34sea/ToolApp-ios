//
//  UsersViewController.swift
//  ToolApp
//
//  Created by Elisio Simao on 10/12/24.
//  Copyright © 2024 Martinho Macovere. All rights reserved.
//

import UIKit

class UsersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let dbHelper = DBHleperUser()
    let tableView = UITableView()
    var dados = [(id: Int, nome: String, ferramenta: String, preco: Double, senha: String)]()
    let lbn = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        lbn.text = "Usuarios"
        lbn.textColor = UIColor(hex: "#0fc0ea")
        lbn.textAlignment = .center
        lbn.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        
        // Configuração da TableView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        view.addSubview(lbn)
        
        let usuarios = dbHelper.fetchAllUsuarios()
        for usuario in usuarios {
            let nomeL = usuario.4
            let ferra = usuario.8
            let preco = usuario.9
            let senha = usuario.2
            if(ferra == "None"){
                dados.append((id: usuario.0, nome: nomeL, ferramenta: "Sem ferramenta", preco: preco, senha: senha))
            }else{
                dados.append((id: usuario.0, nome: nomeL, ferramenta: ferra, preco: preco, senha: senha))
            }
            
            print("Nome: \(usuario.4), Ferramenta: \(usuario.8), Preço: \(usuario.9)")

        }
        
        lView()


        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dados.count
    }
    
    // Função que configura cada célula da tabela
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let dado = dados[indexPath.row]
        cell.textLabel?.text = "\(dado.id) - \(dado.nome) - \(dado.preco) MZN"
        print(dado)
        return cell
    }
    
    // Função que trata o clique em uma célula
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                let detalheVC = UserDetalhesViewController()
                detalheVC.idUser = dados[indexPath.row].id
                detalheVC.nameUser = dados[indexPath.row].nome
                detalheVC.senhaUser = dados[indexPath.row].senha

                detalheVC.modalPresentationStyle = .fullScreen
                //detalheVC.dadoSelecionado = dados[indexPath.row] // Passar os dados para o próximo ViewController
                navigationController?.pushViewController(detalheVC, animated: true) // Navegar para a nova tela
    }
    
    // Configura as constraints da TableView
    func lView() {
        
        //view.addSubview(servicosButton)
        let largura = view.frame.size.width
        let altura = view.frame.size.height
        lbn.frame = CGRect(x: (largura - (largura-100))/2, y: 150, width: largura-100, height: 40)
        tableView.frame = CGRect(x: 20, y: 230, width: largura-20, height: altura-150)
        
        //servicosButton.frame = CGRect(x: (largura - (largura-50))/2, y: altura-100, width: largura-50, height: 40)
        
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
