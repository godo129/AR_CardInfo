//
//  HomeViewController.swift
//  AR_Card
//
//  Created by hong on 2022/01/01.
//

import UIKit

class HomeViewController: UIViewController {
    
    private let cardText = UITextField(frame: CGRect(x: 100, y: 50, width: 100, height: 100))
    private let ARButton: UIButton = {
        let ARButton = UIButton()
        ARButton.setTitle("Go", for: .normal)
        ARButton.setTitleColor(.black, for: .normal)
        ARButton.backgroundColor = .orange
        ARButton.frame = CGRect(x: 100, y: 200, width: 100, height: 100)
        return ARButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardText.placeholder = "카드에 넣은 텍스트를 입력해 주세요."
        
        ARButton.addTarget(self, action: #selector(ARButtonTapped), for: .touchUpInside)
        
        view.addSubview(ARButton)
        view.addSubview(cardText)

    }
    
    @objc func ARButtonTapped() {
        
        if cardText.hasText {
            myCard.cardName = cardText.text!
            let vc = storyboard?.instantiateViewController(withIdentifier: "ARView")
            vc?.modalTransitionStyle = .flipHorizontal
            present(vc!, animated: false, completion: nil)
        } else {
            let alert = UIAlertController(title: "", message: "텍스트를 입력해주세요", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: false, completion: nil)
        }
        
        
    }
    

}
