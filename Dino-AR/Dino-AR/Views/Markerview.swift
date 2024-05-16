//
//  Markerview.swift
//  Dino-Ar
//
//  Created by Nowen on 2024-05-14.
//

import SwiftUI
import SceneKit
import ARKit

struct ARViewContainer: UIViewRepresentable {
    var sceneView = ARSCNView()
    var dinosaurNode: SCNNode?
    var isAnimating: Bool = false
    var rotationAngle: Float = .pi
    var defaultAnimationPaused: Bool = false
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(dinosaurNode: dinosaurNode, isAnimating: isAnimating) // Pass isAnimating to Coordinator
    }

    func makeUIView(context: Context) -> ARSCNView {
        sceneView.showsStatistics = true
        sceneView.delegate = context.coordinator

        let pinchGesture = UIPinchGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.handlePinch(_:)))
        sceneView.addGestureRecognizer(pinchGesture)

        // Set initial scale to 50%
        if let node = dinosaurNode {
            node.scale = SCNVector3(0.5, 0.5, 0.5)
        }

        return sceneView
    }

    func updateUIView(_ uiView: ARSCNView, context: Context) {
        let configuration = ARImageTrackingConfiguration()

        if let imageToTrack = ARReferenceImage.referenceImages(inGroupNamed: "Dinosaur", bundle: Bundle.main) {
            configuration.trackingImages = imageToTrack
            configuration.maximumNumberOfTrackedImages = 1
        }

        uiView.session.run(configuration)
    }

    class Coordinator: NSObject, ARSCNViewDelegate {
        var dinosaurNode: SCNNode?
        var isAnimating: Bool // Added property to track animation state
        
        init(dinosaurNode: SCNNode?, isAnimating: Bool) {
            self.dinosaurNode = dinosaurNode
            self.isAnimating = isAnimating // Initialize isAnimating
        }
        
        @objc func handlePinch(_ gesture: UIPinchGestureRecognizer) {
            guard let node = dinosaurNode else { return }
            if gesture.state == .changed {
                let pinchScaleX = Float(gesture.scale)
                let pinchScaleY = Float(gesture.scale)
                let pinchScaleZ = Float(gesture.scale)
                node.scale = SCNVector3(pinchScaleX, pinchScaleY, pinchScaleZ)
            }
        }
        
        // Function to start animation
        func startAnimation() {
            // Check if animation is already running
            guard !isAnimating else { return }
            
            // Start animation
            isAnimating = true
            // Add your animation code here
        }
        
        // Function to stop animation
        func stopAnimation() {
            // Stop all animations
               isAnimating = false
               dinosaurNode?.removeAllActions() // This removes all actions, including explicit animations
               dinosaurNode?.removeAllAnimations() // This removes all implicit animations
           }


        func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
            guard let imageAnchor = anchor as? ARImageAnchor else {
                print("No anchor found")
                return
            }
            print("Found marker: \(imageAnchor.referenceImage.name ?? "Unknown")")
            
            var sceneName: String
            var nodeName: String
            var scaleFactor: Float = 0.1
            var rotationAngle: Float = 0.0
            var positionOffsetx: Float = 0.4
            var positionOffsety: Float = 0.0
            var positionOffsetz: Float = 0.0
            
            if let imageName = imageAnchor.referenceImage.name {
                switch imageName {
                case "marker":
                    sceneName = "Suchominus_-_LowPoly.scn"
                    nodeName = "scene"
      
                    rotationAngle = .pi * 1.5
                    positionOffsetx = 0.2
                    scaleFactor = 0.01
//                    positionOffsetz = 2
                case "marker1":
                    sceneName = "godzilla_Amphibia.scn"
                    nodeName = "root"
                    rotationAngle = .pi
                    positionOffsetx = 0.1
                    scaleFactor = 0.09
                case "marker2":
                    sceneName = "trex.scn"
                    nodeName = "scene"
      
                    rotationAngle = .pi * 1.5
                    positionOffsetx = 0.2
                    scaleFactor = 0.004
//                    positionOffsetz = 2
                default:
                    // Handle other cases if needed
                    print("Unknown image marker: \(imageName)")
                    return
                }
            } else {
                print("No image name found")
                return
            }
            
            guard let scene = SCNScene(named: sceneName) else {
                print("No scene found")
                return
            }
            guard let dinosaurNode = scene.rootNode.childNode(withName: nodeName, recursively: true) else {
                print("No dinosaur node")
                return
            }
            
            // Apply transformations
                dinosaurNode.scale = SCNVector3(scaleFactor, scaleFactor, scaleFactor)
                dinosaurNode.eulerAngles.x = rotationAngle
                dinosaurNode.position = SCNVector3(
                    imageAnchor.transform.columns.3.x + positionOffsetx,
                    imageAnchor.transform.columns.3.y + positionOffsety,
                    imageAnchor.transform.columns.1.z
                )
                
            
            node.addChildNode(dinosaurNode)
            self.dinosaurNode = dinosaurNode
        }



    }
}

struct Markerview: View {
    @State private var isAnimating: Bool = false // Added state variable for animation control
    @State private var rotationAngle: Float = .pi // Added state variable for rotation angle
    
    var body: some View {
        VStack {
            ARViewContainer(isAnimating: isAnimating, rotationAngle: rotationAngle)
            
            Button(action: {
                // Toggle animation state
                self.isAnimating.toggle()
            }, label: {
                Text(isAnimating ? "Stop Animation" : "Play Animation")
            })
            .padding()
            
            Button(action: {
                // Change rotation angle
                switch self.rotationAngle {
                case .pi:
                    self.rotationAngle = .pi / 2 // 90 degrees
                case .pi / 2:
                    self.rotationAngle = .pi * 2 // 360 degrees
                case .pi * 2:
                    self.rotationAngle = .pi * 1.5 // 270 degrees
                default:
                    self.rotationAngle = .pi // Default to 180 degrees
                }
            }, label: {
                Text("Change Rotation Angle")
            })
            .padding()
        }
    }
}

