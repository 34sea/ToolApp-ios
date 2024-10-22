//
//  SigUpUserViewController.swift
//  ToolApp
//
//  Created by Elisio Simao on 1/1/01.
//  Copyright © 2001 Martinho Macovere. All rights reserved.
//

import UIKit

class SigUpUserViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    let datePicker = UIDatePicker()
    let sexo = ["Masculino", "Feminino"]
    let sexoPicker = UIPickerView()
    let label = UILabel()
    let dbHelper = DBHleperUser()


    let nomeField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Nome"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let emailField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.keyboardType = .emailAddress
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let telefoneFeld: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Telefone"
        textField.keyboardType = .phonePad
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    let moradaField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Morada"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let passField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Senha"
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        return textField
    }()
    

    let cadastrarButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Cadastrar", for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor(hex: "#0fc0ea")
        button.tintColor = UIColor(hex: "#ffffff")
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white

        // Configuração do DatePicker
        datePicker.datePickerMode = .date
        //datePicker.preferredDatePickerStyle = .wheels // Estilo de roda
        datePicker.translatesAutoresizingMaskIntoConstraints = false

        layout()
        
        cadastrarButton.addTarget(self, action: #selector(salvarUser), for: .touchUpInside)

        // Do any additional setup after loading the view.
    }
    
    func layout(){
        let largura = view.frame.size.width
        let altura = view.frame.size.height
        
        
        // Configurando o PickerView de Gênero
        sexoPicker.delegate = self
        sexoPicker.dataSource = self
        sexoPicker.translatesAutoresizingMaskIntoConstraints = false
        
        label.textColor = .black
        label.text = "Cadastro"
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        //label.frame = CGRect(x: (screenWidth-100)/2, y: 400, width: 100, height: 100)
        view.addSubview(label)
        
        view.addSubview(moradaField)
        view.addSubview(passField)
        view.addSubview(sexoPicker)
        view.addSubview(datePicker)
        view.addSubview(telefoneFeld)
        view.addSubview(nomeField)
        view.addSubview(emailField)
        
        view.addSubview(cadastrarButton)
        label.frame = CGRect(x: (largura - (largura-60))/2, y: (altura-670), width: largura-60, height: 50)
        nomeField.frame = CGRect(x: (largura - (largura-60))/2, y: (altura-610), width: largura-60, height: 50)
        emailField.frame = CGRect(x: (largura - (largura-60))/2, y: (altura-550), width: largura-60, height: 50)
        telefoneFeld.frame = CGRect(x: (largura - (largura-60))/2, y: (altura-490), width: largura-60, height: 50)
        moradaField.frame = CGRect(x: (largura - (largura-60))/2, y: (altura-430), width: largura-60, height: 50)
        passField.frame = CGRect(x: (largura - (largura-60))/2, y: (altura-370), width: largura-60, height: 50)
        sexoPicker.frame = CGRect(x: (largura - (largura-60))/2, y: (altura-300), width: largura-60, height: 80)
        datePicker.frame = CGRect(x: (largura - (largura-60))/2, y: (altura-220), width: largura-60, height: 80)
        
        cadastrarButton.frame = CGRect(x: (largura - (largura-60))/2, y: (altura-100), width: largura-60, height: 40)
    }
    
    // UIPickerView Delegate & DataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == sexoPicker {
            return sexo.count
        }
        return sexo.count

    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == sexoPicker {
            return sexo[row]
        }
        return sexo[row]

    }
    
    @objc func salvarUser() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy" // Formato de data que será exibido
        let selectedDate = formatter.string(from: datePicker.date) // Pegando a data

    
        guard let nome = nomeField.text,
            let celular = telefoneFeld.text,
            let endereco = moradaField.text,
            let datanac: String = "\(selectedDate)",
            let email = emailField.text,
            let senha = passField.text else { return }
        
        let genero = sexo[sexoPicker.selectedRow(inComponent: 0)]

        print(nome)
        dbHelper.insertUsuario(email: email, senha: senha, dataNac: datanac, nomeCompleto: nome, genero: genero, morada: endereco, telefone: celular, nomeFerramenta: "None", precoFerramenta: 0.0)
       // dbHelper.insertUsuario(email: "email@exemplo.com", senha: "senha123", dataNac: "01/01/1990", nomeCompleto: "Carlos Silva", genero: "Masculino", morada: "Munhava", telefone: "123456789", nomeFerramenta: "None", precoFerramenta: 0.0)

        telaHome()

    }
    
    @objc func telaHome(){
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
