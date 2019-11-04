//
//  ContentView.swift
//  Courses
//
//  Created by McCoy Zhu on 11/4/19.
//  Copyright © 2019 McCoy Zhu. All rights reserved.
//

import SwiftUI

class Course{
    var glyph: String
    var name: String
    var code: String
    var date: String
    var time: String
    var location: String
    
    init(glyph: String = "calender", name: String, code: String, date: String, time: String, location: String = "Location TBA") {
        self.glyph = glyph
        self.name = name
        self.code = code
        self.date = date
        self.time = time
        self.location = location
    }
}

var courses = [
    Course(glyph: "arkit", name: "3D Modeling", code: "DM-UY 2133 Section A", date: "Monday & Wednesday", time: "8:30AM – 10:20AM", location: "370 Jay Street, Room 311"),
    Course(glyph: "square.and.pencil", name: "Int'l Writing Workshop II", code: "EXPOS-UA 9", date: "Monday & Wednesday", time: "4:30PM - 5:45PM"),
    Course(glyph: "hifispeaker", name: "Audio Foundation", code: "DM-UY 1113 Section C", date: "Tuesday & Thursday", time: "10:30AM - 12:20PM", location: "370 Jay Street, Room 312"),
    Course(glyph: "link", name: "Intro to Web Dev", code: "DM-UY 2193 Section C", date: "Tuesday & Thursday", time: "2:30PM - 4:20PM", location: "370 Jay Street, Room 308"),
    Course(glyph: "camera", name: "Still and Moving Images", code: "DM-UY 2263 Section D", date: "Tuesday & Thursday", time: "4:30PM - 6:20PM", location: "370 Jay Street, Room 309")
]

struct CourseView: View {
    var course: Course
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: course.glyph)
                    .font(.largeTitle)
                    .padding(.trailing, 6)
                
                VStack(alignment: .leading) {
                    Text(course.name)
                        .font(.title)
                    
                    Text(course.code)
                        .font(.subheadline)
                }
            }
            .padding(.vertical,10)
            
            Text(course.date)
            Text(course.time)
            Text(course.location)
        }
        .padding(.vertical)
    }
}

struct ContentView: View {
    var body: some View {
        ScrollView{
            ForEach(courses, id: \.name){ course in
                CourseView(course: course)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
