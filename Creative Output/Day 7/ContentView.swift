//
//  ContentView.swift
//  AirPods Pro
//
//  Created by McCoy Zhu on 10/29/19.
//  Modified by McCoy Zhu on 11/3/19.
//  Copyright © 2019 McCoy Zhu. All rights reserved.
//

import SwiftUI

struct ContentView: View {
   @State var image1Pressed = false
   @State var image2Pressed = false
   @State var price = 249
   @State var rating = 48 as Float
   @State var showPar = true
   @State var selectedIndex = 2
   let fontWeightDescription = ["Heavy","Semibold","Regular", "Thin"]
   let fontWeight = [Font.Weight.heavy, Font.Weight.semibold, Font.Weight.regular, Font.Weight.thin]
   
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
           .padding(.horizontal, CGFloat(40))
           .contextMenu {
               Button(action: {
                   UIPasteboard.general.image = UIImage(named: "AirPods_Pro_Case")
               }) {
                   Text("Copy")
                   Image(systemName: "doc.on.doc")
               }
               
               Button(action: {
                   UIImageWriteToSavedPhotosAlbum(UIImage(named: "AirPods_Pro_Case")!, self, nil, nil)
               }) {
                   Text("Add to Photos")
                   Image(systemName: "square.and.arrow.down")
               }
           }
           
           HStack{
               Text("AirPods Pro")
                   .font(.largeTitle)
                   .foregroundColor(.gray)
               Spacer()
               Text("$\(price).00")
                   .font(.title)
                   .foregroundColor(Color(red: 87/255, green: 6/255, blue: 140/255))
           }
           .padding(.horizontal)
           .padding(.top)
           
           Stepper(value: $price, in: 199...299) {
               Text("Change Price")
                   .font(.headline)
           }
           .padding(.horizontal)
           .padding(.bottom)
           
           Toggle(isOn: $showPar.animation()) {
               Text("Show Paragraph")
                   .font(.headline)
           }
           .padding(.horizontal)
           .padding(.bottom)
           
           Picker(selection: $selectedIndex, label:
           Text("Font Weight")) {
               ForEach(0 ..< fontWeightDescription.count) { index in
                   Text(self.fontWeightDescription[index]).tag(index)
               }
           }
           .pickerStyle(SegmentedPickerStyle())
           .padding(.horizontal)
           .padding(.bottom)
           
           Slider(value: $rating, in: 11...68, step: 1)
               .accentColor(.orange)
               .padding(.horizontal)
               .padding(.bottom, CGFloat(rating))
           
           ScrollView{
               if showPar{
                   Text("AirPods Pro are sweat and water resistant for non-water sports and exercise. AirPods Pro were tested under controlled laboratory conditions, and have a rating of IP\(Int(rating)) under IEC standard 60529. Sweat and water resistance are not permanent conditions and resistance might decrease as a result of normal wear. Do not attempt to charge wet AirPods Pro; refer to https://support.apple.com/kb/HT210711 for cleaning and drying instructions. The charging case is not sweat or water resistant.")
                       .font(.system(size: CGFloat(price-198)))
                       .fontWeight(fontWeight[selectedIndex])
                       .fixedSize(horizontal: false, vertical: true)
                       .padding(.horizontal)
                       .padding(.bottom)
               }
               
               Image("Noise_Cancellation")//the image on the top
                   .resizable()
                   .scaledToFit()
                   .cornerRadius(self.image2Pressed ? 0 : 10)//rounding corners first
                   .blur(radius: self.image2Pressed ? 0 : 4)//applying blur next
                   .brightness(0.1)
                   .onTapGesture {
                       self.image2Pressed.toggle()
               }
               .animation(.default)
               .padding(self.image2Pressed ? .vertical : .horizontal)
               
               Image("Noise_Cancellation")//the image on the bottom
                   .resizable()
                   .scaledToFit()
                   .blur(radius: self.image2Pressed ? 10 : 4)//applying blur first
                   .cornerRadius(CGFloat(rating))//rounding corners next
                   .brightness(0.1)
                   .animation(.default)
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
