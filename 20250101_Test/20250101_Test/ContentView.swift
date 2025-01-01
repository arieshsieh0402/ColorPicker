//
//  ContentView.swift
//  20250101_Test
//
//  Created by Aries Hsieh on 2025/1/1.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedColor: Color = .black
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.1).ignoresSafeArea()
            
            CardView {
                VStack(spacing: 20) {
                    Text("Color Picker")
                        .font(.headline)
                        .padding(.top, 8)
                    
                    ColorPreviewBox(color: selectedColor)
                    
                    ColorPickerView(selectedColor: $selectedColor)
                }
            }
            .padding()
        }
    }
}

struct CardView<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        VStack {
            content
                .padding()
        }
        .background(Color.white)
        .cornerRadius(16)
        .shadow(
            color: .black.opacity(0.1),
            radius: 8,
            x: 0,
            y: 2
        )
        .padding()
    }
}

struct ColorPreviewBox: View {
    let color: Color
    
    var body: some View {
        Rectangle()
            .fill(color)
            .frame(width: 200, height: 200)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .shadow(
                color: .black.opacity(0.2),
                radius: 5,
                x: 0,
                y: 2
            )
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.gray.opacity(0.2), lineWidth: 1)
            )
            .padding()
    }
}

struct ColorPickerView: View {
    private let colors: [Color] = [
        .black,
        .purple,
        .orange,
        .teal,
        .blue,
        .brown
    ]
    
    @Binding var selectedColor: Color
    private let buttonSize: CGFloat = 24
    private let spacing: CGFloat = 8
    
    var body: some View {
        HStack(spacing: spacing) {
            ForEach(colors.indices, id: \.self) { index in
                ColorButton(
                    color: colors[index],
                    isSelected: colors[index] == selectedColor,
                    action: { selectedColor = colors[index] }
                )
            }
        }
    }
}

struct ColorButton: View {
    let color: Color
    let isSelected: Bool
    let action: () -> Void
    
    private let size: CGFloat = 24
    private let borderWidth: CGFloat = 2
    
    var body: some View {
        Button(action: action) {
            Circle()
                .fill(color)
                .frame(width: size, height: size)
                .overlay(
                    Circle()
                        .strokeBorder(Color.white, lineWidth: isSelected ? borderWidth : 0)
                )
                .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 2)
        }
    }
}

#Preview {
    ContentView()
}
