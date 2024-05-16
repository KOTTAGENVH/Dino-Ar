//
//  Coordinator.swift
//  Dino-Ar
//
//  Created by Nowen on 2024-05-14.
//

import Foundation
import ARKit


class Coordinator: NSObject, ARSCNViewDelegate {
    var dinosaurNode: SCNNode?
    var currentScale: SCNVector3 = SCNVector3(0.1, 0.1, 0.1) // Initial scale
    
    lazy var pinchGesture: UIPinchGestureRecognizer = {
        let gesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch(_:)))
        return gesture
    }()
    
    @objc func handlePinch(_ gesture: UIPinchGestureRecognizer) {
        guard let node = dinosaurNode else { return }
        print("dinosaurnode/\(node.name ?? "Unknown")")
        if gesture.state == .changed {
            let pinchScale = Float(gesture.scale)
            let scaledVector = SCNVector3(currentScale.x * pinchScale,
                                          currentScale.y * pinchScale,
                                          currentScale.z * pinchScale)
            node.scale = scaledVector
        } else if gesture.state == .ended {
            // Update current scale after pinch gesture ends
            currentScale = node.scale
        }
    }
}

