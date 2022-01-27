//
//  Sphere.swift
//  HW 1
//
//  Created by Michael Cardiff on 1/21/22.
//

import SwiftUI

class Sphere: NSObject, ObservableObject {
    var radius = 0.0
    @Published var radiusString = "0.0"
    
    // from equivalent 'ellipse' class for 2d shapes
    var centerOfASphere = (x:0.0, y:0.0, z:0.0)
    @Published var volume = 0.0
    @Published var surfaceArea = 0.0
    @Published var volumeText = ""
    @Published var surfaceAreaText = ""
    @Published var enableButton = true
    
    func initWithRadius(radius: Double) async -> Bool {
        self.radius = radius
        
        let _ = await withTaskGroup(of:  Void.self) { taskGroup in

            taskGroup.addTask { let _ = await self.calculateVolume(radius: self.radius)}
            taskGroup.addTask { let _ = await self.calculateSurfaceArea(radius: self.radius)}

    }
        await setButtonEnable(state: true)
        
     return true
    }
    
    func calculateVolume(radius:Double) async -> Double {
        // volume = (4/3) * Pi * radius^3
        let calculatedVolume = (4.0/3.0) * Double.pi * pow(radius, 3.0)
        let newVolumeText = String(format: "%7.5f", calculatedVolume)
        
        await updateVolume(volumeTextString: newVolumeText)
        await newVolumeValue(volumeValue: calculatedVolume)
        
        return calculatedVolume
    }
    
    func calculateSurfaceArea(radius:Double) async -> Double {
        // surface area = 4 * Pi * radius^2
        let calculatedSurfaceArea = 4.0 * Double.pi * pow(radius, 2.0)
        let newSurfaceAreaText = String(format: "%7.5f", calculatedSurfaceArea)
        
        await updateSurfaceArea(surfaceAreaTextString: newSurfaceAreaText)
        await newSurfaceAreaValue(surfaceAreaValue: calculatedSurfaceArea)
        
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
    
    @MainActor func updateVolume(volumeTextString: String) {
        volumeText = volumeTextString
    }
    
    @MainActor func updateSurfaceArea(surfaceAreaTextString: String) {
        surfaceAreaText = surfaceAreaTextString
    }
    
    @MainActor func newVolumeValue(volumeValue: Double) {
        self.volume = volumeValue
    }
    
    @MainActor func newSurfaceAreaValue(surfaceAreaValue: Double) {
        self.surfaceArea = surfaceAreaValue
    }
}
