//
//  Home.swift
//  Login-Firebase-SwiftUI
//
//  Created by Prashuk Ajmera on 10/25/20.
//

import SwiftUI
import Firebase

struct Home: View {
    @State var show = false
    @State var status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
    
    var body: some View {
        NavigationView {
            VStack {
                if self.status {
                    HomeScreen()
                } else {
                    ZStack {
                        NavigationLink(
                            destination: SignUp(show: self.$show),
                            isActive: self.$show) {
                            
                        }
                        .hidden()
                        
                        Login(show: self.$show)
                    }
                }
            }
            
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .onAppear {
                NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "status"), object: nil, queue: .main) { (_) in
                    self.status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
                }
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
