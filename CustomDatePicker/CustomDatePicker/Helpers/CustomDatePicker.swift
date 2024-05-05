//
//  CustomDatePicker.swift
//  CustomDatePicker
//
//  Created by Nap Works on 04/05/24.
//

import SwiftUI

enum MyDatePickerStyle{
    case wheel
    case compact
    case graphical
    
    var style: Any {
        switch self {
        case .wheel:
            return WheelPickerStyle()
        case .compact:
            return CompactDatePickerStyle()
        case .graphical:
            return GraphicalDatePickerStyle()
        }
    }
}

struct CustomDatePicker: View {
    var style: MyDatePickerStyle = .wheel
    @Binding var date: Date
    var onDismiss: ()->()
    
  
    var body: some View {
        VStack {
            Spacer(minLength: 0)
            VStack(spacing: 0) {
                Button(action: onDismiss, label: {
                    Text("Done")
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.vertical, 15)
                        .padding(.horizontal, 20)
                        .background(.white)
                })
                .buttonStyle(StaticButtonStyle())
                HStack {
                    Group {
                        if style == .wheel {
                            DatePicker("", selection: $date, displayedComponents: .date)
                                .datePickerStyle(.wheel)
                        }else if style == .compact {
                            DatePicker("", selection: $date, displayedComponents: .date)
                                .datePickerStyle(.compact)
                        }else {
                            DatePicker("", selection: $date, displayedComponents: .date)
                                .datePickerStyle(.graphical)
                        }
                    }
                    .labelsHidden()
                    
                   
                }
            }
            .padding(.bottom, 12)
            .background(.red)
            .clipShape(.rect(topLeadingRadius: 12, topTrailingRadius: 12))
            .shadow(color: .black.opacity(0.2), radius: 6, x: 0, y: -2)
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .ignoresSafeArea()
    }

}

#Preview {
    CustomDatePicker(style: .wheel, date: .constant(.now)) {
        
    }
}

fileprivate struct StaticButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
    }
}
