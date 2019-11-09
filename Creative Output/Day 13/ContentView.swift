//
//  ContentView.swift
//  Courses
//
//  Created by McCoy Zhu on 11/4/19.
//  Modified by McCoy Zhu on 11/9/19.
//  Copyright © 2019 McCoy Zhu. All rights reserved.
//

import SwiftUI

class Course: Identifiable {
    var glyph: String
    var name: String
    var code: String
    var day: String
    var time: String
    var location: String
    var bgColor: Color
    var message: String
    
    init(glyph: String = "calendar.badge.plus", name: String, code: String, day: String, time: String, location: String = "Location TBA", bgColor: Color = Color("NYU Violet"), message: String = "") {
        self.glyph = glyph
        self.name = name
        self.code = code
        self.day = day
        self.time = time
        self.location = location
        self.bgColor = bgColor
        self.message = message
    }
    
    func copy(removeMessage: Bool) -> Course {
        return Course(glyph: self.glyph.isEmpty ? "calendar.badge.plus" : self.glyph.lowercased(), name: self.name, code: self.code, day: self.day, time: self.time, location: self.location.isEmpty ? "Location TBA" : self.location, bgColor: self.bgColor, message: removeMessage ? "" : self.message)
    }
}

var myCourses = [
    Course(glyph: "arkit", name: "3D Modeling", code: "DM-UY 2133 Section A", day: "Monday & Wednesday", time: "8:30AM – 10:20AM", location: "370 Jay Street, Room 311", bgColor: Color.red),
    Course(glyph: "square.and.pencil", name: "Writing Workshop II", code: "EXPOS-UA 9 Section TBA", day: "Monday & Wednesday", time: "4:30PM - 5:45PM", bgColor: Color.orange),
    Course(glyph: "hifispeaker", name: "Audio Foundation", code: "DM-UY 1113 Section C", day: "Tuesday & Thursday", time: "10:30AM - 12:20PM", location: "370 Jay Street, Room 312", bgColor: Color.yellow),
    Course(glyph: "link", name: "Intro to Web Dev", code: "DM-UY 2193 Section C", day: "Tuesday & Thursday", time: "2:30PM - 4:20PM", location: "370 Jay Street, Room 308", bgColor: Color.green),
    Course(glyph: "camera", name: "Still & Moving Images", code: "DM-UY 2263 Section D", day: "Tuesday & Thursday", time: "4:30PM - 6:20PM", location: "370 Jay Street, Room 309", bgColor: Color.purple)
]

class Schedule: ObservableObject {
    @Published var courses: [Course]
    
