import SwiftUI
import Firebase

struct ForgotPasswordView: View {
    @State private var email: String = ""
    @State private var message: String = ""
    @State private var showAlert: Bool = false
    @State private var isShowingLogin = false
    
    var body: some View {
        VStack(spacing: 40) {
            
            Image(systemName: "car.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 120)
                .foregroundColor(.blue)
            
            VStack(spacing: 10) {
                Text("CarPedia")
                    .font(.largeTitle)
                    .bold()
                
                Text("Forgot your password?")
                    .font(.headline)
                    .fontWeight(.medium)
            }
            
            VStack(spacing: 15) {
                TextField("Email", text: $email)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.blue, lineWidth: 1)
                            .background(Color.white)
                    )
                    .padding(.horizontal, 25)
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                    .contentShape(Rectangle())
                
                Button("Send Reset Email") {
                    Auth.auth().sendPasswordReset(withEmail: self.email) { error in
                        if let error = error {
                            self.message = "An error occurred: \(error.localizedDescription)"
                        } else {
                            self.message = "A password reset email has been sent to \(self.email)"
                        }
                        self.showAlert = true
                    }
                }
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .cornerRadius(10)
                .padding(.horizontal, 25)
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Password Reset"), message: Text(self.message), dismissButton: .default(Text("OK")))
                }
            }
            .padding(.bottom, 20)  // Controlled padding to reduce space
            
            NavigationLink(
                destination: LoginView(viewModel: CarListViewModel()),
                isActive: $isShowingLogin
            ) {
                Text("Remember your password? Login")
                    .underline()
                    .foregroundColor(.blue)
            }
            .padding(.bottom, 20)  // You can adjust this padding to suit your layout
            
        }
        .padding(.all, 40)
        .navigationBarHidden(true)
    }
}
