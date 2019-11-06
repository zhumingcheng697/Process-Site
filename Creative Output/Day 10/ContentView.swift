//
//  ContentView.swift
//  Courses
//
//  Created by McCoy Zhu on 11/4/19.
//  Modified by McCoy Zhu on 11/6/19.
//  Copyright © 2019 McCoy Zhu. All rights reserved.
//

import SwiftUI

class Course: Identifiable {
    var glyph: String
    var name: String
    var code: String
    var date: String
    var time: String
    var location: String
    var bgColor: Color
    
    init(glyph: String = "calendar.badge.plus", name: String, code: String, date: String, time: String, location: String = "Location TBA", bgColor: Color = Color("NYU Violet")) {
        self.glyph = glyph
        self.name = name
        self.code = code
        self.date = date
        self.time = time
        self.location = location
        self.bgColor = bgColor
    }
}

var myCourses = [
    Course(glyph: "arkit", name: "3D Modeling", code: "DM-UY 2133 Section A", date: "Monday & Wednesday", time: "8:30AM – 10:20AM", location: "370 Jay Street, Room 311", bgColor: Color.red),
    Course(glyph: "square.and.pencil", name: "Writing Workshop II", code: "EXPOS-UA 9", date: "Monday & Wednesday", time: "4:30PM - 5:45PM", bgColor: Color.orange),
    Course(glyph: "hifispeaker", name: "Audio Foundation", code: "DM-UY 1113 Section C", date: "Tuesday & Thursday", time: "10:30AM - 12:20PM", location: "370 Jay Street, Room 312", bgColor: Color.yellow),
    Course(glyph: "link", name: "Intro to Web Dev", code: "DM-UY 2193 Section C", date: "Tuesday & Thursday", time: "2:30PM - 4:20PM", location: "370 Jay Street, Room 308", bgColor: Color.green),
    Course(glyph: "camera", name: "Still & Moving Images", code: "DM-UY 2263 Section D", date: "Tuesday & Thursday", time: "4:30PM - 6:20PM", location: "370 Jay Street, Room 309", bgColor: Color.purple)
]

class Schedule: ObservableObject{
    @Published var courses: [Course]
    
    init(courses: [Course]){
        self.courses = courses
    }
    
}

struct CourseView: View {
    var course: Course
    var body: some View {
        HStack {
            Spacer()
            
            VStack {
                HStack {
                    Image(systemName: course.glyph)
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .padding(.trailing, 6)
                    
                    VStack(alignment: .leading) {
                        Text(course.name)
                            .foregroundColor(.white)
                            .font(.title)
                        
                        Text(course.code)
                            .foregroundColor(.white)
                            .font(.subheadline)
                    }
                }
                .padding(.bottom, 6)
                
                Text(course.date)
                    .foregroundColor(.white)
                
                Text(course.time)
                    .foregroundColor(.white)
                
                Text(course.location)
                    .foregroundColor(.white)
            }
            .padding(.vertical)
            
            Spacer()
        }
        .background(course.bgColor)
        .cornerRadius(20)
        .padding(.horizontal)
        .animation(nil)
    }
}

struct ContentView: View {
    @ObservedObject var mySchedule = Schedule(courses: myCourses)
    
    var body: some View {
        VStack {
            Button(action: {
                self.mySchedule.courses.insert(Course(name: "Test \(Int.random(in: 0...255))", code: "This is a Test", date: "This is a Test", time: "This is a Test", location: "This is a Test"), at: 0)
            }) {
                Image(systemName: "plus")
                    .padding(8)
            }
            
            ScrollView{
                VStack(spacing: 0){
                    ForEach(mySchedule.courses){ course in
                        CourseView(course: course)
                            .padding(.top, 12)
                    }
                }
            }
            .animation(.spring(response: 0.38, dampingFraction: 0.82, blendDuration: 0.8))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