    init(courses: [Course]) {
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
                
                Text(course.day)
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

struct EditingView: View {
    @Binding var course: Course
    @State var shouldAlert = false
    @State var selectedIndex = -1
    var colorDescriptions = ["NYU Violet", "Red", "Orange", "Yellow", "Green", "Blue", "Purple", "Pink", "Gray", "Black"]
    var colors = [Color("NYU Violet"), Color.red, Color.orange, Color.yellow, Color.green, Color.blue, Color.purple, Color.pink, Color.gray, Color.black]
    var onDismiss: () -> ()
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    HStack {
                        Text("Glpyh")
                        TextField("calendar.badge.plus", text: $course.glyph)
                            .multilineTextAlignment(.trailing)
                    }
                }
                
                HStack {
                    Text("Name")
                    TextField("Ideation & Prototyping", text: $course.name)
                        .multilineTextAlignment(.trailing)
                }
                HStack {
                    Text("Code")
                    TextField("DM-UY 1143 Section C", text: $course.code)
                        .multilineTextAlignment(.trailing)
                }
                HStack {
                    Text("Day")
                    TextField("Monday & Wednesday", text: $course.day)
                        .multilineTextAlignment(.trailing)
                }
                HStack {
                    Text("Time")
                    TextField("8:30AM – 10:20AM", text: $course.time)
                        .multilineTextAlignment(.trailing)
                }
                HStack {
                    Text("Location")
                    TextField("370 Jay Street, Room 413", text: $course.location)
                        .multilineTextAlignment(.trailing)
                }
                
                Section {
                    HStack {
                        Text("Color")
                        Spacer()
                        Text(self.selectedIndex != -1 ? self.colorDescriptions[selectedIndex] : "NYU Violet")
                            .fontWeight(.semibold)
                            .foregroundColor(self.selectedIndex != -1 ? self.colors[selectedIndex] : Color("NYU Violet"))
                    }
                    
                    Picker(selection: $selectedIndex, label: Text("Color")) {
                        ForEach(0 ..< colors.count) { index in
                            Text(self.colorDescriptions[index]).tag(index)
                        }
                        
                    }
                    .labelsHidden()
                    .pickerStyle(WheelPickerStyle())
                }
            }
            .onAppear(perform: {
                if self.selectedIndex == -1 {
                    self.selectedIndex = self.colors.firstIndex(where: {
                        $0 == self.course.bgColor
                    }) ?? 0
                }
            })
                .listStyle(GroupedListStyle())
                .navigationBarTitle(Text(course.name.isEmpty ? (course.message == "New Course" ? "New Course" : "Untitled Course") : course.name))
                .navigationBarItems(leading:
                    Button(action: {
                        self.course.message = "**canceled**"
                        self.onDismiss()
                    }) {
                        Text("Cancel")
                    }, trailing:
                    Button(action: {
                        if self.course.name == "" || self.course.code == "" || self.course.day == "" || self.course.time == "" {
                            self.shouldAlert = true
                        } else {
                            self.course.bgColor = self.colors[self.selectedIndex]
                            self.course = self.course.copy(removeMessage: false)
                            self.onDismiss()
                        }
                    }) {
                        Text("Done")
                            .bold()
                    }
                    .alert(isPresented: self.$shouldAlert) {
                        Alert(title: Text("Oops…"), message: Text("Please fill in every blank."), dismissButton: .default(Text("OK")))
                })
        }
    }
}

struct ContentView: View {
    @ObservedObject var mySchedule = Schedule(courses: myCourses)
    @State var editing = false
    @State var adding = false
    @State var currentIndex = 0
    @State var fastAnimation = 1.0
    @State var tempCourse = Course(name: "", code: "", day: "", time: "", location: "")
    
    var body: some View {
        VStack {
            Button(action: {
                self.fastAnimation = 1.0
                self.tempCourse = Course(name: "", code: "", day: "", time: "", location: "", message: "New Course")
                self.adding = true
            }) {
                Image(systemName: "plus")
                    .padding(8)
            }
            .sheet(isPresented: self.$adding) {
                EditingView(course: self.$tempCourse, onDismiss: {
                    if self.tempCourse.message != "**canceled**" {
                        self.mySchedule.courses.insert(self.tempCourse.copy(removeMessage: true), at: 0)
                    }
                    self.adding = false
                })
            }
            
            ScrollView {
                VStack(spacing: 0) {
                    ForEach(self.mySchedule.courses) { course in
                        CourseView(course: course)
                            .onTapGesture {
                                self.fastAnimation = 1.0
                                self.currentIndex = self.mySchedule.courses.firstIndex(where: {
                                    $0.id == course.id
                                })!
                                self.tempCourse = self.mySchedule.courses[self.currentIndex].copy(removeMessage: true)
                                self.editing = true
                        }
                        .sheet(isPresented: self.$editing) {
                            EditingView(course: self.$tempCourse, onDismiss: {
                                if self.tempCourse.message != "**canceled**" {
                                    if self.mySchedule.courses[self.currentIndex].bgColor != self.tempCourse.bgColor {
                                        self.fastAnimation = 0.53
                                    }
                                    self.mySchedule.courses[self.currentIndex] = self.tempCourse.copy(removeMessage: true)
                                }
                                self.editing = false
                            })
                        }
                        .onLongPressGesture {
                            self.mySchedule.courses.remove(at: self.mySchedule.courses.firstIndex(where:{
                                $0.id == course.id
                            })!)
                        }
                        .padding(.top, 12)
                    }
                }
            }
            .animation(Animation.spring(response: 0.38, dampingFraction: 0.82, blendDuration: 0.8).delay(fastAnimation * 1.65))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
