//
//  HomeViewController.swift
//  AR_Card
//
//  Created by hong on 2022/01/01.
//

import UIKit
import FSPagerView
import SnapKit

class HomeViewController: UIViewController {
    
    
    
    private let CardView: FSPagerView = {
        let CardView = FSPagerView()
        CardView.transformer = FSPagerViewTransformer(type: .linear)
        return CardView
    }()
//    private let cardText = UITextField(frame: CGRect(x: 100, y: 50, width: 100, height: 100))
    private let CardInfoButton: UIButton = {
        let CardInfoButton = UIButton()
        CardInfoButton.setTitle("카드 관리", for: .normal)
        CardInfoButton.setTitleColor(.black, for: .normal)
        CardInfoButton.layer.borderWidth = 1
        CardInfoButton.layer.borderColor = UIColor.systemBlue.cgColor
        CardInfoButton.layer.cornerRadius = 10
//        CardInfoButton.frame = CGRect(x: 20, y: 50, width: 100, height: 100)
        return CardInfoButton
    }()
    
    private let AddButton: UIButton = {
        let ARButton = UIButton()
        ARButton.setTitle("카드 추가", for: .normal)
        ARButton.setTitleColor(.black, for: .normal)
//        ARButton.backgroundColor = .yellow
        ARButton.layer.borderColor = UIColor.systemBlue.cgColor
        ARButton.layer.cornerRadius = 10
        ARButton.layer.borderWidth = 1 
//        ARButton.frame = CGRect(x: 200, y: 50, width: 100, height: 100)
        return ARButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        cardText.placeholder = "카드에 넣은 텍스트를 입력해 주세요."
        
        CardInfoButton.addTarget(self, action: #selector(CardInfoButtonTapped), for: .touchUpInside)
        AddButton.addTarget(self, action: #selector(AddButtonTapped), for: .touchUpInside)
        
        CardView.delegate = self
        CardView.dataSource = self
        CardView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        view.addSubview(CardView)
        
        view.addSubview(CardInfoButton)
//        view.addSubview(cardText)
        view.addSubview(AddButton)
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(cardViewUpdate), name: myCardInfoUpdateNoti, object: nil)
        

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        CardInfoButton.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(30)
            make.left.equalTo(self.view.safeAreaLayoutGuide).offset(30)
            make.size.equalTo(CGSize(width: 150, height: 40))
        }
        
        AddButton.snp.makeConstraints { make in
            make.top.equalTo(CardInfoButton)
            make.right.equalTo(self.view.safeAreaLayoutGuide).offset(-30)
            make.size.equalTo(CGSize(width: 150, height: 40))
        }
        
        CardView.snp.makeConstraints { make in
            make.center.equalTo(self.view)
            make.size.equalTo(CGSize(width: 300, height: 300))
        }
    }
    
    @objc func cardViewUpdate() {
        CardView.reloadData()
    }
    
    @objc func CardInfoButtonTapped() {
        
//        myCard.cardName = cardText.text!
        convertView(viewName: "CardInfoView")
//        if cardText.hasText {
//            myCard.cardName = cardText.text!
//            let vc = storyboard?.instantiateViewController(withIdentifier: "ARView")
//            vc?.modalTransitionStyle = .flipHorizontal
//            present(vc!, animated: false, completion: nil)
//        } else {
//            let alert = UIAlertController(title: "", message: "텍스트를 입력해주세요", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
//            self.present(alert, animated: false, completion: nil)
//        }
        
        
    }
    
    @objc func AddButtonTapped() {
        myCardListIdx = -1
        convertView(viewName: "AddCardView")
    }
    
    private func convertView(viewName: String) {
        let vc = storyboard?.instantiateViewController(withIdentifier: viewName)
        vc?.modalTransitionStyle = .flipHorizontal
        present(vc!, animated: false, completion: nil)
    }
    

}

extension HomeViewController: FSPagerViewDelegate, FSPagerViewDataSource {
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return myCardList.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.image = myCardList[index].cardImage
        cell.textLabel?.text = myCardList[index].cardName
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        myCardListIdx = index
        convertView(viewName: "ARView")
    }
    
}
