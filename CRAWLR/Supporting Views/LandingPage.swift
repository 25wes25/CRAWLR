//
//  Background.swift
//  CRAWLR
//
//  Created by Rachel Bright on 2/6/20.
//  Copyright © 2020 Wesley Swanson. All rights reserved.
//

import SwiftUI

struct LandingPage: View {
    var body: some View {
        NavigationView{
            ZStack{
                Background()
                NavigationLink(destination: Dashboard()){
                    Text("LOGIN")
                        .frame(width: 131 , height: 39)
                        .foregroundColor(Color.black)
                        .background(Color(red: 0 / 255, green: 196 / 255, blue: 255 / 255))
                        .cornerRadius(15)
                        .font(.custom("Futura Medium", size: 15))
                }
                .offset(y: 200)
                
                NavigationLink(destination: ForgotPassword()){
                    Text("Forgot Password?")
                        .frame(width: 128 , height: 39)
                        .foregroundColor(Color(red: 232 / 255, green: 0 / 255, blue: 252 / 255))
                        .cornerRadius(15)
                        .font(.custom("Futura Medium", size: 12))
                }
                .buttonStyle(PlainButtonStyle())
                .offset(y: 275)
                
                NavigationLink(destination: NewAccount()){
                    Text("No Account? Sign Up?")
                        .frame(width: 180 , height: 19)
                        .foregroundColor(Color(red: 232 / 255, green: 0 / 255, blue: 252 / 255))
                        .cornerRadius(15)
                        .font(.custom("Futura Medium", size: 12))
                }
                .buttonStyle(PlainButtonStyle())
                .offset(y: 300)
                
            }
        }
    }
    
}

struct LandingPage_Previews: PreviewProvider {
    static var previews: some View {
        LandingPage()
    }
}
