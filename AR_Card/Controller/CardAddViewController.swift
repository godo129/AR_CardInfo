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
        firstNumTextField.keyboardType = .numberPad
        return firstNumTextField
    }()
    
    private let secondNumTextField: UITextField = {
        let secondNumTextField = UITextField()
        secondNumTextField.layer.borderColor = UIColor.black.cgColor
        secondNumTextField.layer.borderWidth = 2
        secondNumTextField.keyboardType = .numberPad
        return secondNumTextField
    }()
    
    private let thirdNumTextField: UITextField = {
        let thirdNumTextField = UITextField()
        thirdNumTextField.layer.borderColor = UIColor.black.cgColor
        thirdNumTextField.layer.borderWidth = 2
        thirdNumTextField.keyboardType = .numberPad
        return thirdNumTextField
    }()
    
    private let fourthNumTextField: UITextField = {
        let fourthNumTextField = UITextField()
        fourthNumTextField.layer.borderColor = UIColor.black.cgColor
        fourthNumTextField.layer.borderWidth = 2
        fourthNumTextField.keyboardType = .numberPad
        return fourthNumTextField
    }()
    
    private let monthOfLimitTextField: UITextField = {
        let monthOfLimitTextField = UITextField()
        monthOfLimitTextField.layer.borderColor = UIColor.black.cgColor
        monthOfLimitTextField.layer.borderWidth = 2
        monthOfLimitTextField.keyboardType = .numberPad
        monthOfLimitTextField.tag = 1
        return monthOfLimitTextField
    }()
    
    private let yearOfLimitTextField: UITextField = {
        let yearOfLimitTextField = UITextField()
        yearOfLimitTextField.layer.borderColor = UIColor.black.cgColor
        yearOfLimitTextField.layer.borderWidth = 2
        yearOfLimitTextField.keyboardType = .numberPad
        yearOfLimitTextField.tag = 2
        return yearOfLimitTextField
    }()
    
    private let cvcNumTextField: UITextField = {
        let cvcNumTextField = UITextField()
        cvcNumTextField.layer.borderColor = UIColor.black.cgColor
        cvcNumTextField.layer.borderWidth = 2
        cvcNumTextField.keyboardType = .numberPad
        cvcNumTextField.tag = 3
        return cvcNumTextField
    }()
    
    private let bankNameTextField: UITextField = {
        let bankNameTextField = UITextField()
        bankNameTextField.layer.borderColor = UIColor.black.cgColor
        bankNameTextField.layer.borderWidth = 2
        return bankNameTextField
    }()
    
    private let cardNameTextField: UITextField = {
        let cardNameTextField = UITextField()
        cardNameTextField.layer.borderColor = UIColor.black.cgColor
        cardNameTextField.layer.borderWidth = 2
        return cardNameTextField
    }()
    
    private let recordButton: UIButton = {
        let recordButton = UIButton()
        recordButton.setTitle("저장", for: .normal)
        recordButton.setTitleColor(.black, for: .normal)
        recordButton.backgroundColor = .orange
        return recordButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstNumTextField.delegate = self
        secondNumTextField.delegate = self
        thirdNumTextField.delegate = self
        fourthNumTextField.delegate = self
        monthOfLimitTextField.delegate = self
        yearOfLimitTextField.delegate = self
        cvcNumTextField.delegate = self
        
        firstNumTextField.text = "\(myCard.cardFirstNumber)"
        secondNumTextField.text = "\(myCard.cardSecondNumber)"
        thirdNumTextField.text = "\(myCard.cardThirdNumber)"
        fourthNumTextField.text = "\(myCard.cardFourthNumber)"
        monthOfLimitTextField.text = "\(myCard.monthOfLimit)"
        yearOfLimitTextField.text = "\(myCard.yearOfLimit)"
        cvcNumTextField.text = "\(myCard.CVCNumber)"
        bankNameTextField.text = "\(myCard.bankName)"
        cardNameTextField.text = "\(myCard.cardName)"
        
        recordButton.addTarget(self, action: #selector(recordButtonTapped), for: .touchUpInside)
        
        view.addSubview(Title)
        view.addSubview(firstNumTextField)
        view.addSubview(secondNumTextField)
        view.addSubview(thirdNumTextField)
        view.addSubview(fourthNumTextField)
        view.addSubview(monthOfLimitTextField)
        view.addSubview(yearOfLimitTextField)
        view.addSubview(cvcNumTextField)
        view.addSubview(bankNameTextField)
        view.addSubview(cardNameTextField)
        view.addSubview(recordButton)
        
        print(myCard)

    }
    
    @objc private func recordButtonTapped() {
        saveData()
        dismiss(animated: false)
    }
    
    func saveData() {
        guard let firstNum = firstNumTextField.text else {return}
        myCard.cardFirstNumber = firstNum
        guard let secondNum = secondNumTextField.text else {return}
        myCard.cardSecondNumber = secondNum
        guard let thirdNum = thirdNumTextField.text else {return}
        myCard.cardThirdNumber = thirdNum
        guard let fourthNum = fourthNumTextField.text else {return}
        myCard.cardFourthNumber = fourthNum
        guard let monthOfLimit = monthOfLimitTextField.text else {return}
        myCard.monthOfLimit = monthOfLimit
        guard let yearOfLimit = yearOfLimitTextField.text else {return}
        myCard.yearOfLimit = yearOfLimit
        guard let cvcNum = cvcNumTextField.text else {return}
        myCard.CVCNumber = cvcNum
        guard let bankName = bankNameTextField.text else {return}
        myCard.bankName = bankName
        guard let cardName = cardNameTextField.text else {return}
        print(cardName)
        myCard.cardName = cardName
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        Title.frame = CGRect(x: 20, y: 20, width: 200, height: 40)
        firstNumTextField.frame = CGRect(x: 20, y: 100, width: 70, height: 50)
        secondNumTextField.frame = CGRect(x: 120, y: 100, width: 70, height: 50)
        thirdNumTextField.frame = CGRect(x: 220, y: 100, width: 70, height: 50)
        fourthNumTextField.frame = CGRect(x: 320, y: 100, width: 70, height: 50)
        monthOfLimitTextField.frame = CGRect(x: 200, y: 200, width: 50, height: 50)
        yearOfLimitTextField.frame = CGRect(x: 250, y: 200, width: 50, height: 50)
        
        cvcNumTextField.frame = CGRect(x: 20, y: 200, width: 100, height: 50)
        bankNameTextField.frame = CGRect(x: 20, y: 250, width: 100, height: 50)
        cardNameTextField.frame = CGRect(x: 20, y: 300, width: 100, height: 50)
        recordButton.frame = CGRect(x: 100, y: 250, width: 100, height: 100)
    }

    
}

//MARK: - UITextField Delegate
// UITextField 한계 설정 
extension CardAddViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        func textFieldOption(length: Int) -> Bool {
            let cs = NSCharacterSet(charactersIn: "0123456789").inverted
            let filtered = string.components(separatedBy: cs).joined(separator: "")
            
            // 백스페이스
            if string.isEmpty {
                return true
            }
            // 텍스트 길이 범주
            if textField.text!.count > length {
                return false
            }
            return (string == filtered)
        }
        
        if textField.tag == 1 || textField.tag == 2 {
            return textFieldOption(length: 1)
        } else if textField.tag == 3 {
            return textFieldOption(length: 2)
        } else {
            return textFieldOption(length: 3)
        }

    }
    
}
