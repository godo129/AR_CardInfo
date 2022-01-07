//
//  CardAddViewController.swift
//  AR_Card
//
//  Created by hong on 2022/01/03.
//

import UIKit
import TextFieldEffects
import SnapKit

class CardAddViewController: UIViewController {
    
    private var myCard = cardManager(cardFirstNumber: "0000",
                             cardSecondNumber: "0000",
                             cardThirdNumber: "0000",
                             cardFourthNumber: "0000",
                             monthOfLimit: "01",
                             yearOfLimit: "22",
                             cardName: "내카드",
                             CVCNumber: "000",
                             bankName: "00은행",
                             cardImage: UIImage(named: "image1")!)
    
    private let cardImageView: UIImageView = {
        let cardImageView = UIImageView()
        cardImageView.layer.cornerRadius = 100
        return cardImageView
    }()
    
    private let Title: UILabel = {
        let title = UILabel()
        title.text = "카드 추가"
        title.textColor = .black
        title.font = .systemFont(ofSize: 30)
        return title
    }()
    
    private let firstNumTextField: HoshiTextField = {
        let firstNumTextField = HoshiTextField()
        firstNumTextField.borderActiveColor = .gray
        firstNumTextField.textAlignment = .center
        firstNumTextField.keyboardType = .numberPad
        return firstNumTextField
    }()
    
    private let secondNumTextField: HoshiTextField = {
        let secondNumTextField = HoshiTextField()
        secondNumTextField.borderActiveColor = .gray
        secondNumTextField.textAlignment = .center
        secondNumTextField.keyboardType = .numberPad
        return secondNumTextField
    }()
    
    private let thirdNumTextField: HoshiTextField = {
        let thirdNumTextField = HoshiTextField()
        thirdNumTextField.borderActiveColor = .gray
        thirdNumTextField.textAlignment = .center
        thirdNumTextField.keyboardType = .numberPad
        return thirdNumTextField
    }()
    
    private let fourthNumTextField: HoshiTextField = {
        let fourthNumTextField = HoshiTextField()
        fourthNumTextField.borderActiveColor = .gray
        fourthNumTextField.textAlignment = .center
        fourthNumTextField.keyboardType = .numberPad
        return fourthNumTextField
    }()
    
    private let monthOfLimitTextField: HoshiTextField = {
        let monthOfLimitTextField = HoshiTextField()
        monthOfLimitTextField.placeholder = "MONTH"
        monthOfLimitTextField.placeholderColor = .lightGray
        monthOfLimitTextField.borderActiveColor = .gray
        monthOfLimitTextField.keyboardType = .numberPad
        monthOfLimitTextField.tag = 1
        return monthOfLimitTextField
    }()
    
    private let yearOfLimitTextField: HoshiTextField = {
        let yearOfLimitTextField = HoshiTextField()
        yearOfLimitTextField.placeholder = "YEAR"
        yearOfLimitTextField.placeholderColor = .lightGray
        yearOfLimitTextField.borderActiveColor = .gray
        yearOfLimitTextField.keyboardType = .numberPad
        yearOfLimitTextField.tag = 2
        return yearOfLimitTextField
    }()
    
    private let cvcNumTextField: HoshiTextField = {
        let cvcNumTextField = HoshiTextField()
        cvcNumTextField.placeholder = "CVC"
        cvcNumTextField.placeholderColor = .lightGray
        cvcNumTextField.borderActiveColor = .gray
        cvcNumTextField.keyboardType = .numberPad
        cvcNumTextField.tag = 3
        return cvcNumTextField
    }()
    
    private let bankNameTextField: HoshiTextField = {
        let bankNameTextField = HoshiTextField()
        bankNameTextField.placeholder = "은행"
        bankNameTextField.placeholderColor = .lightGray
        bankNameTextField.borderActiveColor = .gray
        return bankNameTextField
    }()
    
    private let cardNameTextField: HoshiTextField = {
        let cardNameTextField = HoshiTextField()
        cardNameTextField.placeholder = "카드 별명"
        cardNameTextField.placeholderColor = .lightGray
        cardNameTextField.borderActiveColor = .gray
        return cardNameTextField
    }()
    
