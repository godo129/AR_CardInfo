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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // 카드 만들기
        //let planeGeo = SCNPlane(width: 0.1, height: 0.1)
        let planeGeo = SCNBox(width: 0.1, height: 0.1, length: 0.001, chamferRadius: 0.001)
        planeGeo.firstMaterial?.diffuse.contents = UIColor.yellow.cgColor
        
        planeNode.geometry = planeGeo
        planeNode.position = SCNVector3(0,0.1,-0.3)
        
        // 카드 내용
        let textGeo = SCNText(string: myCard.cardName, extrusionDepth: 1.0)
        textGeo.firstMaterial?.diffuse.contents = UIColor.black.cgColor
        
        
        let textNode = SCNNode(geometry: textGeo)
        textNode.position = SCNVector3(0,0,0.001)
        textNode.scale = SCNVector3(0.001,0.001,0.001)
        
        //CVC 내용
        
        let CVCGeo = SCNText(string: "\(myCard.CVCNumber)", extrusionDepth: 1.0)
        CVCGeo.firstMaterial?.diffuse.contents = UIColor.black.cgColor
        
        let CVCNode = SCNNode(geometry: CVCGeo)
        CVCNode.scale = SCNVector3(0.001, 0.001, 0.001)
        CVCNode.position = SCNVector3(0,0,-0.001)
        
        
        //글자 돌리기
        CVCNode.eulerAngles.y = -.pi
        
        
        planeNode.addChildNode(CVCNode)
        planeNode.addChildNode(textNode)
        
        //카드 돌리기
        planeNode.transform = SCNMatrix4MakeRotation(.pi, 0, 1, 0)
        planeNode.position = SCNVector3(0,0.1,-0.3)
        
        
        sceneView.scene.rootNode.addChildNode(planeNode)
        
        gestureRecognizer()
        
     
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

