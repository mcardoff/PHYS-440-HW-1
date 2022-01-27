//
//  Sphere.swift
//  HW 1
//
//  Created by Michael Cardiff on 1/26/22.
//

import SwiftUI

class Sphere: NSObject, ObservableObject {
    
    
    var radius = 1.0
    var center = (x:0.0, y:0.0, z:0.0)
    @Published var volume = 0.0
    @Published var surfaceArea = 0.0
    @Published var volumeText = ""
    @Published var surfaceAreaText = ""
    @Published var enableButton = true
    
    
    func initWithRadius(radius: Double) async -> Bool {
        
        self.radius = radius
       
        let _ = await withTaskGroup(of:  Void.self) { taskGroup in
                taskGroup.addTask { let _ = await self.calculateVolume(radius:radius)}
                taskGroup.addTask { let _ = await self.calculateSurfaceArea(radius: radius)}
            }
            await setButtonEnable(state: true)
        return true
        
    }
    
    func calculateVolume(radius: Double) async -> Double {
        
        // V = (4/3) * pi * r^3
        
        let calculatedVolume = (4.0/3.0) * Double.pi * pow(radius,3)
        let newVolumeText = String(format: "%7.5f", calculatedVolume)
        
        await updateVolume(volumeTextString: newVolumeText)
        await newVolumeValue(volume: calculatedVolume)
        
        return calculatedVolume
        
        
    }
    
    func calculateSurfaceArea(radius: Double) async -> Double {
        
        // SA = 4 * Pi * r^2
        
        let calculatedSurfaceArea = 4 * Double.pi * pow(radius,2)
        let newSurfaceAreaText = String(format: "%7.5f", calculatedSurfaceArea)
        
        await updateSurfaceArea(surfaceAreaTextString: newSurfaceAreaText)
        await newSurfaceAreaValue(surfaceArea: calculatedSurfaceArea)
        
        return calculatedSurfaceArea
        
    }
    
    @MainActor func setButtonEnable(state: Bool){
        if state {
            Task.init {
                await MainActor.run {
                    self.enableButton = true
                }
            }
        }
        else{
            Task.init {
                await MainActor.run {
                    self.enableButton = false
                }
            }
        }
    }
    

    @MainActor func updateVolume(volumeTextString: String){
        volumeText = volumeTextString
    }
    
    @MainActor func newVolumeValue(volume: Double){
        self.volume = volume
    }
    
    @MainActor func newSurfaceAreaValue(surfaceArea: Double){
        self.surfaceArea = surfaceArea
    }
    
    @MainActor func updateSurfaceArea(surfaceAreaTextString:String){
        surfaceAreaText = surfaceAreaTextString
    }
}
