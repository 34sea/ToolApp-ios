//
//  SigUpAdminViewController.swift
//  ToolApp
//
//  Created by Elisio Simao on 1/1/01.
//  Copyright © 2001 Martinho Macovere. All rights reserved.
//

import UIKit
import SQLite3

class SigUpAdminViewController: UIViewController {

    var db: OpaquePointer?
    let conta = UILabel()
    let label = UILabel()
    let email = UITextField()
    let senha = UITextField()
    let dbHelper = DatabaseAdmin()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        //bd
        //setupSQLiteAdmin()
        
        //Dimensoes da tela
        let screenWidth = view.frame.size.width
        let screenHeight = view.frame.size.height
        
        label.textColor = .black
        label.text = "Cadastro"
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        //label.frame = CGRect(x: (screenWidth-100)/2, y: 400, width: 100, height: 100)
        view.addSubview(label)
        
        
        
        
        email.placeholder = "Email"
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
        btnLogin.setTitle("Cadastrar", for: .normal)
        btnLogin.backgroundColor = UIColor(hex: "#0fc0ea")
        btnLogin.setTitleColor(.white, for: .normal)
        btnLogin.layer.cornerRadius = 20
        btnLogin.frame = CGRect(x: (screenWidth - 300)/2, y: (screenHeight-150), width: 300, height: 40)
        view.addSubview(btnLogin)
        
        btnLogin.addTarget(self, action: #selector(btnCreate), for: .touchUpInside)
        
        conta.text = "Ja tens uma conta?"
        conta.textColor = .black
        conta.frame = CGRect(x: (screenWidth - 200)/2, y: (screenHeight-80), width: 180, height: 50)
        conta.textAlignment = .center
        view.addSubview(conta)
        
        let btnConta = UIButton(type: .system)
        btnConta.setTitle("Entrar", for: .normal)
        btnConta.backgroundColor = UIColor.white
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
        // let n = nome.text ?? ""
        let homeScreen = HomeAdminViewController()
        navigationController?.pushViewController(homeScreen, animated: true)
        //homeScreen.fullName = nome.text ?? "Martinho"
        //homeScreen.onNameSet = {[weak self] name in
        //  self?.nome.text = name
        //}
        //dados.text = "Nome: \(n)"
    }
    
    @objc func registar(){
        
        let loginUser = LoginViewController()
        loginUser.fullChoice = "admin"
        navigationController?.pushViewController(loginUser, animated: true)

    }
    
    @objc func btnCreate(){
        //print(userField.text)
        //print(senhaField.text)
        /*let users = [(name: userField.text, password: senhaField.text)]
         dbHelper.insertMultipleUsers(users: users)*/
        //dbHelper.insertUser(name: userField.text, password: senhaField.text)
        if let nomeUsuario = email.text, let senhaUsuario = senha.text {
            print("Add => Nome: \(nomeUsuario), Senha: \(senhaUsuario)")
            dbHelper.insertAdmin(email: nomeUsuario, password: senhaUsuario)
            loginScreenAdmin()
        }
    }
    
    
    @objc func loginScreenAdmin(){
        let loginUser = LoginViewController()
        loginUser.fullChoice = "admin"
        navigationController?.pushViewController(loginUser, animated: true)
        
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
