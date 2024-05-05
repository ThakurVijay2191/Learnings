//
//  Vertification.swift
//  PhoneAuth
//
//  Created by Nap Works on 11/02/24.
//

import SwiftUI

struct Vertification: View {
    @EnvironmentObject var otpModel: OTPViewModel
    @FocusState var activeField: OTPField?
    var body: some View {
        VStack {
            OTPField()
            
            Button(action: {
                Task {
                    await otpModel.verifyOTP()
                }
            }, label: {
                Text("Verify")
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .padding(.vertical, 12)
                    .frame(maxWidth: .infinity)
                    .background(.blue, in: .rect(cornerRadius: 10, style: .continuous))
                    .opacity(otpModel.isLoading ? 0 : 1)
                    .overlay {
                        ProgressView()
                            .opacity(otpModel.isLoading ? 1 : 0)
                    }
            })
            .disabled(checkStatus())
            .opacity(checkStatus() ? 0.4 : 1)
            .padding(.vertical)
            
            HStack (spacing: 12){
                Text("Didn't get otp?")
                    .font(.caption)
                    .foregroundStyle(.gray)
                Button("Resent") {}
                    .font(.callout)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
        .frame(maxHeight: .infinity, alignment: .top)
        .navigationTitle("Verification")
        .onChange(of: otpModel.otpFields) { oldValue, newValue in
            OTPCondition(value: newValue)
        }
        .alert(otpModel.errorMsg, isPresented: $otpModel.showAlert) {}
    }
    
    func checkStatus()->Bool {
        for index in 0..<6 {
            if otpModel.otpFields[index].isEmpty{ return true}
        }
        
        return false
    }
    
    func OTPCondition(value: [String]){
        
        for index in 0..<6 {
            if value[index].count == 6 {
                DispatchQueue.main.async {
                    otpModel.otpText = value[index]
                    otpModel.otpFields[index] = ""
                    
                    for item in otpModel.otpText.enumerated() {
                        otpModel.otpFields[item.offset] = String(item.element)
                    }
                }
                return
            }
        }
        
        for index in 0..<5 {
            if value[index].count == 1 && activeStateForIndex(index: index) == activeField{
                activeField = activeStateForIndex(index: index + 1)
            }
        }
        
        for index in 1...5 {
            if value[index].isEmpty && !value[index - 1].isEmpty {
                activeField = activeStateForIndex(index: index - 1)
            }
        }
        
        
        for index in 0..<6 {
            if value[index].count > 1 {
                otpModel.otpFields[index] = String(value[index].last!)
            }
        }
    }
    
    //MARK: Custom OTP Textfield
    @ViewBuilder
    func OTPField()-> some View {
        HStack (spacing: 14){
            ForEach(0..<6, id: \.self) { index in
                VStack (spacing: 8){
                    TextField("", text: $otpModel.otpFields[index])
                        .keyboardType(.numberPad)
                        .textContentType(.oneTimeCode)
                        .multilineTextAlignment(.center)
                        .focused($activeField, equals: activeStateForIndex(index: index))
                    
                    Rectangle()
                        .fill((activeField == activeStateForIndex(index: index) || !otpModel.otpFields[index].isEmpty) ? .blue : .gray.opacity(0.3))
                        .frame(height: 4)
                }
                .frame(width: 40)
            }
        }
    }
    
    func activeStateForIndex(index: Int)-> OTPField{
        switch index {
        case 0:return .field1
        case 1:return .field2
        case 2:return .field3
        case 3:return .field4
        case 4:return .field5
        default:return .field6
        }
    }
}

#Preview {
    ContentView()
}

enum OTPField {
    case field1
    case field2
    case field3
    case field4
    case field5
    case field6
}
