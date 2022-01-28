//
//  Cube.swift
//  HW 1
//
//  Created by Michael Cardiff on 1/27/22.
//

import SwiftUI

class Cube: Shape {
    
    // necessary variables for calculating and displaying everything on screen
    var sideLength = 1.0
    var center = (x:0.0, y:0.0, z:0.0)
    
    /// initWithRadius
    /// initializes the sphere object with a given radius, as well as calculates its area
    ///  - Parameter radius: Double precision value of the radius, defaults to 1
    func initWithSideLength(sideLength: Double) async -> Bool {
        
        self.sideLength = sideLength
            let _ = await withTaskGroup(of: Void.self) { taskGroup in
                taskGroup.addTask { let _ = await self.calculateVolume(param: sideLength)}
                taskGroup.addTask { let _ = await self.calculateSurfaceArea(param: sideLength)}
        }
            await setButtonEnable(state: true)
        return true
    }
    
    /// calculateVolume
    /// Calculates the sphere's volume using the analytic formula
    ///  - Parameter sideLength: Double precision value of the side length, defaults to 1
    override func calculateVolume(param: Double) async -> Double {
        
        // V = l^3
        let sideLength = param
        
        let calculatedVolume = pow(radius,3)
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
}

