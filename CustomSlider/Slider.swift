//
//  Slider.swift
//  CustomSlider
//
//  Created by Olha Bereziuk on 18.02.25.
//

import SwiftUI

struct Slider: View {
    
    var activeTint: Color = .orange
    var inactiveTint: Color = .gray.opacity(0.25)
    var opacityEffect: Bool = false
    var clipEdges: Bool = false
    
    var body: some View {
        let hstackSpacing: CGFloat = 26
        let dotSize: CGFloat = 8
        let spacingAndDotSize = hstackSpacing + dotSize
        
        GeometryReader {
            let width = $0.size.width
            /// ScrollView boounds
            if let scrollViewWidth = $0.bounds(of: .scrollView(axis: .horizontal))?.width,
               scrollViewWidth > 0 {
                
                let minX = $0.frame(in: .scrollView(axis: .horizontal)).minX
                let totalPages = Int(width / scrollViewWidth)
                
                /// Progress
                let freeProgress = -minX / scrollViewWidth
                let clippedProgress = min(max(freeProgress, 0), CGFloat(totalPages - 1))
                let progress = clipEdges ? clippedProgress : freeProgress
                
                /// Indexes
                let activeIndex = Int(progress)
                let nextIndex = Int(progress.rounded(.awayFromZero))
                let indicatorProgress = progress - CGFloat(activeIndex)
                
                /// Indicator width (Current & upcoming)
                let currentPageWidth = spacingAndDotSize - (indicatorProgress * spacingAndDotSize)
                let nextPageWidth = indicatorProgress * spacingAndDotSize
                
                HStack(spacing: hstackSpacing) {
                    /// loop dots
                    ForEach(0..<totalPages, id: \.self) { index in
                        Capsule()
                            .fill(inactiveTint)
                            .frame(width: dotSize + ((activeIndex == index) ? currentPageWidth : (nextIndex == index) ? nextPageWidth : 0),
                                   height: dotSize)
                            .overlay {
                                ZStack {
                                    Capsule()
                                        .fill(inactiveTint)
                                    
                                    Capsule()
                                        .fill(activeTint)
                                        .opacity(opacityEffect ?
                                                 (activeIndex == index) ? 1 - indicatorProgress : (nextIndex == index) ? indicatorProgress : 0
                                                 : 1
                                        )
                                }
                            }
                    }
                }
                .frame(width: scrollViewWidth)
                .offset(x: -minX)
            }
        }
        .frame(height: 30)
    }
}

#Preview {
    HomeView()
}
