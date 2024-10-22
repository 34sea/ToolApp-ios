//
//  LojaViewController.swift
//  ToolApp
//
//  Created by Elisio Simao on 1/1/01.
//  Copyright © 2001 Martinho Macovere. All rights reserved.
//

import UIKit

class LojaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var idUser: Int = 0
    var tool: String = "false"
    let tableView = UITableView()
    var dados = [(nome: String, preco: Double)]()
    let lbn = UILabel()
    let dbHelper = DBHelperTool()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        lbn.text = "Ferramentas"
        lbn.textAlignment = .center
        lbn.font = UIFont.systemFont(ofSize: 25, weight: .bold)

        // Configuração da TableView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        view.addSubview(lbn)
        
        // Exemplo de dados que você pode buscar do banco de dados
        let ferramentas = dbHelper.fetchAllTools()
        for ferramenta in ferramentas {
            let nomeL = ferramenta.1
            let precoL = ferramenta.3
            dados.append((nome: nomeL, preco: precoL))
            //print("ID: \(servico.0), Nome: \(servico.1), Preço: \(servico.2)")
            print("Nome: \(ferramenta.1), Descrição: \(ferramenta.2), Preço: \(ferramenta.3)")
        }
        
        layout()
        
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
        cell.textLabel?.text = "\(dado.nome) - \(dado.preco) MZN"
        print(dado)
        return cell
    }
    
    // Função que trata o clique em uma célula
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detalheVC = AlugarViewController()
        detalheVC.idUser = idUser
        detalheVC.tool = tool
        detalheVC.dadoSelecionado = dados[indexPath.row] // Passar os dados para o próximo ViewController
        navigationController?.pushViewController(detalheVC, animated: true) // Navegar para a nova tela
    }
    
    // Configura as constraints da TableView
    func layout() {
//        NSLayoutConstraint.activate([
//            tableView.topAnchor.constraint(equalTo: view.topAnchor),
//            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
//            ])
        let largura = view.frame.size.width
        let altura = view.frame.size.height
        lbn.frame = CGRect(x: (largura - (largura-100))/2, y: 150, width: largura-100, height: 40)
        tableView.frame = CGRect(x: 20, y: 240, width: largura-20, height: altura-100)
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