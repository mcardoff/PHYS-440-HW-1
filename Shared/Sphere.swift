//
//  Sphere.swift
//  HW 1
//
//  Created by Michael Cardiff on 1/26/22.
//

import SwiftUI

class Sphere: Shape {
    
    // necessary variables for calculating and displaying everything on screen
    var radius = 1.0
    var center = (x:0.0, y:0.0, z:0.0)
    @Published var boundingBoxVolume = 0.0
    @Published var boundingBoxSA = 0.0
    @Published var boundingBoxVolText = ""
    @Published var boundingBoxSAText = ""
    
    /// initWithRadius
    /// initializes the sphere object with a given radius, as well as calculates its area
    ///  - Parameter radius: Double precision value of the radius, defaults to 1
    func initWithRadius(radius: Double) async -> Bool {
        
        self.radius = radius
            let _ = await withTaskGroup(of: Void.self) { taskGroup in
                taskGroup.addTask { let _ = await self.calculateVolume(param: radius)}
                taskGroup.addTask { let _ = await self.calculateSurfaceArea(param: radius)}
                taskGroup.addTask { let _ = await self.calculateBoundingBoxVol(radius: radius)}
                taskGroup.addTask { let _ = await self.calculateBoundingBoxSA(radius: radius)}
        }
            await setButtonEnable(state: true)
        return true
    }
    
    /// calculateVolume
    /// Calculates the sphere's volume using the analytic formula
    ///  - Parameter radius: Double precision value of the radius, defaults to 1
    override func calculateVolume(param: Double) async -> Double {
        
        // V = (4/3) * pi * r^3
        let radius = param
        
        let calculatedVolume = (4.0/3.0) * Double.pi * pow(radius,3)
        let newVolumeText = String(format: "%7.5f", calculatedVolume)
        
        await updateVolume(volumeTextString: newVolumeText)
        await newVolumeValue(volume: calculatedVolume)
        
        return calculatedVolume
    }
    
    /// calculateSurfaceArea
    /// Calculates the sphere's surface area using the analytic formula
    ///  - Parameter radius: Double precision value of the radius, defaults to 1
    override func calculateSurfaceArea(param: Double) async -> Double {
        
        // SA = 4 * Pi * r^2
        let radius = param
        
        let calculatedSurfaceArea = 4 * Double.pi * pow(radius,2)
        let newSurfaceAreaText = String(format: "%7.5f", calculatedSurfaceArea)
        
        await updateSurfaceArea(surfaceAreaTextString: newSurfaceAreaText)
        await newSurfaceAreaValue(surfaceArea: calculatedSurfaceArea)
        
        return calculatedSurfaceArea
        
    }
    
    func calculateBoundingBoxVol(radius: Double) async -> Double {
        
        // V_BB = (2 * r) ^ 3
        
        let calculatedVol = pow(2.0 * radius, 3)
        let newVolText = String(format: "%7.5f", calculatedVol)
        
        await updateBoundingBoxVol(boundBoxTextString: newVolText)
        await newBoundingBoxVolValue(volume: calculatedVol)
        
        return calculatedVol
        
    }
    
    func calculateBoundingBoxSA(radius: Double) async -> Double {
        
        // SA_BB = 6 * (2 * r) ^ 2
        
        let calculatedSurfaceArea = 6 * pow(2 * radius, 2)
        let newSurfaceAreaText = String(format: "%7.5f", calculatedSurfaceArea)
        
        await updateBoundingBoxSA(boundBoxTextString: newSurfaceAreaText)
        await newBoundingBoxSAValue(surfaceArea: calculatedSurfaceArea)
        
        return calculatedSurfaceArea
        
    }
    
    @MainActor func newBoundingBoxVolValue(volume: Double) {
        self.boundingBoxVolume = volume
    }
    
    @MainActor func updateBoundingBoxVol(boundBoxTextString: String){
        boundingBoxVolText = boundBoxTextString
    }
    
    @MainActor func newBoundingBoxSAValue(surfaceArea: Double) {
        self.boundingBoxSA = surfaceArea
    }
    
    @MainActor func updateBoundingBoxSA(boundBoxTextString: String){
        boundingBoxSAText = boundBoxTextString
    }
}
