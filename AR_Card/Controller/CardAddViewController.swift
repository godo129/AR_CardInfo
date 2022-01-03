//
//  CardAddViewController.swift
//  AR_Card
//
//  Created by hong on 2022/01/03.
//

import UIKit

class CardAddViewController: UIViewController {
    
    private let Title: UILabel = {
        let title = UILabel()
        title.text = "카드 추가"
        title.textColor = .black
        title.font = .systemFont(ofSize: 30)
        return title
    }()
    
    private let firstNumTextField: UITextField = {
        let firstNumTextField = UITextField()
        firstNumTextField.keyboardType = .numberPad
        return firstNumTextField
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(Title)
        view.addSubview(firstNumTextField)

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        Title.frame = CGRect(x: 20, y: 20, width: 200, height: 40)
        firstNumTextField.frame = CGRect(x: 20, y: 100, width: 50, height: 50)
    }
    
}
