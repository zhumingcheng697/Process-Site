//
//  ContentView.swift
//  AirPods Pro
//
//  Created by McCoy Zhu on 10/29/19.
//  Modified by McCoy Zhu on 10/31/19.
//  Copyright © 2019 McCoy Zhu. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var image1Pressed = false
    @State var image2Pressed = false
    
    var body: some View {
        VStack{
            Image("AirPods_Pro_Case")
                .resizable()
                .scaledToFit()
                .shadow(color: .black, radius: 5, x: 0, y: 0)
                .onTapGesture {
                    self.image1Pressed.toggle()
            }
            .scaleEffect(self.image1Pressed ? 0.8 : 0.9)
            .rotation3DEffect(Angle(degrees: self.image1Pressed ? 10 : 0), axis: (x:1, y:0, z:0))
            .animation(.easeInOut)
            .padding(.horizontal, 40)
            HStack{
                Text("AirPods Pro")
                    .font(.largeTitle)
                    .foregroundColor(.gray)
                Spacer()
                Text("$249.00")
                    .font(.title)
                    .foregroundColor(Color(red: 87/255, green: 6/255, blue: 140/255))
            }
            .padding(.horizontal)
            .padding(.top)
            ScrollView{
                Text("AirPods Pro are sweat and water resistant for non-water sports and exercise. AirPods Pro were tested under controlled laboratory conditions, and have a rating of IPX4 under IEC standard 60529. Sweat and water resistance are not permanent conditions and resistance might decrease as a result of normal wear. Do not attempt to charge wet AirPods Pro; refer to https://support.apple.com/kb/HT210711 for cleaning and drying instructions. The charging case is not sweat or water resistant.")
                    .fontWeight(.heavy)
                    .lineLimit(Int.max)
                    .padding(.horizontal)
                    .padding(.bottom)
                Image("Noise_Cancellation")//the image on the top
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(self.image2Pressed ? 0 : 10)//rounding corners first
                    .blur(radius: self.image2Pressed ? 0 : 4)//applying blur next
                    .brightness(0.1)
                    .onTapGesture {
                        self.image2Pressed.toggle()
                }
                .animation(.easeInOut)
                .padding(self.image2Pressed ? .vertical : .horizontal)
                Image("Noise_Cancellation")//the image on the bottom
                    .resizable()
                    .scaledToFit()
                    .blur(radius: self.image2Pressed ? 10 : 4)//applying blur first
                    .cornerRadius(10)//rounding corners next
                    .brightness(0.1)
                    .animation(.easeInOut)
                    .padding(.horizontal)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
