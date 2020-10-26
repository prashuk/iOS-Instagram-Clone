//
//  HomeScreen.swift
//  Login-Firebase-SwiftUI
//
//  Created by Prashuk Ajmera on 10/25/20.
//

import SwiftUI
import Firebase

struct HomeScreen: View {
    var body: some View {
        VStack {
            Text("Logged in")
                .font(.title)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .foregroundColor(Color.black.opacity(0.7))
            
            Button(action: {
                try! Auth.auth().signOut()
                UserDefaults.standard.set(false, forKey: "status")
                NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
            }, label: {
                Text("Log out")
                    .foregroundColor(.white)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 50)
            })
            .background(Color("Color"))
            .cornerRadius(10)
            .padding(.top, 25)
        }
        
    }
}
