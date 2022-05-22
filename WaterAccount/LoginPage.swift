//
//  LoginPage.swift
//  HelloWorld
//
//  Created by HL on 5/21/22.
//

import SwiftUI
import Firebase
import GoogleSignIn
import AuthenticationServices

//credits to https://www.youtube.com/watch?v=0ncKXZVaXOU
struct loginPage: View {
    //loading indicator
    @State var isLoading: Bool = false
    @AppStorage("log_Status") var log_Status = false
    
    var body: some View {
        VStack(spacing: 20){
            Text("Create your water account today")
                .font(.largeTitle)
                .fontWeight(.light)
                .kerning(1.1)
                .foregroundColor(Color.black.opacity(0.8))
                .multilineTextAlignment(.center)
                .padding()
                .padding()
            
            Button {
                handleLogin()
            } label: {
                HStack(spacing:15){
                    Image("google")
                        .resizable()
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 28, height: 28)
                    
                    Text("Create account with Google")
                        .font(.title3)
                        .fontWeight(.light)
                        .kerning(1.1)
                }
                .foregroundColor(Color("Blue"))
                .padding()
                .frame(maxWidth: .infinity)
                
                .background(
                    Capsule()
                        .strokeBorder(Color("Blue"))
                )
            }
            .padding(.top,25)
            
            //terms text
            Text(getAttributedString(string: "By creating an account, you are agreeing to our Terms of Service"))
                .font(.body.bold())
                .foregroundColor(.gray)
                .kerning(1.1)
                .lineSpacing(8)
                .multilineTextAlignment(.center)
                .frame(maxHeight: .infinity, alignment: .bottom)
                .padding(.bottom,10)
            
        }
        //.padding()
        //.padding(.top, 40)
        .frame(maxWidth: .infinity, maxHeight:
                .infinity,alignment: .top)
        .overlay(
            ZStack{
                if isLoading{
                    Color.black
                        .opacity(0.25)
                        .ignoresSafeArea()
                    
                    ProgressView()
                        .font(.title2)
                        .frame(width: 60, height: 60)
                        .background(Color.white)
                        .cornerRadius(10)
                }
            }
        )
        
    }
               
    func getAttributedString(string: String)->AttributedString{
        var attributedString = AttributedString(string)
        if let range = attributedString.range(of: "Terms of Service"){
            attributedString[range].foregroundColor = .black
            attributedString[range].font = .body.bold()
        }
        return attributedString
    }
    
    func handleLogin(){
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        
        isLoading = true
        
        GIDSignIn.sharedInstance.signIn(with: config, presenting: getRootViewController())
            {[self] user, err in
            
            if let error = err {
                isLoading = false
                print(error.localizedDescription)
                return
              }

            guard
                let authentication = user?.authentication,
                let idToken = authentication.idToken
            else {
                isLoading = false
                return
            }

            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                             accessToken: authentication.accessToken)
            
            Auth.auth().signIn(with: credential) { result, err in
                isLoading = false
                if let error = err {
                    print(error.localizedDescription)
                    return
                }
                guard let user = result?.user else{
                    return
                }
                print(user.displayName ?? "Success!")
                
                //user is logged in
                withAnimation{
                    log_Status = true
                }
            }

    }
}
    
}


struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        loginPage()
    }
}

extension View{
    func getRect()->CGRect{
        return UIScreen.main.bounds
    }
    func getRootViewController()->UIViewController{
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else{
            return .init()
        }
        guard let root = screen.windows.first?.rootViewController else{
            return .init()
        }
        return root
    }
}


