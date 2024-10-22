//
//  HomeAdminViewController.swift
//  ToolApp
//
//  Created by Elisio Simao on 1/1/01.
//  Copyright © 2001 Martinho Macovere. All rights reserved.
//

import UIKit


class HomeUserViewController: UIViewController {
    var nameUser: String = ""
    var senhaUser: String = ""
    var nomeFerramentas: String = ""
    var idUser: Int = 0
    var valorFerramentas: Double = 0
    let dbHelperUser = DBHleperUser()

    let greetingsField: UILabel = {
        let textField = UILabel()
        textField.text = "Ola, "
        textField.textColor = UIColor(hex: "#0fc0ea")
        //textField.font = UIFont.systemFont(ofSize: 25)
        textField.numberOfLines = 0
        textField.lineBreakMode = .byWordWrapping
        // textField.textAlignment = .center
        textField.font = UIFont.boldSystemFont(ofSize: 20)
        return textField
    }()
    
    let nomeAdminField: UILabel = {
        let textField = UILabel()
        textField.text = "Dirsia!"
        textField.textColor = UIColor(hex: "#0fc0ea")
        //textField.font = UIFont.systemFont(ofSize: 25)
        textField.numberOfLines = 0
        textField.lineBreakMode = .byWordWrapping
        // textField.textAlignment = .center
        textField.font = UIFont.boldSystemFont(ofSize: 20)
        return textField
    }()
    
