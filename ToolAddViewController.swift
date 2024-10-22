//
//  ToolAddViewController.swift
//  ToolApp
//
//  Created by Elisio Simao on 1/1/01.
//  Copyright © 2001 Martinho Macovere. All rights reserved.
//

import UIKit

class ToolAddViewController: UIViewController {

    let label = UILabel()
    let dbHelper = DBHelperTool()


    let nomeField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Nome"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let precoFeld: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Preco"
        textField.keyboardType = .phonePad
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let descField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Descricao"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    let cadastrarButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Adicionar", for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor(hex: "#0fc0ea")
        button.tintColor = UIColor(hex: "#ffffff")
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        layout()
        
        cadastrarButton.addTarget(self, action: #selector(add), for: .touchUpInside)

        // Do any additional setup after loading the view.
    }

    
    func layout(){
        let largura = view.frame.size.width
        let altura = view.frame.size.height
        label.textColor = .black
        label.text = "Cadastro"
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        
        view.addSubview(label)
        view.addSubview(nomeField)
        view.addSubview(precoFeld)
        view.addSubview(descField)
        view.addSubview(cadastrarButton)
        
        label.frame = CGRect(x: (largura - (largura-60))/2, y: (altura-670), width: largura-60, height: 50)
        nomeField.frame = CGRect(x: (largura - (largura-60))/2, y: (altura-520), width: largura-60, height: 50)
        precoFeld.frame = CGRect(x: (largura - (largura-60))/2, y: (altura-460), width: largura-60, height: 50)
        descField.frame = CGRect(x: (largura - (largura-60))/2, y: (altura-400), width: largura-60, height: 50)
        cadastrarButton.frame = CGRect(x: (largura - (largura-50))/2, y: (altura-100), width: largura-50, height: 40)
    }
    
    @objc func add(){
        if let precoL = precoFeld.text, let precoLl = Double(precoL){
            dbHelper.insertTool(nomeTool: nomeField.text!, descricaoTool: descField.text!, precoTool: precoLl)
        }
        let tela = ViewController()
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
