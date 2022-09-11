# Sierpinski Triangle in SwiftUI

Renders The Sierpinski Triangle fractal in SwiftUI for iOS

The code that sets up the triangle:
```swift
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
```

The code that adds each point on a redraw:

```swift
/**
 The continuation of the algorithm from `init`
 3. Repeat until satisfied:
    1. Pick a random point from the three initial points
    2. Draw a point midway between that point and the previously drawn point
 */
func render() {
    let picked = self.initialTriangle.randomElement()
    let newPoint = FractalRenderer.getHalfwayPoint(between: picked!, and: last)
        
    self.points.append(newPoint)
    self.last = newPoint
}

Other functions and code found inside the renderer class, or the UI rendering in FractalView.swift

