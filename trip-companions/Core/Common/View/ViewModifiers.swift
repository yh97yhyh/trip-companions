//
//  ViewModifiers.swift
//  trip-companions
//
//  Created by 영현 on 8/5/24.
//

import SwiftUI

// MARK: - Text
struct Title3Modifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title3)
//            .fontWeight(.semibold)
            .padding(.bottom, 5)
    }
}

struct AdditionalTextModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.customOrange)
            .padding(.bottom, 5)
    }
}

struct AdditionalTextModifier2: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.customGray3)
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
            .background(isEditing ? Color.white : Color.customGray) // 배경 색상 변경
            .cornerRadius(6)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(isEditing ? Color.black : Color.clear, lineWidth: 1) // 테두리 색상 변경
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
            .background(isSelected ? Color.customOrange.opacity(0.1) : Color.customGray)
            .cornerRadius(6)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(isSelected ? Color.customOrange : Color.clear, lineWidth: 1)
            )
            .foregroundColor(isSelected ? Color.customOrange : Color.customGray3)
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
            .background(isSelected ? Color.customOrange.opacity(0.1) : Color.customGray)
            .cornerRadius(6)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(isSelected ? Color.customOrange : Color.clear, lineWidth: 1)
            )
            .foregroundColor(isSelected ? Color.customOrange : Color.customGray3)
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
                    .fill(isComplete ? Color.orange : Color.customGray2)
            )
            .foregroundColor(isComplete ? Color.white : Color.customGray3)
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
            .background(configuration.isPressed ? Color.yellow.opacity(0.7) : Color.kakaoYellow)
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
            .foregroundColor(Color.customGray3)
            .frame(maxWidth: .infinity)
            .background(Color.customGray)
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
            .background(Color.customGray)
            .cornerRadius(6)
    }
}