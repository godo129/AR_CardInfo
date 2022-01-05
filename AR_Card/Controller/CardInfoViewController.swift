//
//  CardInfoViewController.swift
//  AR_Card
//
//  Created by hong on 2022/01/05.
//

import UIKit

class CardInfoViewController: UIViewController {
    
    private let CardInfoTable = UITableView()
    
    private let Title: UILabel = {
        let title = UILabel()
        title.text = "카드 정보"
        title.textColor = .black
        title.font = .systemFont(ofSize: 30)
        return title
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        CardInfoTable.register(UITableViewCell.self, forCellReuseIdentifier: "cardCell")
        
        CardInfoTable.delegate = self
        CardInfoTable.dataSource = self

        view.addSubview(Title)
        view.addSubview(CardInfoTable)
    }
 
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        Title.frame = CGRect(x: 20, y: 20, width: 200, height: 40)
        CardInfoTable.frame = view.bounds
    }

}
extension CardInfoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CardInfoTable.dequeueReusableCell(withIdentifier: "cardCell", for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
}
