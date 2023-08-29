import SwiftUI
import Firebase

struct RegistrationView: View {
    
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
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
                
                Text("Register to join the journey")
                    .font(.headline)
                    .fontWeight(.medium)
            }
            
            VStack(spacing: 15) {
                TextField("Username", text: $username)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.blue, lineWidth: 1)
                            .background(Color.white)
                    )
                    .padding(.horizontal, 25)
                    .autocapitalization(.none)
                    .contentShape(Rectangle())
                
                SecureField("Password", text: $password)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.blue, lineWidth: 1)
                            .background(Color.white)
                    )
                    .padding(.horizontal, 25)
                    .textContentType(.newPassword)
                    .autocapitalization(.none)
                    .contentShape(Rectangle())
                
                SecureField("Confirm Password", text: $confirmPassword)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.blue, lineWidth: 1)
                            .background(Color.white)
                    )
                    .padding(.horizontal, 25)
                    .textContentType(.newPassword)
                    .autocapitalization(.none)
                    .contentShape(Rectangle())
            }
            
            Button("Register") {
                // Firebase Authentication and Firestore code to save the username
            }
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)  // <-- Added this line
            .background(Color.blue)
            .cornerRadius(10)
            .padding(.horizontal, 25)  // <-- Match the padding to align with input fields
            
            NavigationLink(
                destination: LoginView(viewModel: CarListViewModel()),
                isActive: $isShowingLogin
            ) {
                Text("Already registered, login")
                    .underline()
                    .foregroundColor(.blue)
            }
            .padding(.bottom, 20) // You can adjust this padding as well
            
        }
        .padding(.all, 40)
        .navigationBarHidden(true)
    }
}
