import SwiftUI
import Firebase

struct LoginView: View {
    @ObservedObject var viewModel: CarListViewModel
    
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isLoading: Bool = false
    @State private var keyboardHeight: CGFloat = 0
    @State private var errorMessage: String = ""
    
    var body: some View {
        ScrollViewReader { scrollViewProxy in
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
                    
                    Text("Login to cruise through")
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
                        .contentShape(Rectangle()) // Making the entire area tappable
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.blue, lineWidth: 1)
                                .background(Color.white)
                        )
                        .padding(.horizontal, 25)
                        .textContentType(.password)
                        .autocapitalization(.none)
                        .contentShape(Rectangle()) // Making the entire area tappable
                }
                
                if !errorMessage.isEmpty {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding(.horizontal, 25)
                }
                
                if isLoading {
                    ProgressView() // Display a spinner while loading
                } else {
                    Button(action: {
                        isLoading = true // Start loading
                        errorMessage = "" // Clear previous error
                        
                        Auth.auth().signIn(withEmail: username, password: password) { authResult, error in
                            isLoading = false // Stop loading
                            
                            if let error = error {
                                errorMessage = "An error occurred: \(error.localizedDescription)"
                                return
                            }
                            
                            // Update the isLoggedIn state
                            withAnimation(.easeInOut) {
                                viewModel.isLoggedIn = true
                            }
                            
                            // Fetch and observe user's cars
                                viewModel.fetchUserCars()
                        }
                    }) {
                        Text("Login")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                    }
                    .padding(.horizontal, 25)
                }
                
                NavigationLink(destination: RegistrationView()) {
                    Text("Register")
                        .underline()  // Optional: to make it look more like a link
                        .foregroundColor(.blue)
                }
                .padding(.horizontal, 25)
            }
            .padding(.all, 40)
            .padding(.bottom, keyboardHeight)
            .onAppear {
                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { (notification) in
                    let value = notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
                    let height = value.height
                    self.keyboardHeight = height
                }
                
                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { (notification) in
                    self.keyboardHeight = 0
                }
            }
            .navigationBarHidden(true)
            .onChange(of: keyboardHeight) { _ in
                // When the keyboard height changes, scroll to the top of the view
                scrollViewProxy.scrollTo(0)
            }
        }
    }
}
