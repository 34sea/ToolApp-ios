//
//  LoginViewController.swift
//  ToolApp
//
//  Created by Elisio Simao on 1/1/01.
//  Copyright © 2001 Martinho Macovere. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    var fullChoice: String = ""
    let labelChoice = UILabel()
    let label = UILabel()
    let conta = UILabel()
    let dbHelperAdmin = DatabaseAdmin()
    let dbHelperUser = DBHleperUser()

    let email = UITextField()
    let senha = UITextField()
    var nomeL: String = ""
  
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        //Dimensoes da tela
        let screenWidth = view.frame.size.width
        let screenHeight = view.frame.size.height
        
        label.textColor = .black
        label.text = "Login"
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        //label.frame = CGRect(x: (screenWidth-100)/2, y: 400, width: 100, height: 100)
        view.addSubview(label)
        
        
        labelChoice.text = fullChoice
        labelChoice.frame = CGRect(x: (screenWidth - 100)/2, y: 100, width: 100, height: 50)
        labelChoice.textColor = .white
        labelChoice.textAlignment = .center
        view.addSubview(labelChoice)
        
        
        email.placeholder = "User"
        email.borderStyle = .roundedRect
        email.keyboardType = .emailAddress
        email.autocapitalizationType = .none
        email.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(email)
        
        
        senha.placeholder = "senha"
        senha.borderStyle = .roundedRect
        senha.isSecureTextEntry = true
        senha.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(senha)
        
        
        let btnLogin = UIButton(type: .custom)
        btnLogin.setTitle("Entrar", for: .normal)
        btnLogin.backgroundColor = UIColor(hex: "#0fc0ea")
        btnLogin.setTitleColor(.white, for: .normal)
        btnLogin.layer.cornerRadius = 20
        btnLogin.frame = CGRect(x: (screenWidth - 300)/2, y: (screenHeight-150), width: 300, height: 40)
        view.addSubview(btnLogin)
        
        btnLogin.addTarget(self, action: #selector(home), for: .touchUpInside)
        
        conta.text = "Nao tens uma conta?"
        conta.textColor = .black
        conta.frame = CGRect(x: (screenWidth - 200)/2, y: (screenHeight-80), width: 180, height: 50)
        conta.textAlignment = .center
        view.addSubview(conta)
        
        let btnConta = UIButton(type: .system)
        btnConta.setTitle("Criar", for: .normal)
        btnConta.tintColor = UIColor(hex: "#0fc0ea")
        btnConta.layer.cornerRadius = 20
        btnConta.frame = CGRect(x: (screenWidth + 140)/2, y: (screenHeight-65), width: 70, height: 20)
        view.addSubview(btnConta)
        
        btnConta.addTarget(self, action: #selector(registar), for: .touchUpInside)
        
        
        
        NSLayoutConstraint.activate([
            
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 220),
            //label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            email.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20),
            email.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            email.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            email.heightAnchor.constraint(equalToConstant: 44),
            
            senha.topAnchor.constraint(equalTo: email.bottomAnchor, constant: 10),
            senha.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            senha.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            senha.heightAnchor.constraint(equalToConstant: 44),

            ])


        // Do any additional setup after loading the view.
    }
    
    @objc func home(){
        if(fullChoice=="user"){
            telaHomeUser()

        }else{
     
            telaHomeAdmin()
        }
    }
    
    @objc func registar(){
        let homeScreen = SigUpAdminViewController()
        let homeScreen2 = SigUpUserViewController()
        
        if(fullChoice=="user"){
            navigationController?.pushViewController(homeScreen2, animated: true)
            
        }else{
            navigationController?.pushViewController(homeScreen, animated: true)
            
        }
        
    }
    
    func telaHomeUser(){
        let users = dbHelperUser.fetchAllUsuarios()
        for user in users {
            print("Nome: \(user.4), Senha: \(user.2)")
            //print(user)
            if let nomeUsuario = email.text, let senhaUsuario = senha.text {
                if(user.4 == nomeUsuario){
                    if(user.2 == senhaUsuario){
                        nomeL = user.1
                        let goToScreen = HomeUserViewController()
                        goToScreen.nameUser = nomeUsuario
                        goToScreen.senhaUser = senhaUsuario
                        goToScreen.modalPresentationStyle = .fullScreen
                        self.navigationController?.pushViewController(goToScreen, animated: true)
                    }
                }
        }
    }
    }
    
    func telaHomeAdmin(){
        let users = DatabaseAdmin().fetchAllAdmins()
        
//        for user in users {
//            print("Nome: \(user.0), Senha: \(user.1)")
//            if let nomeUsuario = email.text, let senhaUsuario = senha.text {
//                if(user.0 == nomeUsuario){
//                    if(user.1 == senhaUsuario){
//                        nomeL = user.0
//                        let goToScreen = HomeAdminViewController()
//                        goToScreen.nameAdmin = nomeUsuario
//                        goToScreen.modalPresentationStyle = .fullScreen
//                        self.navigationController?.pushViewController(goToScreen, animated: true)
//                    }
//                }
//            }
//
//        }
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
