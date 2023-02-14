//
//  GradientBackgroundAnimation.swift
//  SwiftUIAnimations
//
//  Created by Kavinkumar on 14/02/23.
//  
    

import SwiftUI

struct GradientBackgroundAnimation: View {
    
    @State private var animateGradient: Bool = false
    
    private let startColor: Color = .blue
    private let endColor: Color = .green
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "swift")
                .font(.system(size: 72, weight: .light))
                .padding(.top, 80)
                .padding(.bottom, 64)
            
            Text("Gradient background animation in SwiftUI")
                .font(.title)
                .bold()
            
            Text("It is a visual effect where the colors of a gradient background transition over time.")
                .fontWeight(.thin)
            
            Spacer()
            
            Button {
                
            } label: {
                Image(systemName: "arrow.right")
            }
            .frame(width: 50, height: 50)
            .background(Color.white)
            .cornerRadius(25)
            .padding(10)
            .overlay {
                Circle()
                    .stroke(style: StrokeStyle(lineWidth: 1))
                    .foregroundColor(.white)
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .foregroundColor(.black)
        .padding(.horizontal)
        .multilineTextAlignment(.center)
        .background {
            LinearGradient(colors: [startColor, endColor], startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
                .hueRotation(.degrees(animateGradient ? 45 : 0))
                .onAppear {
                    withAnimation(.easeInOut(duration: 3).repeatForever(autoreverses: true)) {
                        animateGradient.toggle()
                    }
                }
        }
    }
}

struct GradientBackgroundAnimation_Previews: PreviewProvider {
    static var previews: some View {
        GradientBackgroundAnimation()
    }
}
