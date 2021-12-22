//
//  ContentView.swift
//  Tank
//
//  Created by lollipop on 2021/12/22.
//

import SwiftUI
import RealityKit

struct ContentView : View {
    var tankAnchor = try? TinyToyTank.load_TinyToyTank()
    
    var names = ["TurretLeft","CannonFire","TurretRight","TankLeft","TankForward","TankRight"]
    var scale: CGFloat = 6.1
    var body: some View {
        let actions :[()-> Void] = [{
            tankAnchor?.notifications.turretLeft.post()
        },{
            tankAnchor?.notifications.cannonFire.post()
        },{
            tankAnchor?.notifications.turretRight.post()
        },{
            tankAnchor?.notifications.tankLeft.post()
        },{
            tankAnchor?.notifications.tankForward.post()
        },{
            tankAnchor?.notifications.tankRight.post()
        }]
        ZStack{
            ARViewContainer(tankAnchor: tankAnchor!).edgesIgnoringSafeArea(.all)
            GeometryReader{
                geo in
                VStack {
                    Spacer()
                    HStack{
                        Spacer()
                        
                        ForEach(0..<3){
                            index in
                            Button(action: actions[index]){
                                Image(names[index]).resizable().frame(width: geo.size.width / scale, height: geo.size.width / scale)
                                }
                            }
                        
                        Spacer()
                    }
                    
                    HStack{
                        Spacer()
                        
                        ForEach(3..<6){
                            index in
                            Button(action: actions[index]){
                                Image(names[index]).resizable().frame(width: geo.size.width / scale, height: geo.size.width / scale)
                                }
                            }
                        
                        Spacer()
                    }
                }
                    
                    

                }
            
            
            
           
        }
        
    }
}

struct ARViewContainer: UIViewRepresentable {
    let tankAnchor:TinyToyTank._TinyToyTank
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        tankAnchor.turret?.setParent(tankAnchor.tank, preservingWorldTransform: true)
        
        arView.scene.anchors.append(tankAnchor)
        
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
