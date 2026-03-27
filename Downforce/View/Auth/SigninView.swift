//
//  SigninView.swift
//  Downforce
//
//  Created by Ayush Bhople on 24/03/26.
//

import SwiftUI
import Foundation

struct SigninView: View {
    
    private let glowPosition = CGPoint(x: 275, y: 215)
    private let distortionPosition = CGPoint(x: 400, y: 400)
    private let distortionSize = CGSize(width: 730, height: 420)
        
    var body: some View {
        ZStack {
            Image("3")
                .resizable()
                .scaledToFill()
                .frame(
                    width: UIScreen.main.bounds.width,
                    height: UIScreen.main.bounds.height
                )
                .ignoresSafeArea()
            
            HeatDistortionView(imageName: "3")
                .frame(width: distortionSize.width, height: distortionSize.height)
                .position(distortionPosition)
            
            GlowView()
                .frame(width: 160, height: 160)
                .position(glowPosition)
        }
    }
    
}


struct GlowView: View {
    
    @State private var flicker = false
    
    var body: some View {
        ZStack {
            
            // Core Glow Gradient
            RadialGradient(
                gradient: Gradient(colors: [
                    Color.white.opacity(0.7),
                    Color.white.opacity(0.4),
                    Color.white.opacity(0.1),
                    Color.clear
                ]),
                center: .center,
                startRadius: 3,
                endRadius: 60
            )
            
            // Outer Soft Glow
//            Circle()
//                .fill(Color.white.opacity(0.15))
//                .blur(radius: 30)
//                .scaleEffect(1.2)
        }
        .blendMode(.screen) // critical for realistic light blending
        .opacity(flicker ? 0.75 : 0.5)
        .blur(radius: 8)
        .onAppear {
            withAnimation(
                .easeInOut(duration: 0.5)
                .repeatForever(autoreverses: true)
            ) {
                flicker.toggle()
            }
        }
    }
}


struct HeatDistortionView: View {
    let imageName: String
    @State private var start = Date.now
    
    var body: some View {
        GeometryReader { geo in
            TimelineView(.animation) { t1 in
                let elapsed = start.distance(to: t1.date)
                
//                Rectangle()
//                    .fill(.blue)
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(
                        width: UIScreen.main.bounds.width,
                        height: UIScreen.main.bounds.height
                    )
                    .offset(
                        x: -(geo.frame(in: .global).minX),
                        y: -(geo.frame(in: .global).minY)
                    )
                    .visualEffect { content, proxy in
                        content
                            .distortionEffect(
                                ShaderLibrary.heatDistortion(
                                    .float(elapsed),
                                    .float2(proxy.size)
                                ),
                                maxSampleOffset: CGSize(width: 20, height: 20)
                            )
                    }
                    .clipped()
            }
        }
    }
}



//struct SigninView: View {
//    @State var selected: Bool = false
//    @State var animate: Bool = false
//    
//    var body: some View {
////        LinearGradient(
////            colors: true
////                        ? [Color.blue, Color.purple]
////                        : [Color.orange, Color.red],
////                    startPoint: animate ? .topLeading : .bottomTrailing,
////                    endPoint: animate ? .bottomTrailing : .topLeading
////                )
////                .ignoresSafeArea()
////                .animation(.easeInOut(duration: 0.6), value: true)
////                .onAppear { animate = true }
////        Circle()
////            .fill(Color.black.opacity(0.5))
////            .frame(width: 200)
////            .offset(x: animate ? 100 : -100, y: animate ? -200 : 200)
////            .animation(.easeInOut(duration: 6).repeatForever(autoreverses: true), value: animate)
////            .onAppear {
////                animate = true
////            }
////        Image(systemName: "rb.circle.fill")
////            .font(.system(size: 150, design: .default))
////            .animation(Animation.smooth(duration: 1.0).delay(0.5)) {
////                $0.shadow(color: .blue, radius: selected ? 20 : 4)
////            }
////            .animation(.bouncy(duration: 0.5)) {
////                $0.scaleEffect(selected ? 2.0 : 1.0)
////            }
////            .onTapGesture {
////                selected.toggle()
////            }
//            
//    }
//}

#Preview {
    SigninView()
}
