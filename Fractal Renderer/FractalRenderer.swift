//
//  FractalRenderer.swift
//  Fractal Renderer
//
//  Created by Jake Davies on 10/09/2022.
//

import SwiftUI

/**
 This class holds all the data, and gets new points for the
 representation of this triangle
 */
class FractalRenderer: ObservableObject {
    private static let colors: [Color] = [.red, .green, .blue]
    private var initialTriangle: [ColouredPoint]
    private var last: ColouredPoint
    var points: [ColouredPoint]
    
    /**
     I've developed this alogrithm based on
     the TikTok from the user @MathLetters
     
     1. Create an equilateral Triangle (done on init)
     2. Add a random point inside that triangle
     
     The rest happens in `self.render()`
     */
    init() {
        let initials = [ColouredPoint(x: 1.0, y: 0.0, color: .blue),
                       ColouredPoint(x: 0.0, y: 0.0, color: .red),
                       ColouredPoint(x: 0.5, y: cos(60.0 / 180.0 * Double.pi), color: .green)]
        self.points = initials
        self.initialTriangle = initials
        
        // adds one further random point
        let newPoint = FractalRenderer.getRandomPoint()
        self.last = newPoint
        self.points.append(newPoint)
    }
    
    /**
     The continuation of the algorithm from `init`
     3. Repeat until satisfied:
        1. Pick a random point from the three initial points
        2. Draw a point midway between that point and the previously drawn point
     */
    func render() {
        for _ in 0...5 {
            let picked = self.initialTriangle.randomElement()
            let newPoint = FractalRenderer.getHalfwayPoint(between: picked!, and: last)
            
            self.points.append(newPoint)
            self.last = newPoint
        }
    }
    
    /**
     Generates a random CGPoint between zero and one
     */
    private static func getRandomPoint() -> ColouredPoint {
        let range = 0.0...1.0
        let x = Double.random(in: range)
        let y = Double.random(in: range)
        
        return ColouredPoint(x: x, y: y, color: colors.randomElement()!)
    }
    
    /**
     Calculates the halfway point between two points
     */
    private static func getHalfwayPoint(between first: ColouredPoint, and second: ColouredPoint) -> ColouredPoint {
        let x = (first.x + second.x) / 2.0
        let y = (first.y + second.y) / 2.0
        
        return ColouredPoint(x: x, y: y, color: colors.randomElement()!)
    }
}

/**
 A coloured CGPoint
 */
struct ColouredPoint {
    let x: CGFloat
    let y: CGFloat
    let color: Color
}
