//
//  ViewModifiers.swift
//  trip-companions
//
//  Created by 영현 on 8/5/24.
//

import SwiftUI

// MARK: - Text
struct Title2TextModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title2)
//            .fontWeight(.semibold)
            .padding(.bottom, 5)
    }
}

struct AdditionalTextModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.orangeF49321)
            .padding(.bottom, 5)
    }
}

struct AdditionalTextModifier2: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.grayA2A2A2)
            .padding(.bottom, 5)
    }
}

// MARK: - TextField
struct CustomTextFieldStyle: TextFieldStyle {
    var isEditing: Bool = false
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .font(.subheadline)
            .padding(16)
            .background(isEditing ? Color.white : Color.grayF5F6F8)
            .cornerRadius(6)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(isEditing ? Color.black : Color.clear, lineWidth: 1)
            )
    }
}

// MARK: - Button
struct WidthMaxSelectButtonStyle: ButtonStyle {
    var isSelected: Bool = false
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.subheadline)
            .padding(20)
            .frame(maxWidth: .infinity)
            .background(isSelected ? Color.orangeF49321.opacity(0.1) : Color.grayF5F6F8)
            .cornerRadius(6)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(isSelected ? Color.orangeF49321 : Color.clear, lineWidth: 1)
            )
            .foregroundColor(isSelected ? Color.orangeF49321 : Color.grayA2A2A2)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeInOut, value: configuration.isPressed)
    }
}

struct SelectButtonStyle: ButtonStyle {
    var isSelected: Bool = false
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.subheadline)
            .padding(14)
            .background(isSelected ? Color.orangeF49321.opacity(0.1) : Color.grayF5F6F8)
            .cornerRadius(6)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(isSelected ? Color.orangeF49321 : Color.clear, lineWidth: 1)
            )
            .foregroundColor(isSelected ? Color.orangeF49321 : Color.grayA2A2A2)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeInOut, value: configuration.isPressed)
    }
}


struct CompleButtonStyle: ButtonStyle {
    var isComplete: Bool = false
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(16)
            .fontWeight(.semibold)
            .frame(maxWidth: .infinity)
            .foregroundColor(.white)
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .fill(isComplete ? Color.orange : Color.grayE9E9E9)
            )
            .foregroundColor(isComplete ? Color.white : Color.grayA2A2A2)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeInOut, value: configuration.isPressed)
    }
}

struct KakaoButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.title3)
            .foregroundColor(.black)
            .padding()
            .padding(.horizontal)
            .background(configuration.isPressed ? Color.yellowFEE500.opacity(0.7) : Color.yellowFEE500)
            .cornerRadius(6) // 모서리 둥글게
            .frame(maxWidth: .infinity)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeInOut, value: configuration.isPressed)
    }
}

struct SearchButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(16)
            .font(.subheadline)
            .foregroundColor(Color.grayA2A2A2)
            .frame(maxWidth: .infinity)
            .background(Color.grayF5F6F8)
            .cornerRadius(6)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.clear, lineWidth: 1)
            )
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeInOut, value: configuration.isPressed)
    }
}

// MARK: - Picker
struct CustomPickerStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(8)
            .frame(maxWidth: .infinity)
            .background(Color.grayF5F6F8)
            .cornerRadius(6)
    }
}