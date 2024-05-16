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
    @State private var noMarkerDetected = false
    @State private var currentImageName: String?
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(dinosaurNode: dinosaurNode, noMarkerDetected: $noMarkerDetected)
    }
    
    func makeUIView(context: Context) -> ARSCNView {
        sceneView.showsStatistics = false
        sceneView.delegate = context.coordinator
        
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
        @Binding var noMarkerDetected: Bool
        
        init(dinosaurNode: SCNNode?, noMarkerDetected: Binding<Bool>) {
            self.dinosaurNode = dinosaurNode
            self._noMarkerDetected = noMarkerDetected
        }
        
        func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
            guard let imageAnchor = anchor as? ARImageAnchor else {
                print("No anchor found")
                stopSound()
                return
            }
            print("Found marker: \(imageAnchor.referenceImage.name ?? "Unknown")")
            print("Found imageAnchor: \(imageAnchor.isTracked)")
            if !imageAnchor.isTracked {
                stopSound()
                print("Not pointed to marker")
                self.noMarkerDetected = true
                return
            }
            
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
                    playSound(sound: "Suchomimus", type: "mp3")
                    rotationAngle = .pi * 1.5
                    positionOffsetx = 0.2
                    scaleFactor = 0.01
                    
                case "marker1":
                    sceneName = "godzilla_Amphibia.scn"
                    nodeName = "root"
                    playSound(sound: "godzilla​_amphibia ", type: "mp3")
                    rotationAngle = .pi
                    positionOffsetx = 0.1
                    scaleFactor = 0.09
                    
                case "marker2":
                    sceneName = "trex.scn"
                    nodeName = "scene"
                    playSound(sound: "trex", type: "mp3")
                    rotationAngle = .pi * 1.5
                    positionOffsetx = 0.2
                    scaleFactor = 0.004
                    
                case "marker3":
                    sceneName = "Flying_Pteradactal_Dinosaur.scn"
                    nodeName = "scene"
                    playSound(sound: "pterodactyl", type: "mp3")
                    rotationAngle = .pi * 1.5
                    positionOffsetx = 0.2
                    scaleFactor = 0.01
                    
                case "marker4":
                    sceneName = "archaeopteryx.scn"
                    nodeName = "scene"
                    playSound(sound: "archaeopteryx", type: "mp3")
                    rotationAngle = .pi * 1.5
                    positionOffsetx = 0.2
                    scaleFactor = 0.03
                    
                case "marker5":
                    sceneName = "Mosasaurus.scn"
                    nodeName = "scene"
                    playSound(sound: "mosasaurus", type: "mp3")
                    rotationAngle = .pi * 1.5
                    positionOffsetx = 0.2
                    scaleFactor = 0.004
                    positionOffsetz = 1
                    
                case "marker6":
                    sceneName = "Animated_T-Rex_Dinosaur_Fight_Loop.scn"
                    nodeName = "scene"
                    playSound(sound: "trex_fighting", type: "mp3")
                    rotationAngle = .pi * 1.5
                    positionOffsetx = 0.2
                    scaleFactor = 0.005
                    
                case "marker7":
                    sceneName = "Triceratops.scn"
                    nodeName = "scene"
                    playSound(sound: "Triceratop", type: "mp3")
                    rotationAngle = .pi * 1.5
                    positionOffsetx = 0.2
                    scaleFactor = 0.008
                    
                    positionOffsety = 1
                case "marker8":
                    sceneName = "triceratops_skeleton.scn"
                    nodeName = "scene"
                    playSound(sound: "Triceratop", type: "mp3")
                    rotationAngle = .pi * 1.5
                    positionOffsetx = 0.2
                    scaleFactor = 0.01
                    
                case "marker9":
                    sceneName = "STEGO.scn"
                    nodeName = "scene"
                    playSound(sound: "stegosaurus", type: "mp3")
                    rotationAngle = .pi * 1.5
                    positionOffsetx = 0.2
                    scaleFactor = 0.01
                default:
                    print("Unknown image marker: \(imageName)")
                    noMarkerDetected = true
                    return
                }
            } else {
                print("No image name found")
                noMarkerDetected = true
                stopSound()
                return
            }
            
            guard let scene = SCNScene(named: sceneName) else {
                print("No scene found")
                noMarkerDetected = true
                stopSound()
                return
            }
            guard let dinosaurNode = scene.rootNode.childNode(withName: nodeName, recursively: true) else {
                print("No dinosaur node")
                noMarkerDetected = true
                stopSound()
                return
            }
            
            dinosaurNode.scale = SCNVector3(scaleFactor, scaleFactor, scaleFactor)
            dinosaurNode.eulerAngles.x = rotationAngle
            dinosaurNode.position = SCNVector3(
                imageAnchor.transform.columns.3.x + positionOffsetx,
                imageAnchor.transform.columns.3.y + positionOffsety,
                imageAnchor.transform.columns.1.z
            )
            
            node.addChildNode(dinosaurNode)
            self.dinosaurNode = dinosaurNode
            noMarkerDetected = false
        }
    }
}

struct Markerview: View {
    @State private var isAnimating: Bool = false // Added state variable for animation control
    @State private var rotationAngle: Float = .pi // Added state variable for rotation angle
    @State private var  isMute = false
    
    var body: some View {
        VStack {
            ARViewContainer( rotationAngle: rotationAngle)
            
            Button(action: {
                isMute.toggle()
                if isMute {
                    stopSound()
                }else {
                    playLaterSound()
                }
            }) {
                if isMute == false {
                    MuteIcon()
                } else {
                    SpeakerIcon()
                }
            }
            .padding()
        }
    }
}