    let imagemImg: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "bammm")
        return img
    }()
    
    let imagemPefilImg: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "u")
        return img
    }()
    
    let toolButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Loja", for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor(hex: "#0fc0ea")
        button.tintColor = UIColor(hex: "#ffffff")
        return button
    }()
    
    let userButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Users", for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor(hex: "#0fc0ea")
        button.tintColor = UIColor(hex: "#ffffff")
        return button
    }()
    
    let toolAlugadosButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Ferramentas alugadas", for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor(hex: "#ffffff")
        button.tintColor = UIColor(hex: "#0fc0ea")
        return button
    }()
    
    let addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("+", for: .normal)
        button.layer.cornerRadius = 15
        button.backgroundColor = UIColor(hex: "#0fc0ea")
        button.tintColor = UIColor(hex: "#ffffff")
        return button
    }()
    
    let sairButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sair", for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor(hex: "#0fc0ea")
        button.tintColor = UIColor(hex: "#ffffff")
        return button
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
    
    let div3Lbn: UILabel = {
        let textLbn = UILabel()
        textLbn.text = ""
        textLbn.numberOfLines = 0
        textLbn.textColor = UIColor(hex: "#aaaaaa")
        textLbn.backgroundColor = UIColor(hex: "#aaaaaa")
        textLbn.lineBreakMode = .byWordWrapping
        textLbn.textAlignment = .center
        return textLbn
    }()
    
    let div4Lbn: UILabel = {
        let textLbn = UILabel()
        textLbn.text = ""
        textLbn.numberOfLines = 0
        textLbn.textColor = UIColor(hex: "#aaaaaa")
        textLbn.backgroundColor = UIColor(hex: "#aaaaaa")
        textLbn.lineBreakMode = .byWordWrapping
        textLbn.textAlignment = .center
        return textLbn
    }()
    
    let div5Lbn: UILabel = {
        let textLbn = UILabel()
        textLbn.text = ""
        textLbn.numberOfLines = 0
        textLbn.textColor = UIColor(hex: "#aaaaaa")
        textLbn.backgroundColor = UIColor(hex: "#aaaaaa")
        textLbn.lineBreakMode = .byWordWrapping
        textLbn.textAlignment = .center
        return textLbn
    }()
    
    let div6Lbn: UILabel = {
        let textLbn = UILabel()
        textLbn.text = ""
        textLbn.numberOfLines = 0
        textLbn.textColor = UIColor(hex: "#aaaaaa")
        textLbn.backgroundColor = UIColor(hex: "#aaaaaa")
        textLbn.lineBreakMode = .byWordWrapping
        textLbn.textAlignment = .center
        return textLbn
    }()
    
    let quantiToolsLbn: UILabel = {
        let textLbn = UILabel()
        textLbn.text = "Telefone"
        textLbn.textColor = UIColor(hex: "#222222")
        textLbn.font = UIFont.systemFont(ofSize: 17)
        textLbn.numberOfLines = 0
        textLbn.lineBreakMode = .byWordWrapping
        // textLbn.textAlignment = .center
        return textLbn
    }()
    
    let quantiDeUsuarioLbn: UILabel = {
        let textLbn = UILabel()
        textLbn.text = "Morada"
        textLbn.textColor = UIColor(hex: "#222222")
        textLbn.font = UIFont.systemFont(ofSize: 17)
        textLbn.numberOfLines = 0
        textLbn.lineBreakMode = .byWordWrapping
        // textLbn.textAlignment = .center
        return textLbn
    }()
    
    let toolAluLbn: UILabel = {
        let textLbn = UILabel()
        textLbn.text = "Data de nasc."
        textLbn.textColor = UIColor(hex: "#222222")
        textLbn.font = UIFont.systemFont(ofSize: 17)
        textLbn.numberOfLines = 0
        textLbn.lineBreakMode = .byWordWrapping
        // textLbn.textAlignment = .center
        return textLbn
    }()
    
    let valorLbn: UILabel = {
        let textLbn = UILabel()
        textLbn.text = "Ferramenta"
        textLbn.textColor = UIColor(hex: "#222222")
        textLbn.font = UIFont.systemFont(ofSize: 17)
        textLbn.numberOfLines = 0
        textLbn.lineBreakMode = .byWordWrapping
        // textLbn.textAlignment = .center
        return textLbn
    }()
    
    let quantiDeToolsLbn: UILabel = {
        let textLbn = UILabel()
        textLbn.text = "Valor total: "
        textLbn.textColor = UIColor(hex: "#222222")
        textLbn.font = UIFont.systemFont(ofSize: 17)
        textLbn.numberOfLines = 0
        textLbn.lineBreakMode = .byWordWrapping
        // textLbn.textAlignment = .center
        return textLbn
    }()
    
    let addFerraLbn: UILabel = {
        let textLbn = UILabel()
        textLbn.text = "Adicionar Ferr."
        textLbn.textColor = UIColor(hex: "#222222")
        textLbn.font = UIFont.systemFont(ofSize: 17)
        textLbn.numberOfLines = 0
        textLbn.lineBreakMode = .byWordWrapping
        // textLbn.textAlignment = .center
        return textLbn
    }()
    
    let toolAluResultLbn: UILabel = {
        let textLbn = UILabel()
        textLbn.text = "0"
        textLbn.textColor = UIColor(hex: "#222222")
        textLbn.font = UIFont.systemFont(ofSize: 17)
        textLbn.numberOfLines = 0
        textLbn.lineBreakMode = .byWordWrapping
        // textLbn.textAlignment = .center
        return textLbn
    }()
    
    let valorResultLbn: UILabel = {
        let textLbn = UILabel()
        textLbn.text = "sem"
        textLbn.textColor = UIColor(hex: "#222222")
        textLbn.font = UIFont.systemFont(ofSize: 17)
        textLbn.numberOfLines = 0
        textLbn.lineBreakMode = .byWordWrapping
        // textLbn.textAlignment = .center
        return textLbn
    }()
    
    let quantiToolsResultLbn: UILabel = {
        let textLbn = UILabel()
        textLbn.text = "sem"
        textLbn.textColor = UIColor(hex: "#222222")
        textLbn.font = UIFont.systemFont(ofSize: 17)
        textLbn.numberOfLines = 0
        textLbn.lineBreakMode = .byWordWrapping
        // textLbn.textAlignment = .center
        return textLbn
    }()
    
    let quantiDeUsuarioResultLbn: UILabel = {
        let textLbn = UILabel()
        textLbn.text = "sem"
        textLbn.textColor = UIColor(hex: "#222222")
        textLbn.font = UIFont.systemFont(ofSize: 17)
        textLbn.numberOfLines = 0
        textLbn.lineBreakMode = .byWordWrapping
        // textLbn.textAlignment = .center
        return textLbn
    }()
    
    let quantiDeToolsResultLbn: UILabel = {
        let textLbn = UILabel()
        textLbn.text = "0"
        textLbn.textColor = UIColor(hex: "#222222")
        textLbn.font = UIFont.systemFont(ofSize: 17)
        textLbn.numberOfLines = 0
        textLbn.lineBreakMode = .byWordWrapping
        // textLbn.textAlignment = .center
        return textLbn
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(hex: "#ffffff")
        
        layout()
        
        toolButton.addTarget(self, action: #selector(telaTools), for: .touchUpInside)
        //userButton.addTarget(self, action: #selector(telaUser), for: .touchUpInside)
        sairButton.addTarget(self, action: #selector(telaHome), for: .touchUpInside)
        toolAlugadosButton.addTarget(self, action: #selector(produtosTela), for: .touchUpInside)
        
        
        // Do any additional setup after loading the view.
    }
    
    func layout(){
        
        let largura = view.frame.size.width
        let altura = view.frame.size.height
        
        print("Nome: \(nameUser)")
        nomeAdminField.text = nameUser
        view.addSubview(greetingsField)
        view.addSubview(nomeAdminField)
        view.addSubview(imagemImg)
        view.addSubview(imagemPefilImg)
        view.addSubview(toolButton)
        view.addSubview(sairButton)
        //view.addSubview(userButton)
        view.addSubview(divLbn)
        view.addSubview(div2Lbn)
        view.addSubview(div3Lbn)
        view.addSubview(div4Lbn)
        view.addSubview(div5Lbn)
        view.addSubview(quantiToolsLbn)
        view.addSubview(quantiDeUsuarioLbn)
        view.addSubview(quantiDeUsuarioResultLbn)
        view.addSubview(quantiToolsResultLbn)
        view.addSubview(toolAluLbn)
        view.addSubview(valorLbn)
        view.addSubview(toolAluResultLbn)
        view.addSubview(valorResultLbn)
        view.addSubview(quantiDeToolsResultLbn)
        view.addSubview(quantiDeToolsLbn)
        view.addSubview(toolAlugadosButton)

       // view.addSubview(addButton)
        //view.addSubview(addFerraLbn)
        
        
        
        greetingsField.frame = CGRect(x: 20, y: 140, width: 40, height: 20)
        nomeAdminField.frame = CGRect(x: 60, y: 140, width: 170, height: 20)
        imagemPefilImg.frame = CGRect(x: largura-70, y: 120, width: 50, height: 50)
        
        
        imagemImg.frame = CGRect(x: 0, y: 200, width: largura, height: 170)
        
        quantiToolsLbn.frame = CGRect(x: 20, y: 400, width: largura/2, height: 20)
        quantiToolsResultLbn.frame = CGRect(x: largura-100, y: 400, width: 100, height: 20)
        
        quantiDeUsuarioLbn.frame = CGRect(x: 20, y: 450, width: largura/2, height: 20)
        quantiDeUsuarioResultLbn.frame = CGRect(x: largura-100, y: 450, width: 100, height: 20)
        
        toolAluLbn.frame = CGRect(x: 20, y: 505, width: largura/2, height: 20)
        toolAluResultLbn.frame = CGRect(x: largura-100, y: 505, width: 100, height: 20)
        
        valorLbn.frame = CGRect(x: 20, y: 550, width: largura/2, height: 20)
        valorResultLbn.frame = CGRect(x: largura-100, y: 550, width: 100, height: 20)
        //addFerraLbn.frame = CGRect(x: 20, y: 600, width: largura/2, height: 20)
        
        quantiDeToolsLbn.frame = CGRect(x: 20, y: 595, width: largura/2, height: 20)
        quantiDeToolsResultLbn.frame = CGRect(x: largura-100, y: 595, width: 100, height: 20)
        
        //quantiToolsLbn.frame = CGRect(x: 0, y: 300, width: largura, height: 1)
        
        divLbn.frame = CGRect(x: 0, y: 435, width: largura, height: 0.5)
        div2Lbn.frame = CGRect(x: 0, y: 490, width: largura, height: 0.5)
        div3Lbn.frame = CGRect(x: 0, y: 535, width: largura, height: 0.5)
        div4Lbn.frame = CGRect(x: 0, y: 585, width: largura, height: 0.5)
        div5Lbn.frame = CGRect(x: 0, y: 630, width: largura, height: 0.5)
        
        toolButton.frame = CGRect(x: 20, y: altura-80, width: (largura-50)/2, height: 40)
        //addButton.frame = CGRect(x: largura-50, y: 600, width: 30, height: 30)
        //userButton.frame = CGRect(x: (largura-100)/2, y: altura-80, width: 100, height: 40)
        sairButton.frame = CGRect(x: (largura-((largura-50)/2))-20, y: altura-80, width: (largura-50)/2, height: 40)
        toolAlugadosButton.frame = CGRect(x: (largura-((largura-50)))/2, y: altura-140, width: (largura-50), height: 40)
        
        dados()
        valorResultLbn.text = "\(nomeFerramentas)"

        
    }
    
    @objc func telaUser(){
        let tela = UsersViewController()
        tela.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(tela, animated: true)
    }
    
    @objc func telaTools(){
        
        if(nomeFerramentas == "Sem"){
            let tela = LojaViewController()
            tela.idUser = idUser
            tela.tool = "false"
            tela.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(tela, animated: true)
        }else{
            let tela = LojaViewController()
            tela.idUser = idUser
            tela.tool = "true"
            tela.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(tela, animated: true)
//            let tela = DevolucaoViewController()
//            tela.idUser = idUser
//            tela.nomeSele = nomeFerramentas
//            tela.precoSele = valorFerramentas
//            tela.modalPresentationStyle = .fullScreen
//            self.navigationController?.pushViewController(tela, animated: true)
        }
    }
    
    @objc func telaHome(){
        let tela = ViewController()
        tela.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(tela, animated: true)
    }
    
    @objc func telaAddTool(){
        let tela = LojaViewController()
        tela.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(tela, animated: true)
    }
    
    func dados(){
        let users = dbHelperUser.fetchAllUsuarios()
        for user in users {
            //print("Nome: \(user.4), Senha: \(user.2)")
            print(user)
            if(user.4 == nameUser){
                if(user.2 == senhaUser){
                    idUser = user.0
                    print("Id: \(idUser)")
                    quantiToolsResultLbn.text = "\(user.7)"
                    quantiDeUsuarioResultLbn.text = "\(user.6)"
                    toolAluResultLbn.text = "\(user.3)"
                    quantiDeToolsResultLbn.text =  "\(user.9)"
                    if(user.8 == "None"){
                        nomeFerramentas = "Sem"
                    }else{
                        nomeFerramentas = "\(countTools(user.8))"
                        valorFerramentas = user.9
                        print("Quantidade de tools: \(countTools(user.8))")
                    }
                    
                }
            }

        }
    }
    
    func countTools(_ nomesTools: String) -> Int{
        
        let imprimirTodos = nomesTools.split(separator: "#")
        
        let imprimirCada = imprimirTodos.map{ String($0) }
        return imprimirCada.count
//        print("-----------------------")
//        print(imprimirCada)
    }
    
    @objc func produtosTela(){
        let tela = ProdutosViewController()
        tela.idUser = idUser
        tela.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(tela, animated: true)
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
