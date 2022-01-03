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
        firstNumTextField.layer.borderColor = UIColor.black.cgColor
        firstNumTextField.layer.borderWidth = 2
        return firstNumTextField
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstNumTextField.delegate = self
        
        view.addSubview(Title)
        view.addSubview(firstNumTextField)

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        Title.frame = CGRect(x: 20, y: 20, width: 200, height: 40)
        firstNumTextField.frame = CGRect(x: 20, y: 100, width: 200, height: 50)
    }
    
}

//MARK: - UITextField Delegate
// UITextField 한계 설정 
extension CardAddViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let cs = NSCharacterSet(charactersIn: "0123456789").inverted
        let filtered = string.components(separatedBy: cs).joined(separator: "")
        
        // 백스페이스
        if string.isEmpty {
            return true
        }
        
        // 텍스트 길이 범주
        if textField.text!.count > 3 {
            return false
        }
        
        return (string == filtered)
        
    }

}
