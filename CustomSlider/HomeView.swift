//
//  HomeView.swift
//  CustomSlider
//
//  Created by Olha Bereziuk on 18.02.25.
//

import SwiftUI

struct HomeView: View {
    
    private var images = ["garage_1", "garage_2", "garage_3"]
    
    var body: some View {
        ZStack {
            self.backgroundColor
            self.makeSliderView()
        }
    }
    
    private var backgroundColor: some View {
        Rectangle()
            .fill(.black)
            .ignoresSafeArea()
    }
    
    private func makeImageViews() -> some View {
        ForEach(self.images, id: \.self) { image in
            ZStack {
                Image(image)
                    .resizable()
                    .scaledToFit()
                Rectangle()
                    .fill(.black.opacity(0.15))
            }
        }
    }
    
    @ViewBuilder
    private func makeSliderView() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 0) {
                self.makeImageViews()
                    .containerRelativeFrame(.horizontal)
            }
            .scrollTargetLayout()
            .overlay(alignment: .bottom) {
                Slider(
                    opacityEffect: true, ///in False state all dots are orange
                    clipEdges: true
                )
                .offset(y: -10)
            }
        }
        .scrollTargetBehavior(.viewAligned)
    }
}

#Preview {
    HomeView()
}
