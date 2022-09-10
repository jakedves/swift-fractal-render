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
                    let timelineDate = timeline.date.timeIntervalSinceReferenceDate
                    renderer.render(date: timelineDate)
                    
                    for point in renderer.points {
                        let x = Constants.margin * point.x * size.width
                        let y = Constants.margin * point.y * size.height
                        
                        context.draw(Text("•"), at: CGPoint(x: x, y: y))
                    }
                    // drawing code
                }
                .position(x: geo.size.width / 2.0,
                          y: geo.size.height * 0.9)
            }
            .ignoresSafeArea()
            //.background(.black)
        }
    }
    
    private struct Constants {
        static let margin: CGFloat = 0.95
    }
}

struct FractalView_Previews: PreviewProvider {
    static var previews: some View {
        FractalView()
    }
}