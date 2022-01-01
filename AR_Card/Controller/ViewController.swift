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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // 카드 만들기
        let planeGeo = SCNPlane(width: 0.1, height: 0.1)
        planeGeo.firstMaterial?.diffuse.contents = UIColor.yellow.cgColor
        
        let planeNode = SCNNode(geometry: planeGeo)
        planeNode.position = SCNVector3(0,0.1,-0.5)
        
        // 카드 내용
        let textGeo = SCNText(string: myCard.cardName, extrusionDepth: 1.0)
        textGeo.firstMaterial?.diffuse.contents = UIColor.black.cgColor
        
        
        let textNode = SCNNode(geometry: textGeo)
        textNode.position = SCNVector3(planeNode.worldPosition.x/2, planeNode.worldPosition.y/2, planeNode.worldPosition.z)
        textNode.scale = SCNVector3(0.001,0.001,0.001)
        
        
        sceneView.scene.rootNode.addChildNode(planeNode)
        sceneView.scene.rootNode.addChildNode(textNode)
     
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

}

