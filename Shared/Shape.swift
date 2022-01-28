//
//  Shape.swift
//  HW 1
//
//  Meant to be a sort of abstract class that can be implemented by objects like Sphere or Cube
//
//  Created by Michael Cardiff on 1/27/22.
//

import SwiftUI

class Shape: NSObject, ObservableObject {
    
    @Published var volume = 0.0
    @Published var surfaceArea = 0.0
    @Published var volumeText = ""
    @Published var surfaceAreaText = ""
    
    // changed in contentView
    @Published var enableButton = true

    
    
    /// calculateVolume
    /// Calculates the shapes volume using the formula decided by the particular shape you are using
    /// - Parameter param: Characteristic length of the shape, should be optional, since in Shape class, nothing is calculated
    func calculateVolume(param: Double) async -> Double {
        print("You Did Something Wrong...")
        return 0.0
    }
    
    /// calculateSurfaceArea
    /// Calculates the shapes surface area using the formula decided by the particular shape you are using
    /// - Parameter param: Characteristic length of the shape, should be optional, since in Shape class, nothing is calculated
    func calculateSurfaceArea(param: Double) async -> Double {
        print("You Did Something Wrong...")
        return 0.0
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
}
