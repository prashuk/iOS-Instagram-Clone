//
//  SignUp.swift
//  Login-Firebase-SwiftUI
//
//  Created by Prashuk Ajmera on 10/25/20.
//

import SwiftUI
import Firebase

struct SignUp : View {

    @State var color = Color.black.opacity(0.7)
    @State var email = ""
    @State var password = ""
    @State var repassword = ""
    @State var visible = false
    @State var revisible = false
    @State var alert = false
    @State var error = ""

    @Binding var show : Bool

    var body: some View {
        ZStack {
            ZStack(alignment: .topLeading) {
                GeometryReader {_ in
                    VStack {
                        Image("logo")
                            .resizable()
                            .frame(width: 150, height: 150, alignment: .center)


                        Text("Registration")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .fontWeight(.bold)
                            .foregroundColor(self.color)
                            .padding(.top, 35)

                        TextField("Email", text: self.$email)
                            .autocapitalization(.none)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 4).stroke(self.email != "" ? Color("Color") : self.color, lineWidth: 2))
                            .padding(.top, 25)

                        HStack(spacing: 15) {
                            VStack {
                                if self.visible {
                                    TextField("Password", text: self.$password)
                                        .autocapitalization(.none)
                                } else {
                                    SecureField("Password", text: self.$password)
                                        .autocapitalization(.none)
                                }
                            }

                            Button(action: {
                                self.visible.toggle()
                            }) {
                                Image(systemName: self.visible ? "eye.slash.fill" : "eye.fill")
                                    .foregroundColor(self.color)
                            }
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 4).stroke(self.password != "" ? Color("Color") : self.color, lineWidth: 2))
                        .padding(.top, 25)

                        HStack(spacing: 15) {
                            VStack {
                                if self.revisible {
                                    TextField("Re-Password", text: self.$repassword)
                                } else {
                                    SecureField("Re-Password", text: self.$repassword)
                                }
                            }

                            Button(action: {
                                self.revisible.toggle()
                            }) {
                                Image(systemName: self.revisible ? "eye.slash.fill" : "eye.fill")
                                    .foregroundColor(self.color)
                            }
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 4).stroke(self.repassword != "" ? Color("Color") : self.color, lineWidth: 2))
                        .padding(.top, 25)

                        Button(action: {
                            self.registry()
                        }) {
                            Text("Sign Up")
                                .foregroundColor(.white)
                                .padding(.vertical)
                                .frame(width: UIScreen.main.bounds.width - 50)
                        }
                        .background(Color("Color"))
                        .cornerRadius(10)
                        .padding(.top, 25)
                    }
                    .padding(.horizontal, 25)
                    .frame(
                            minWidth: 0,
                            maxWidth: .infinity,
                            minHeight: 0,
                            maxHeight: .infinity,
                            alignment: .center
                        )
                }

                Button(action: {
                    self.show.toggle()
                }) {
                    Image(systemName: "chevron.left")
                        .font(.title)
                        .foregroundColor(Color("Color"))
                }
                .padding()
            }
            
            if self.alert {
                ErrorView(alert: self.$alert, error: self.$error)
            }
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
    
    func registry() {
        if self.email != "" {
            if self.password == self.repassword {
                Auth.auth().createUser(withEmail: self.email, password: self.password) { (res, err) in

                    if err != nil {
                        self.error = err!.localizedDescription
                        self.alert.toggle()
                        return
                    }

                    UserDefaults.standard.set(true, forKey: "status")
                    NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
                }
            } else {
                self.error = "Password mismatch"
                self.alert.toggle()
            }
        } else {
            self.error = "Please fill all the contents properly"
            self.alert.toggle()
        }
    }
}
