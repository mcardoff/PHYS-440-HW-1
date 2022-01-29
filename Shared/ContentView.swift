//
//  ContentView.swift
//  Shared
//
//  Created by Michael Cardiff on 1/21/22.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject private var sphereModel = Sphere()
    @State var radiusString = "1.0"
    
    var body: some View {
        
        VStack{
            Text("Radius")
                .padding(.top)
                .padding(.bottom, 0)
            Text("\(sphereModel.radius, specifier: "%0.2f")")
                .padding(.horizontal)
                .frame(width: 100)
                .padding(.top, 0)
                .padding(.bottom, 30)
            HStack {
                VStack{
                    Text("Volume")
                        .padding(.bottom, 0)
                    Text("\(sphereModel.volume, specifier: "%.2f")")
                        .padding(.horizontal)
                        .frame(width: 100)
                        .padding(.top, 0)
                        .padding(.bottom,30)
                    
                }
            }
            HStack{
                VStack{
                    Text("Surface Area")
                        .padding(.bottom, 0)
                    Text("\(sphereModel.surfaceArea, specifier: "%.2f")")
                        .padding(.horizontal)
                        .frame(width: 100)
                        .padding(.top, 0)
                        .padding(.bottom,30)
                    
                }
            }
            HStack {
                VStack{
                    Text("Volume Bounding Box")
                        .padding(.bottom, 0)
                    Text("\(sphereModel.boundingBoxVolume, specifier: "%.2f")")
                        .padding(.horizontal)
                        .frame(width: 100)
                        .padding(.top, 0)
                        .padding(.bottom,30)
                    
                }
            }
            HStack{
                VStack{
                    Text("Surface Area Bounding Box")
                        .padding(.bottom, 0)
                    Text("\(sphereModel.boundingBoxSA, specifier: "%.2f")")
                        .padding(.horizontal)
                        .frame(width: 100)
                        .padding(.top, 0)
                        .padding(.bottom,30)
                    
                }
            }
            
            Button("Calculate", action: {Task.init { await self.calculateSphere()}})
                .padding(.bottom)
                .padding()
                .disabled(sphereModel.enableButton == false)
            
            
        }
        
    }
    
    func calculateSphere() async {
        
        sphereModel.setButtonEnable(state: false)
        
        let _ : Bool = await sphereModel.initWithRadius(radius: Double(radiusString)!)
}
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            
    }
}
