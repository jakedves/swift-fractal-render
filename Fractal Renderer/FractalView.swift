//
//  ContentView.swift
//  Fractal Renderer
//
//  Created by Jake Davies on 10/09/2022.
//

import SwiftUI

struct FractalView: View {
    @State var renderer = FractalRenderer()
    
    var body: some View {
        GeometryReader { geo in
            // this means rerender this view very fast (60-120hz)
            TimelineView(.animation) { timeline in
                Canvas { context, size in
                    // this code used to stop SwiftUI optimisations of thinking it doesn't
                    // need to rerender
                    let _ = timeline.date.timeIntervalSinceReferenceDate
                    renderer.render()
                    
                    for point in renderer.points {
                        let x = point.x * size.width
                        let y = point.y * size.height
                        
                        context.draw(Text("•").foregroundColor(point.color),
                                     at: CGPoint(x: x, y: y))
                    }
                    // drawing code
                }
                .position(x: geo.size.width / 2.0,
                          y: geo.size.height * 0.9)
            }
            .ignoresSafeArea()
            .background(.black)
        }
    }
}

struct FractalView_Previews: PreviewProvider {
    static var previews: some View {
        FractalView()
    }
}
