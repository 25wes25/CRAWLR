//
//  Background.swift
//  CRAWLR
//
//  Created by Rachel Bright on 2/6/20.
//  Copyright © 2020 Wesley Swanson. All rights reserved.
//

import SwiftUI

struct Background: View {
    @State var username: String = ""
    @State var password: String = ""
    
    var body: some View {
        ZStack{
            
            Image("Brick")
            
            Image("Crawlr-clear")
                .offset(y: -250)
           
            Text("USERNAME")
                .foregroundColor(Color.white)
                .offset(y: -82.5)
                .font(.custom("Futura Medium", size: 18))
                
            
            TextField("", text: $username)
                .padding()
                .foregroundColor(Color.white)
                .frame(width: 300.0)
                .textFieldStyle(PlainTextFieldStyle())
                .offset(y: -40)
            
            Image("User")
                .offset(x: -160, y: -40)
            
            Divider()
                .background(Color(red: 0 / 255, green: 196 / 255, blue: 255 / 255))
                .frame(width: 268)
                .offset(y: -22)
            
            Text("PASSWORD")
                .foregroundColor(Color.white)
                .offset(y: 40)
                .font(.custom("Futura Medium", size: 18))
            
            Image("Unlocked")
                .offset(x: -160, y: 78)
            
            SecureField("", text: $password)
                .padding()
                .foregroundColor(Color.white)
                .frame(width: 300.0)
                .textFieldStyle(PlainTextFieldStyle())
                .offset(y: 76)
            
            Divider()
                .background(Color(red: 0 / 255, green: 196 / 255, blue: 255 / 255))
                .frame(width: 268)
                .offset(y: 94.5)
        
        }
        
    }
}

struct Background_Previews: PreviewProvider {
    static var previews: some View {
        Background()
    }
}