    private let recordButton: UIButton = {
        let recordButton = UIButton()
        recordButton.setTitle("저장", for: .normal)
        recordButton.setTitleColor(.black, for: .normal)
        recordButton.layer.borderWidth = 1.5
        recordButton.layer.cornerRadius = 20
        recordButton.layer.borderColor = UIColor.systemBlue.cgColor
        return recordButton
    }()
    
    
    private let imageChangeButton: UIButton = {
        let imageChangeButton = UIButton()
        imageChangeButton.setTitle("사진 선택", for: .normal)
        imageChangeButton.setTitleColor(.black, for: .normal)
        imageChangeButton.layer.borderWidth = 1.5
        imageChangeButton.layer.borderColor = UIColor.systemTeal.cgColor
        imageChangeButton.layer.cornerRadius = 15
        return imageChangeButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if myCardListIdx != -1 {
            myCard = myCardList[myCardListIdx]
        }
        
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
        cardImageView.image = myCard.cardImage
        
        recordButton.addTarget(self, action: #selector(recordButtonTapped), for: .touchUpInside)
        imageChangeButton.addTarget(self, action: #selector(imageChangeButtonTapped), for: .touchUpInside)
        
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
        view.addSubview(imageChangeButton)
        view.addSubview(cardImageView)

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.post(name: myCardInfoUpdateNoti, object: nil)
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
        myCard.cardName = cardName
        
        if myCardListIdx == -1 {
            myCardList.append(myCard)
        } else {
            myCardList[myCardListIdx] = myCard
        }
        
    }
    
    private func cameraOption() {
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    private func albumOption() {
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    
    @objc private func imageChangeButtonTapped() {
        let alert = UIAlertController(title: "카드 이미지 선택", message: "", preferredStyle: .actionSheet)
        
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        let album = UIAlertAction(title: "앨범", style: .default) { [weak self] _ in
            self?.albumOption()
        }
        let camera = UIAlertAction(title: "카메라", style: .default) { [weak self] _ in
            self?.cameraOption()
        }
        
        
        alert.addAction(cancel)
        alert.addAction(album)
        alert.addAction(camera)

        present(alert, animated: false, completion: nil)
  
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
//        Title.frame = CGRect(x: 20, y: 20, width: 200, height: 40)
        Title.snp.makeConstraints { make in
            make.left.equalTo(self.view.safeAreaLayoutGuide).offset(10)
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(20)
            make.size.equalTo(CGSize(width: 200, height: 40))
        }
        
//        recordButton.frame = CGRect(x: 260, y: 20, width: 100, height: 40)
        recordButton.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(20)
            make.right.equalTo(self.view.safeAreaLayoutGuide).offset(-15)
            make.size.equalTo(CGSize(width: 100, height: 40))
        }
        
        
//        firstNumTextField.frame = CGRect(x: 20, y: 100, width: 70, height: 50)
//        secondNumTextField.frame = CGRect(x: 120, y: 100, width: 70, height: 50)
//        thirdNumTextField.frame = CGRect(x: 220, y: 100, width: 70, height: 50)
//        fourthNumTextField.frame = CGRect(x: 320, y: 100, width: 70, height: 50)
        
        firstNumTextField.snp.makeConstraints { make in
            make.top.equalTo(Title).offset(60)
            make.left.equalTo(self.view.safeAreaLayoutGuide).offset(20)
            make.size.equalTo(CGSize(width: 70, height: 50))
        }
        
        secondNumTextField.snp.makeConstraints { make in
            make.top.equalTo(Title).offset(60)
            make.left.equalTo(firstNumTextField).offset(90)
            make.size.equalTo(CGSize(width: 70, height: 50))
        }
        
        thirdNumTextField.snp.makeConstraints { make in
            make.top.equalTo(Title).offset(60)
            make.left.equalTo(secondNumTextField).offset(90)
            make.size.equalTo(CGSize(width: 70, height: 50))
        }
        
        fourthNumTextField.snp.makeConstraints { make in
            make.top.equalTo(Title).offset(60)
            make.left.equalTo(thirdNumTextField).offset(90)
            make.size.equalTo(CGSize(width: 70, height: 50))
        }
//
//        monthOfLimitTextField.frame = CGRect(x: 20, y: 150, width: 50, height: 50)
//        yearOfLimitTextField.frame = CGRect(x: 70, y: 150, width: 50, height: 50)
        
        monthOfLimitTextField.snp.makeConstraints { make in
            make.top.equalTo(firstNumTextField).offset(60)
            make.left.equalTo(firstNumTextField)
            make.size.equalTo(CGSize(width: 50, height: 50))
        }
        
        yearOfLimitTextField.snp.makeConstraints { make in
            make.top.equalTo(monthOfLimitTextField)
            make.left.equalTo(monthOfLimitTextField).offset(50)
            make.size.equalTo(monthOfLimitTextField)
        }
//
//        cvcNumTextField.frame = CGRect(x: 20, y: 200, width: 100, height: 50)
//        bankNameTextField.frame = CGRect(x: 20, y: 250, width: 100, height: 50)
//        cardNameTextField.frame = CGRect(x: 20, y: 300, width: 100, height: 50)
        
        cvcNumTextField.snp.makeConstraints { make in
            make.top.equalTo(monthOfLimitTextField).offset(55)
            make.left.equalTo(monthOfLimitTextField)
            make.size.equalTo(CGSize(width: 100, height: 50))
        }
        bankNameTextField.snp.makeConstraints { make in
            make.top.equalTo(cvcNumTextField).offset(55)
            make.left.equalTo(monthOfLimitTextField)
            make.size.equalTo(CGSize(width: 100, height: 50))
        }
        cardNameTextField.snp.makeConstraints { make in
            make.top.equalTo(bankNameTextField).offset(55)
            make.left.equalTo(monthOfLimitTextField)
            make.size.equalTo(CGSize(width: 100, height: 50))
        }
        
//        cardImageView.frame = CGRect(x: 140, y: 170, width: 200, height: 150)
        
        cardImageView.snp.makeConstraints { make in
            make.top.equalTo(monthOfLimitTextField)
            make.left.equalTo(yearOfLimitTextField).offset(55)
            make.right.equalTo(fourthNumTextField)
            make.bottom.equalTo(cardNameTextField).offset(-50)
        }

//        imageChangeButton.frame = CGRect(x: 200, y: 340, width: 100, height: 30)
        
        imageChangeButton.snp.makeConstraints { make in
            make.top.equalTo(bankNameTextField).offset(70)
            make.left.equalTo(secondNumTextField).offset(90)
            make.right.equalTo(fourthNumTextField).offset(-50)
            make.bottom.equalTo(cardNameTextField)
        }
        
    }

    
}

//MARK: - UITextField Delegate
// UITextField 한계 설정 
extension CardAddViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        func limitCharacters(characters: String) -> Bool {
            let cs = NSCharacterSet(charactersIn: characters).inverted
            let filtered = string.components(separatedBy: cs).joined(separator: "")
            return (string == filtered)
        }
        
        func textFieldOption(length: Int) -> Bool {
            if textField.tag == 1 {
                if textField.text!.count == 0{
                    
                    return limitCharacters(characters: "01")
                } else {
                    if textField.text == "1" {
                        
                        return limitCharacters(characters: "012")
                    } else if textField.text == "0" {
                        
                        return limitCharacters(characters: "123456789")
                    }
                }
            }
            
            // 백스페이스
            if string.isEmpty {
                return true
            }
            // 텍스트 길이 범주
            if textField.text!.count > length {
                return false
            }
            return limitCharacters(characters: "0123456789")
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

//MARK: - UIImagePickerController, UINavigationController Delegate
extension CardAddViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var newImage : UIImage? = nil
        
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            newImage = image
        } else if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            newImage = image
        }
        myCard.cardImage = newImage!
        cardImageView.image = newImage
        
        picker.dismiss(animated: true, completion: nil)
    }
}
