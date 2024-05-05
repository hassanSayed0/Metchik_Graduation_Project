//
//  LoginButtonView.swift
//  Metchik
//
//  Created by Hassan on 02/05/2024.
//

import SwiftUI

struct LoginButtonView: View {
    @EnvironmentObject var viewModel: LoginViewModel
    @State private var showAlert = false
    @State private var alertMessage: String = "error"
    var body: some View {
        VStack(spacing: 10) {
            Button(action: {
                viewModel.loginButtonPressed {error in
                    self.alertMessage = error.description
                    self.showAlert = true
                }
            }, label: {
                Text("Login")
                    .font(.poppins(.bold, size: 16))
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(Asset.Colors.primaryButtonColor.swiftUIColor)
                    .background(Asset.Colors.secondaryButtonColor.swiftUIColor)
                    .cornerRadius(30)
                    
            })
            .disabled(viewModel.isLoggenActive)
            Text("or")
            VStack(spacing: 15) {
                Button(action: {
                    viewModel.loginWithFacebookButtonPressed {error in
                        self.alertMessage = error.description
                        self.showAlert = true
                    }
                }, label: {
                    Text("Continue with Facebook")
                        .font(.poppins(.semiBold, size: 16))
                        .frame(height: 50)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(Asset.Colors.primaryButtonColor.swiftUIColor)
                        .background(Asset.Colors.seconderyFacebookButtonColor.swiftUIColor)
                        .cornerRadius(30)
                })
                .disabled(viewModel.isLoggenActive)

                Button(action: {
                    viewModel.loginWithGoogleButtonPressed {error in
                        self.alertMessage = error.description
                        self.showAlert = true
                    }
                }, label: {
                    Text("Continue with Google")
                        .font(.poppins(.semiBold, size: 16))
                        .frame(height: 50)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(Asset.Colors.secondaryLabelColor.swiftUIColor)
                        .background(
                          RoundedRectangle(cornerRadius: 30)
                            .stroke(lineWidth: 1)
                            .foregroundStyle(Asset.Colors.borderButtonColor.swiftUIColor)
                        )
                })
                .disabled(viewModel.isLoggenActive)

                Button(action: {
                    viewModel.loginWithAppleButtonPressed {error in
                        self.alertMessage = error.description
                        self.showAlert = true
                    }
                }, label: {
                    Text("Continue with Apple")
                        .font(.poppins(.semiBold, size: 16))
                        .frame(height: 50)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(Asset.Colors.secondaryLabelColor.swiftUIColor)
                        .background(
                          RoundedRectangle(cornerRadius: 30)
                            .stroke(lineWidth: 1)
                            .foregroundStyle(Asset.Colors.borderButtonColor.swiftUIColor)
                        )
                })
                .disabled(viewModel.isLoggenActive)

            }
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Error"),
                message: Text(alertMessage),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}

struct LoginButtonView_Previews: PreviewProvider {
    
    static var previews: some View {
        LoginButtonView()
    }
}