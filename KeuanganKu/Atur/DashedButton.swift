//
//  DashedButton.swift
//  KeuanganKu
//
//  Created by Nabil Alviro on 09/02/26.
//

import SwiftUI

struct DashedButton: View {
    
    let title: String
    
    var body: some View {
        Button {
            
        } label: {
            HStack {
                Image(systemName: "plus")
                Text(title)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(style: StrokeStyle(lineWidth: 1, dash: [6]))
                    .foregroundStyle(Color.teal.opacity(0.6))
            )
        }
    }
}
struct GradientDashedButton: View {
    
    let title: String
    var action: () -> Void
    
    @State private var isPressed = false
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 6) {
                Image(systemName: "plus")
                Text(title)
            }
            .font(.system(size: 14, weight: .medium))
            .foregroundColor(isPressed ? .white : .black)
            .frame(maxWidth: .infinity)
            .frame(height: 44)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(
                        isPressed
                        ? AnyShapeStyle(LinearGradient.appPrimary)
                        : AnyShapeStyle(Color.gray.opacity(0.08))
                    )
            )
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(
                        isPressed
                        ? AnyShapeStyle(Color.clear)
                        : AnyShapeStyle(Color.gray.opacity(0.3)),
                        style: StrokeStyle(lineWidth: 1, dash: [6])
                    )
            )
            .animation(.easeInOut(duration: 0.15), value: isPressed)
        }
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in isPressed = true }
                .onEnded { _ in isPressed = false }
        )
    }
    
}
        struct GradientOutlineButton: View {
            
            let title: String
            let icon: String
            var isDestructive: Bool = false
            var action: () -> Void
            
            @State private var isPressed = false
            
            var body: some View {
                Button(action: action) {
                    Label(title, systemImage: icon)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(isPressed ? .white : (isDestructive ? .red : .black))
                        .frame(maxWidth: .infinity)
                        .frame(height: 44)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(
                                    isPressed
                                    ? AnyShapeStyle(
                                        isDestructive
                                        ? AnyShapeStyle(Color.red.opacity(0.6))
                                        : AnyShapeStyle(LinearGradient.appPrimary),
                                    )
                                    : AnyShapeStyle(Color.gray.opacity(0.08))
                                )
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(
                                    isPressed
                                    ? AnyShapeStyle(Color.clear)
                                    : AnyShapeStyle(
                                        isDestructive
                                        ? Color.red.opacity(0.5)
                                        : Color.gray.opacity(0.3)
                                    ),
                                    lineWidth: 1
                                )
                        )
                        .animation(.easeInOut(duration: 0.15), value: isPressed)
                }
                .simultaneousGesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { _ in isPressed = true }
                        .onEnded { _ in isPressed = false }
                )
            }
        }
        

