//
//  ContentView.swift
//  AirPods Pro
//
//  Created by McCoy Zhu on 10/29/19.
//  Copyright © 2019 McCoy Zhu. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack{
            HStack{
                Text("AirPods Pro")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                Spacer()
                Text("$249.00")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(Color(red: 87/255, green: 6/255, blue: 140/255))
            }
            .padding(.vertical)
            Text("""
AirPods Pro are sweat and water resistant for non-water sports and exercise. AirPods Pro were tested under controlled laboratory conditions, and have a rating of IPX4 under IEC standard 60529. Sweat and water resistance are not permanent conditions and resistance might decrease as a result of normal wear. Do not attempt to charge wet AirPods Pro; refer to https://support.apple.com/kb/HT210711 for cleaning and drying instructions. The charging case is not sweat or water resistant.
""")
                .font(.body)
                .fontWeight(.heavy)
            
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
