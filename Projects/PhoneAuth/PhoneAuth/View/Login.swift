//
//  Login.swift
//  PhoneAuth
//
//  Created by Nap Works on 11/02/24.
//

import SwiftUI

struct Login: View {
    @StateObject var otpModel: OTPViewModel = .init()
    var body: some View {
        VStack {
            HStack (spacing: 10){
                VStack(spacing: 8){
                    TextField("1", text: $otpModel.code)
                        .keyboardType(.numberPad)
                        .multilineTextAlignment(.center)
                    
                    Rectangle()
                        .fill(otpModel.code == "" ? .gray.opacity(0.35) : .blue)
                        .frame(height: 2)
                }
                .frame(width: 40)
                
                VStack(spacing: 8){
                    TextField("", text: $otpModel.number)
                        .keyboardType(.numberPad)
                    
                    Rectangle()
                        .fill(otpModel.number == "" ? .gray.opacity(0.35) : .blue)
                        .frame(height: 2)
                }
            }
            .padding(.vertical)
            
            Button(action: {
                Task {
                    await otpModel.sendOTP()
                }
            }, label: {
                Text("Login")
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
            .disabled(otpModel.code == "" || otpModel.number == "")
            .opacity(otpModel.code == "" || otpModel.number == "" ? 0.4 : 1)
        }
        .padding()
        .navigationTitle("Login")
        .frame(maxHeight: .infinity, alignment: .top)
        .background {
            NavigationLink(tag: "VERIFICATION", selection: $otpModel.navigationTag) {
                Vertification()
                    .environmentObject(otpModel)
            } label: { }
                .labelsHidden()
        }
        .alert(otpModel.errorMsg, isPresented: $otpModel.showAlert) {}
    }
}

#Preview {
    ContentView()
}
