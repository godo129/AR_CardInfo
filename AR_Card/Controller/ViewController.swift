//
//  ViewController.swift
//  AR_Card
//
//  Created by hong on 2022/01/01.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    private var planeNode = SCNNode()
    var n = 1
    
    private let myCard = myCardList[myCardListIdx]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // 카드 만들기
        //let planeGeo = SCNPlane(width: 0.1, height: 0.1)
        let planeGeo = SCNBox(width: 0.2, height: 0.2, length: 0.001, chamferRadius: 0.001)
        planeGeo.firstMaterial?.diffuse.contents = myCard.cardImage
        
        planeNode.geometry = planeGeo
        planeNode.position = SCNVector3(0,0.07,-0.3)
        
        // 카드 내용
        let cardNum = "\(myCard.cardFirstNumber)-\(myCard.cardSecondNumber)-\(myCard.cardThirdNumber)-\(myCard.cardFourthNumber)"
        
        let textNode = SCNNode(geometry: makeTextGeo(text: cardNum))
        textNode.position = SCNVector3(-0.09,-0.01,0.001)
        textNode.scale = SCNVector3(0.0015,0.0015,0.0015)
        
        // 유효 날짜
        let limitNum = "\(myCard.monthOfLimit)월 / \(myCard.yearOfLimit)년"
        
        let limitNode = SCNNode(geometry: makeTextGeo(text: limitNum))
        limitNode.position = SCNVector3(-0.09,-0.04,0.001)
        limitNode.scale = SCNVector3(0.001,0.001,0.001)
        
        // 은행 이름
        
        let bankName = "\(myCard.bankName)"
        
        let bankNameNode = SCNNode(geometry: makeTextGeo(text: bankName))
        bankNameNode.position = SCNVector3(-0.09,-0.055,0.001)
        bankNameNode.scale = SCNVector3(0.0008,0.0008,0.0008)
        
        // 카드 이름
        
        let cardName = "\(myCard.cardName)"

        let cardNameNode = SCNNode(geometry: makeTextGeo(text: cardName))
        cardNameNode.position = SCNVector3(0.05,-0.05,0.001)
        cardNameNode.scale = SCNVector3(0.0009,0.0009,0.0009)
        
        
        //CVC 내용
        
        let CVCNum = "CVC : \(myCard.CVCNumber)"
        
        let CVCNode = SCNNode(geometry: makeTextGeo(text: CVCNum))
        CVCNode.scale = SCNVector3(0.0015, 0.0015, 0.0015)
        CVCNode.position = SCNVector3(0.05,-0.02,-0.001)
        
        
        //글자 돌리기
        CVCNode.eulerAngles.y = -.pi
        
        
        planeNode.addChildNode(CVCNode)
        planeNode.addChildNode(textNode)
        planeNode.addChildNode(limitNode)
        planeNode.addChildNode(bankNameNode)
        planeNode.addChildNode(cardNameNode)
        
        
//        //카드 돌리기
//        planeNode.transform = SCNMatrix4MakeRotation(.pi, 0, 1, 0)
//        planeNode.position = SCNVector3(0,0.1,-0.3)
        
        
        sceneView.scene.rootNode.addChildNode(planeNode)
        
        gestureRecognizer()
        
     
    }
    
    private func makeTextGeo(text:String) -> SCNText {
        let textGeo = SCNText(string: text, extrusionDepth: 1.0)
        textGeo.firstMaterial?.diffuse.contents = UIColor.white.cgColor
        return textGeo
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    // MARK: - TapGesture
    private func gestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped))
        self.sceneView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc private func tapped(recognizer: UITapGestureRecognizer) {
        let sceneView = recognizer.view as! SCNView
        let touchLocation = recognizer.location(in: sceneView)
        let hitResults = sceneView.hitTest(touchLocation, options: [:])
        n += 1
        if !hitResults.isEmpty && !(hitResults.first?.node.childNodes.isEmpty)!{
            let node = hitResults[0].node
            node.transform = SCNMatrix4MakeRotation(.pi*Float(n), 0, 1, 0)
            node.position = SCNVector3(0,0.1,-0.3)
            
                        
        }
    }
    
}

