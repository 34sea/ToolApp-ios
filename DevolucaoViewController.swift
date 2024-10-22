//
//  AlugarViewController.swift
//  ToolApp
//
//  Created by Elisio Simao on 1/1/01.
//  Copyright © 2001 Martinho Macovere. All rights reserved.
//

import UIKit

class DevolucaoViewController: UIViewController {
    let dbHelper = DBHleperUser()
    
    
    //var dadoSelecionado: (nome: String, preco: Double)?
    var idUser: Int = 0
    var nomeSele: String = ""
    var precoSele: Double = 0.0
    let label = UILabel()
    var nomeUser: String = ""
    var senhaUser: String = ""
    let nomeLbn: UILabel = {
        let textLbn = UILabel()
        textLbn.text = "Nome"
        textLbn.textColor = UIColor(hex: "#222222")
        textLbn.font = UIFont.systemFont(ofSize: 17)
        textLbn.numberOfLines = 0
        textLbn.lineBreakMode = .byWordWrapping
        // textLbn.textAlignment = .center
        return textLbn
    }()
    
    let precoLbn: UILabel = {
        let textLbn = UILabel()
        textLbn.text = "Preco"
        textLbn.textColor = UIColor(hex: "#222222")
        textLbn.font = UIFont.systemFont(ofSize: 17)
        textLbn.numberOfLines = 0
        textLbn.lineBreakMode = .byWordWrapping
        // textLbn.textAlignment = .center
        return textLbn
    }()
    
    let nomeResultLbn: UILabel = {
        let textLbn = UILabel()
        textLbn.text = "Martelo"
        textLbn.textColor = UIColor(hex: "#222222")
        textLbn.font = UIFont.systemFont(ofSize: 17)
        textLbn.numberOfLines = 0
        textLbn.lineBreakMode = .byWordWrapping
        // textLbn.textAlignment = .center
        return textLbn
    }()
    
    let precoResultLbn: UILabel = {
        let textLbn = UILabel()
        textLbn.text = "100"
        textLbn.textColor = UIColor(hex: "#222222")
        textLbn.font = UIFont.systemFont(ofSize: 17)
        textLbn.numberOfLines = 0
        textLbn.lineBreakMode = .byWordWrapping
        // textLbn.textAlignment = .center
        return textLbn
    }()
    
    let divLbn: UILabel = {
        let textLbn = UILabel()
        textLbn.text = ""
        textLbn.numberOfLines = 0
        textLbn.textColor = UIColor(hex: "#aaaaaa")
        textLbn.backgroundColor = UIColor(hex: "#aaaaaa")
        textLbn.lineBreakMode = .byWordWrapping
        textLbn.textAlignment = .center
        return textLbn
    }()
    
    let div2Lbn: UILabel = {
        let textLbn = UILabel()
        textLbn.text = ""
        textLbn.numberOfLines = 0
        textLbn.textColor = UIColor(hex: "#aaaaaa")
        textLbn.backgroundColor = UIColor(hex: "#aaaaaa")
        textLbn.lineBreakMode = .byWordWrapping
        textLbn.textAlignment = .center
        return textLbn
    }()
    
    
    let alugarButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Devolver", for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor(hex: "#0fc0ea")
        button.tintColor = UIColor(hex: "#ffffff")
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        label.textColor = .black
        label.text = "Detalhes"
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        layout()
        alugarButton.addTarget(self, action: #selector(alugar), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func layout(){
        let largura = view.frame.size.width
        let altura = view.frame.size.height
        
        view.addSubview(label)
        view.addSubview(nomeLbn)
        view.addSubview(nomeResultLbn)
        view.addSubview(divLbn)
        view.addSubview(div2Lbn)
        view.addSubview(precoLbn)
        view.addSubview(precoResultLbn)
        view.addSubview(alugarButton)
        
        
        label.frame = CGRect(x: (largura-150)/2, y: (altura/2)-180, width: 150, height: 30)
        
        nomeLbn.frame = CGRect(x: 20, y: (altura/2)-120, width: 80, height: 50)
        nomeResultLbn.frame = CGRect(x: (largura-100), y: (altura/2)-120, width: 80, height: 50)
        nomeResultLbn.text = "\(nomeSele)"
        
        divLbn.frame = CGRect(x: 0, y: (altura/2)-70, width: largura, height: 0.5)
        
        precoLbn.frame = CGRect(x: 20, y: (altura/2)-70, width: 80, height: 50)
        precoResultLbn.frame = CGRect(x: (largura-100), y: (altura/2)-70, width: 80, height: 50)
        precoResultLbn.text = "\(precoSele)"
        
        div2Lbn.frame = CGRect(x: 0, y: (altura/2)-10, width: largura, height: 0.5)
        
        alugarButton.frame = CGRect(x: (largura - (largura-20))/2, y: (altura/2)+10, width: largura-20, height: 50)
        
        // Atualizar os campos de nomeFerramenta e precoFerramenta
        //dbHelper.updateFerramenta(id: 1, nomeFerramenta: "Martelo", precoFerramenta: 300.0)
        
        
        
    }
    
    @objc func alugar(){
        let valorAnitgo = dadosValor(id: idUser)
        var valorAtual =  precoSele-valorAnitgo
        if (valorAtual<0){
            print("Negativo")
            valorAtual = valorAtual*(-1)
        }
        let tooOld = dadosTools(id: idUser)
        let toolCurrent = nomesPrintUpdate(tooOld, posicao: posicao(dadosTools(id: idUser), produto: nomeSele))
        print("Valor antigo: \(valorAnitgo), valor atual: \(valorAtual)")
        
        print("Ferramenta antigo: \(tooOld), Ferramenta atual: \(toolCurrent)")
        print("Posicao: \(posicao(dadosTools(id: idUser), produto: nomeSele))")
        dbHelper.updateFerramenta(id: idUser, nomeFerramenta: toolCurrent, precoFerramenta: valorAtual)
        loginScreenUser()
    }
    
    func dadosValor(id: Int) -> Double{
        let users = dbHelper.fetchAllUsuarios()
        for user in users {
            if( id == user.0){
                nomeUser = user.4
                senhaUser = user.2
                
                return user.9
            }
        }
        return 0
    }
    
    func posicao(_ nomes:String, produto: String) -> Int{
        var c: Int = 0
        let nomesVarios = nomes.split(separator: "#").map { String($0)}
        for item in nomesVarios {
            if(item == produto){
                return c
            }
            c+=1
        }
        return 0
    }
    
    func dadosTools(id: Int) -> String{
        let users = dbHelper.fetchAllUsuarios()
        for user in users {
            if( id == user.0){
                return user.8
            }
        }
        return " "
    }
    func nomesPrintUpdate(_ nomes: String, posicao: Int) -> String {
        var nomesVarios = nomes.split(separator: "#").map { String($0)}
        
        if posicao >= 0 && posicao < nomes.count {
            nomesVarios.remove(at: posicao)
        }else{
            return "Posicao invalida"
        }
        
        let nomesUpdate = nomesVarios.joined(separator: "#")
        
        
        return nomesUpdate
    }
    func loginScreenUser(){
        let goToScreen = HomeUserViewController()
        goToScreen.nameUser = nomeUser
        goToScreen.senhaUser = senhaUser
        goToScreen.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(goToScreen, animated: true)
        
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
