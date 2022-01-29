//
//  ContentView.swift
//  Shared
//
//  Created by Michael Cardiff on 1/21/22.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject private var sphereModel = Sphere()
    @ObservedObject private var cubeModel = Cube()
    @State var radiusString = "1.0"
    @State var sideLenString = "1.0"
    
    var body: some View {
        
        HStack {
            // Sphere
            VStack{
                Text("Radius")
                    .padding(.top)
                    .padding(.bottom, 0)
                TextField("Enter Radius",
                          text: $radiusString,
                          onCommit: {Task.init {await self.calculateSphere()}})
                    .padding(.horizontal)
                    .frame(width: 100)
                    .padding(.top, 0)
                    .padding(.bottom, 30)
                HStack {
                    VStack{
                        Text("Volume")
                            .padding(.bottom, 0)
                        TextField("",
                                  text: $sphereModel.volumeText)
                            .padding(.horizontal)
                            .frame(width: 100)
                            .padding(.top, 0)
                            .padding(.bottom,30)
                    }
                    
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
                        TextField("", text: ( $sphereModel.surfaceAreaText))
                            .padding(.horizontal)
                            .frame(width: 100)
                            .padding(.top, 0)
                            .padding(.bottom, 30)
                    }
                    
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
                        Text("Bounding Box Vol")
                            .padding(.bottom, 0)
                        TextField("",
                                  text: $sphereModel.boundingBoxVolText)
                            .padding(.horizontal)
                            .frame(width: 100)
                            .padding(.top, 0)
                            .padding(.bottom,30)
                    }
                    
                    VStack{
                        Text("Bounding Box Vol")
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
                        Text("Bounding Box SA")
                            .padding(.bottom, 0)
                        TextField("", text: ( $sphereModel.boundingBoxSAText))
                            .padding(.horizontal)
                            .frame(width: 100)
                            .padding(.top, 0)
                            .padding(.bottom, 30)
                    }
                    
                    VStack{
                        Text("Bounding Box SA")
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
            
            // Cube
            VStack{
                Text("Side Length")
                    .padding(.top)
                    .padding(.bottom, 0)
                TextField("Enter Side Length",
                          text: $sideLenString,
                          onCommit: {Task.init {await self.calculateCube()}})
                    .padding(.horizontal)
                    .frame(width: 100)
                    .padding(.top, 0)
                    .padding(.bottom, 30)
                HStack {
                    VStack{
                        Text("Volume")
                            .padding(.bottom, 0)
                        TextField("",
                                  text: $cubeModel.volumeText)
                            .padding(.horizontal)
                            .frame(width: 100)
                            .padding(.top, 0)
                            .padding(.bottom,30)
                    }
                    
                    VStack{
                        Text("Volume")
                            .padding(.bottom, 0)
                        Text("\(cubeModel.volume, specifier: "%.2f")")
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
                        TextField("", text: ( $cubeModel.surfaceAreaText))
                            .padding(.horizontal)
                            .frame(width: 100)
                            .padding(.top, 0)
                            .padding(.bottom, 30)
                    }
                    
                    VStack{
                        Text("Surface Area")
                            .padding(.bottom, 0)
                        Text("\(cubeModel.surfaceArea, specifier: "%.2f")")
                            .padding(.horizontal)
                            .frame(width: 100)
                            .padding(.top, 0)
                            .padding(.bottom,30)
                    }
                }
                
                Button("Calculate", action: {Task.init { await self.calculateCube()}})
                    .padding(.bottom)
                    .padding()
                    .disabled(cubeModel.enableButton == false)
            }
        }
    }
    
    func calculateSphere() async {
        sphereModel.setButtonEnable(state: false)
        let _ : Bool = await sphereModel.initWithRadius(radius: Double(radiusString)!)
    }
    
    func calculateCube() async {
        cubeModel.setButtonEnable(state: false)
        let _ : Bool = await cubeModel.initWithSideLength(sideLength: Double(radiusString)!)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
