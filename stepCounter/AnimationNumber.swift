//
//  AnimationNumber.swift
//  stepCounter
//
//  Created by Dowon Kim on 03/08/2023.
//

import SwiftUI

struct AnimationNumber: View {
    
    @State private var number: Double = 0.0
    
    var body: some View {
        ZStack{
            Circle()
                .stroke(style: .init(lineWidth: 8, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color(.systemGray4))
                .frame(width: 300, height: 300)
            Circle()
                .trim(from: 0, to: number/10000)
                .stroke(style: .init(lineWidth: 8, lineCap: .round, lineJoin: .round))
                .foregroundColor(.accentColor)
                .frame(width: 300, height: 300)
                .rotationEffect(.degrees(-90))
                .shadow(radius: 5)
            
            VStack{
                Image(systemName: "shoeprints.fill")
                    .font(.largeTitle)
                    .font(.system(size: 64, weight: .bold, design: .rounded))
                Color.clear
                    .font(.largeTitle)
                    .frame(width: 128, height: 128)
                    .animationOverly(for: Int(number))
                Text("Today")
                    .foregroundColor(.secondary)
                
                Text("Goal 10 000")
                    .foregroundColor(.secondary)
            }
        }
        .onAppear{
            withAnimation(.default){
                number = .random(in: 0.0 ..< 10000.0)
            }
        }
    }
}

struct AnimatableNumber: AnimatableModifier {
    
    var animatableData: Int
    
    init(animatableData: Int) {
        self.animatableData = animatableData
    }
    
    func body(content: Content) -> some View {
        content
            .overlay(
                Text("\(animatableData)")
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                    .font(.largeTitle)
            )
    }
    
}

struct AnimationNumber_Previews: PreviewProvider {
    static var previews: some View {
        AnimationNumber()
    }
}

extension Double: VectorArithmetic {
    // protocol stubs 1/2
    public mutating func scaling(by rh: Double) {
        self = Double(Int(Double(self) * rh))
    }
    
    // protocol stubs 2/2
    public var Square: Double {
        Double(self * self)
    }
}

extension View {
    func animation(for number: Int) -> some View {
        modifier(AnimatableNumber(animatableData: number))
    }
}
