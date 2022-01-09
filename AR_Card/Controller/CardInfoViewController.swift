//
//  CardInfoViewController.swift
//  AR_Card
//
//  Created by hong on 2022/01/05.
//

import UIKit

class CardInfoViewController: UIViewController {
    
    private let CardInfoTable = UITableView()
    
    private let header: UIView = {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
        
        let headerLabel = UILabel(frame: header.bounds)
        headerLabel.text = "카드 관리"
        headerLabel.font = .systemFont(ofSize: 30, weight: .bold)
        header.addSubview(headerLabel)
        return header
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        CardInfoTable.allowsSelection = false
        CardInfoTable.tableHeaderView = header
        
        CardInfoTable.register(UITableViewCell.self, forCellReuseIdentifier: "cardCell")
        
        CardInfoTable.delegate = self
        CardInfoTable.dataSource = self

        view.addSubview(CardInfoTable)
        
        let noti = NotificationCenter.default
        noti.addObserver(self, selector: #selector(myCardInfoUpdate), name: myCardInfoUpdateNoti, object: nil)
    }
    
    @objc private func myCardInfoUpdate() {
        CardInfoTable.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.post(name: myCardInfoUpdateNoti, object: nil)
    }
 
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        CardInfoTable.frame = view.bounds
    }

}
extension CardInfoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cardCell", for: indexPath)
            
        let img = myCardList[indexPath.row].cardImage.resizeImageWithHeight(newW: view.frame.size.width/3, newH: view.frame.size.height/5)

        cell.imageView?.image = img
        cell.textLabel?.text = myCardList[indexPath.row].cardName
        cell.imageView?.contentMode = UIView.ContentMode.scaleAspectFit

        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myCardList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height/5
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let removeButton = UITableViewRowAction(style: .normal, title: "삭제") { (rowAction, indexpath) in
            myCardList.remove(at: indexPath.row)
            tableView.reloadData()
        }
        removeButton.backgroundColor = .red
        
        let editButton = UITableViewRowAction(style: .normal, title: "수정") { (rowAction, indexpath) in
            myCardListIdx = indexpath.row
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddCardView")
            vc?.modalTransitionStyle = .flipHorizontal
            self.present(vc!, animated: false, completion: nil)
            
        }
        editButton.backgroundColor = .orange
        
        let cancelButton = UITableViewRowAction(style: .normal, title: "취소") { (rowAction, indexpath) in
            print("cancel button tapped")
        }
        cancelButton.backgroundColor = .green
        
        return [cancelButton,editButton,removeButton]
    }
}


extension UIImage{
    func resizeImageWithHeight(newW: CGFloat, newH: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContext(CGSize(width: newW, height: newH))
        self.draw(in: CGRect(x: 0, y: 0, width: newW, height: newH))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}
