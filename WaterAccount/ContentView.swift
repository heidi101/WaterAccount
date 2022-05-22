//
//  ContentView.swift
//  WaterAccount
//
//  Created by HL on 5/21/22.
//

import SwiftUI
import Firebase
import GoogleSignIn
//struct HStack<Content> where Content : View

struct CustomButton : View {
    @State private var buttonColor : Color = .blue
    var body: some View{
        Button(action: {
            switch self.buttonColor {
            case .yellow:
                self.buttonColor = .blue
            case .blue:
                self.buttonColor = .yellow
            default:
                self.buttonColor = .blue
            }
        }) {
            Text(" ")
                .padding(7.0)
                .border(buttonColor)
        }
    }
}

struct ButtonRow : View{
    var num : Int
    var body: some View{
        HStack(){
            CustomButton()
            CustomButton()
            CustomButton()
            CustomButton()
            CustomButton()
            CustomButton()
            CustomButton()
            CustomButton()
            CustomButton()
            HStack(){
                CustomButton()
                Text(String(num))
            }
        }
    }
}

class userAuth: ObservableObject {
    @Published var isLoggedIn: Bool = false
    func login() {
        self.isLoggedIn = true
    }
}

//credits to https://www.youtube.com/watch?v=Ohr5oZW03Ok
/*struct loginView: View {
    @State var username = ""
    @State var password = ""
    var body: some View {
        VStack {
            Text("Sign In")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
            VStack(alignment: .leading, spacing: 8, content: {
                Text("Username")
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                TextField("Enter username here", text: $username)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(Color("dark"))
                    .padding(.top, 10)
                Divider()
                
                Text("Password")
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                TextField("0000", text: $password)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(Color("dark"))
                    .padding(.top, 10)
                Divider()
            })
            .padding(.top, 25)
        }
        .padding()
    }
}*/

struct userAccView: View {
    let waterAccount1 = WaterAccount(username: "HL", pin: 4321, gallonsUsed: 1, gallonsLeft: 1)
    @State private var buttonColor : Color = .blue
    var body: some View {
        Text("username: " + waterAccount1.username)
            .padding()
        VStack(){
            ButtonRow(num: 10)
            ButtonRow(num: 20)
            ButtonRow(num: 30)
            ButtonRow(num: 40)
            ButtonRow(num: 50)
            ButtonRow(num: 60)
            ButtonRow(num: 70)
            ButtonRow(num: 80)
            ButtonRow(num: 90)
            ButtonRow(num: 100)
        }
    }
}

struct ContentView: View {
    @AppStorage("log_Status") var log_Status = false
    var body: some View {
        if log_Status{
            NavigationView{
                VStack(spacing:15){
                    userAccView()
                    Text("Logged in!")
                    
                    Button("Logout"){
                        GIDSignIn.sharedInstance.signOut()
                        try? Auth.auth().signOut()
                        
                        withAnimation{
                            log_Status = false
                        }
                    }
                }
            }
        } else {
            loginPage()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
