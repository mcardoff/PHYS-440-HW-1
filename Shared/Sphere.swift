//
//  Sphere.swift
//  HW 1
//
//  Created by Michael Cardiff on 1/26/22.
//

import SwiftUI

class Sphere: NSObject, ObservableObject {
    
    // necessary variables for calculating and displaying everything on screen
    var radius = 1.0
    var center = (x:0.0, y:0.0, z:0.0)
    // updated when initWithRadius is called
    // sphere only
    @Published var volume = 0.0
    @Published var surfaceArea = 0.0
    @Published var volumeText = ""
    @Published var surfaceAreaText = ""
    // bounding box
    @Published var boundingBoxVolume = 0.0
    @Published var boundingBoxSA = 0.0
    @Published var boundingBoxVolText = ""
    @Published var boundingBoxSAText = ""
    // changed in contentView
    @Published var enableButton = true
    
    
    /// initWithRadius
    /// initializes the sphere object with a given radius, as well as calculates its area
    ///  - Parameter radius: Double precision value of the radius, defaults to 1
    func initWithRadius(radius: Double) async -> Bool {
        
        self.radius = radius
            let _ = await withTaskGroup(of:  Void.self) { taskGroup in
                taskGroup.addTask { let _ = await self.calculateVolume(radius:radius)}
                taskGroup.addTask { let _ = await self.calculateSurfaceArea(radius: radius)}
                taskGroup.addTask { let _ = await self.calculateBoundingBoxVol(radius: radius)}
                taskGroup.addTask { let _ = await self.calculateBoundingBoxSA(radius: radius)}
        }
            await setButtonEnable(state: true)
        return true
    }
    
    /// calculateVolume
    /// Calculates the sphere's volume using the analytic formula
    ///  - Parameter radius: Double precision value of the radius, defaults to 1
    func calculateVolume(radius: Double) async -> Double {
        
        // V = (4/3) * pi * r^3
        
        let calculatedVolume = (4.0/3.0) * Double.pi * pow(radius,3)
        let newVolumeText = String(format: "%7.5f", calculatedVolume)
        
        await updateVolume(volumeTextString: newVolumeText)
        await newVolumeValue(volume: calculatedVolume)
        
        return calculatedVolume
    }
    
    /// calculateSurfaceArea
    /// Calculates the sphere's surface area using the analytic formula
    ///  - Parameter radius: Double precision value of the radius, defaults to 1
    func calculateSurfaceArea(radius: Double) async -> Double {
        
        // SA = 4 * Pi * r^2
        
        let calculatedSurfaceArea = 4 * Double.pi * pow(radius,2)
        let newSurfaceAreaText = String(format: "%7.5f", calculatedSurfaceArea)
        
        await updateSurfaceArea(surfaceAreaTextString: newSurfaceAreaText)
        await newSurfaceAreaValue(surfaceArea: calculatedSurfaceArea)
        
        return calculatedSurfaceArea
        
    }
    
    /// calculateBoundingBoxVolume
    /// Calculates the volume of the sphere's bounding box using the analytic formula
    ///  - Parameter radius: Double precision value of the radius, defaults to 1
    func calculateBoundingBoxVol(radius: Double) async -> Double {
        
        // V_BB = (2 * r) ^ 3
        
        let calculatedVol = pow(2.0 * radius, 3)
        let newVolText = String(format: "%7.5f", calculatedVol)
        
        await updateBoundingBoxVol(boundBoxTextString: newVolText)
        await newBoundingBoxVolValue(volume: calculatedVol)
        
        return calculatedVol
        
    }
    
    /// calculateBoundingBoxSA
    /// Calculates the surface area of the sphere's bounding box using the analytic formula
    ///  - Parameter radius: Double precision value of the radius, defaults to 1
    func calculateBoundingBoxSA(radius: Double) async -> Double {
        
        // SA_BB = 6 * (2 * r) ^ 2
        
        let calculatedSurfaceArea = 6 * pow(2 * radius, 2)
        let newSurfaceAreaText = String(format: "%7.5f", calculatedSurfaceArea)
        
        await updateBoundingBoxSA(boundBoxTextString: newSurfaceAreaText)
        await newBoundingBoxSAValue(surfaceArea: calculatedSurfaceArea)
        
        return calculatedSurfaceArea
        
    }
    
    /// setButtonEnable
    /// Toggle the state of the Button on the Main Thread
    /// - Parameter state: Boolean describing whether the button should be pushable.
    @MainActor func setButtonEnable(state: Bool){
        if state {
            Task.init {
                await MainActor.run {
                    self.enableButton = true
                }
            }
        } else {
            Task.init {
                await MainActor.run {
                    self.enableButton = false
                }
            }
        }
    }
    
    /// newVolumeValue
    /// Setter function for the volume field of the sphere class
    /// - Parameter volume: New volume value to update class
    @MainActor func newVolumeValue(volume: Double){
        self.volume = volume
    }
    
    /// newSurfaceAreaValue
    /// Setter function for the surface area field of the sphere class
    /// - Parameter surfaceArea: New surface area value to update class
    @MainActor func newSurfaceAreaValue(surfaceArea: Double){
        self.surfaceArea = surfaceArea
    }
    
    /// updateVolume
    /// Update the volumeText variable
    /// - Parameter volumeTextString: String converted from a Double which contains the volume
    @MainActor func updateVolume(volumeTextString: String){
        volumeText = volumeTextString
    }
    
    /// updateSurfaceArea
    /// Update the surfaceAreaText variable
    /// - Parameter surfaceAreaTextString: String converted from a Double which contains the calculated surface area
    @MainActor func updateSurfaceArea(surfaceAreaTextString:String){
        surfaceAreaText = surfaceAreaTextString
    }
    
    /// newBoundingBoxVol
    /// Update the boundingBoxVol variable
    /// - Parameter volume: String converted from a Double which contains the volume of the bounding box
    @MainActor func newBoundingBoxVolValue(volume: Double) {
        self.boundingBoxVolume = volume
    }
    
    /// updateBoundingBoxVol
    /// Update the boundingBoxVolText variable
    /// - Parameter boundBoxTextString: String converted from a Double which contains the calculated volume of the bounding box
    @MainActor func updateBoundingBoxVol(boundBoxTextString: String){
        boundingBoxVolText = boundBoxTextString
    }
    
    /// newBoundingBoxSAValue
    /// Setter function for the boundingBoxSA field of the sphere class
    /// - Parameter surfaceArea: New SA value to update class
    @MainActor func newBoundingBoxSAValue(surfaceArea: Double) {
        self.boundingBoxSA = surfaceArea
    }
    
    /// updateBoundingBoxSurfaceArea
    /// Update the boundingBoxSAText variable
    /// - Parameter surfaceAreaTextString: String converted from a Double which contains the calculated surface area of the bounding box
    @MainActor func updateBoundingBoxSA(boundBoxTextString: String){
        boundingBoxSAText = boundBoxTextString
    }
}
