//
//  ContentView.swift
//  Courses
//
//  Created by McCoy Zhu on 11/4/19.
//  Modified by McCoy Zhu on 11/10/19.
//  Copyright © 2019 McCoy Zhu. All rights reserved.
//

import SwiftUI
import UIKit

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
        return Course(glyph: self.glyph.isEmpty ? "calendar.badge.plus" : self.glyph.lowercased().replacingOccurrences(of: " ", with: ""), name: self.name, code: self.code, day: self.day, time: self.time, location: self.location.isEmpty ? "Location TBA" : self.location, bgColor: self.bgColor, message: removeMessage ? "" : self.message)
    }
}

let myCourses = [
    Course(glyph: "arkit", name: "3D Modeling", code: "DM-UY 2133 Section A", day: "Monday & Wednesday", time: "8:30AM – 10:20AM", location: "370 Jay Street, Room 311", bgColor: Color.red),
    Course(glyph: "square.and.pencil", name: "Writing Workshop II", code: "EXPOS-UA 9 Section TBA", day: "Monday & Wednesday", time: "4:30PM - 5:45PM", bgColor: Color.orange),
    Course(glyph: "hifispeaker.fill", name: "Audio Foundation", code: "DM-UY 1113 Section C", day: "Tuesday & Thursday", time: "10:30AM - 12:20PM", location: "370 Jay Street, Room 312", bgColor: Color.yellow),
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
        .cornerRadius(13)
        .animation(nil)
    }
}

struct EditingView: View {
    @Binding var course: Course
    @State var shouldAlert = false
    @State var shouldWarn = false
    @State var selectedIndex = 0
    let colorDescriptions = ["NYU Violet", "Red", "Orange", "Yellow", "Green", "Blue", "Purple", "Pink", "Gray", "Black"]
    let colors = [Color("NYU Violet"), Color.red, Color.orange, Color.yellow, Color.green, Color.blue, Color.purple, Color.pink, Color.gray, Color.black]
    var onDismiss: () -> ()
    
    var body: some View {
        NavigationView {
            List {
                HStack {
                    Text("Glpyh")
                    TextField("calendar.badge.plus", text: $course.glyph, onEditingChanged: { if $0{
                        self.course = self.course.copy(removeMessage: false)
                        }
                    }, onCommit: {
                        self.course = self.course.copy(removeMessage: false)
                    })
                        .multilineTextAlignment(.trailing)
                }
                
                Section {
                    HStack {
                        Text("Name")
                        TextField("Ideation & Prototyping", text: $course.name, onEditingChanged: { if $0{
                            self.course = self.course.copy(removeMessage: false)
                            }
                        }, onCommit: {
                            self.course = self.course.copy(removeMessage: false)
                        })
                            .multilineTextAlignment(.trailing)
                    }
                    HStack {
                        Text("Code")
                        TextField("DM-UY 1143 Section C", text: $course.code, onEditingChanged: { if $0{
                            self.course = self.course.copy(removeMessage: false)
                            }
                        }, onCommit: {
                            self.course = self.course.copy(removeMessage: false)
                        })
                            .multilineTextAlignment(.trailing)
                    }
                    HStack {
                        Text("Day")
                        TextField("Monday & Wednesday", text: $course.day, onEditingChanged: { if $0{
                            self.course = self.course.copy(removeMessage: false)
                            }
                        }, onCommit: {
                            self.course = self.course.copy(removeMessage: false)
                        })
                            .multilineTextAlignment(.trailing)
                    }
                    HStack {
                        Text("Time")
                        TextField("8:30AM – 10:20AM", text: $course.time, onEditingChanged: { if $0{
                            self.course = self.course.copy(removeMessage: false)
                            }
                        }, onCommit: {
                            self.course = self.course.copy(removeMessage: false)
                        })
                            .multilineTextAlignment(.trailing)
                    }
                    HStack {
                        Text("Location")
                        TextField("370 Jay Street, Room 413", text: $course.location, onEditingChanged: { if $0{
                            self.course = self.course.copy(removeMessage: false)
                            }
                        }, onCommit: {
                            self.course = self.course.copy(removeMessage: false)
                        })
                            .multilineTextAlignment(.trailing)
                    }
                }
                
                Section {
                    HStack {
                        Text("Color")
                        Spacer()
                        Text(self.colorDescriptions[selectedIndex])
                            .fontWeight(.semibold)
                            .foregroundColor(self.colors[selectedIndex])
                    }
                    HStack {
                        Spacer()
                        Picker(selection: $selectedIndex, label: Text("Color")) {
                            ForEach(0 ..< colors.count) { index in
                                Text(self.colorDescriptions[index]).tag(index)
                            }
                        }
                        .labelsHidden()
                        .pickerStyle(WheelPickerStyle())
                        Spacer()
                    }
                }
                
                if self.course.message != "New Course" {
                    Section {
                        EmptyView()
                    }
                    
                    Button(action: {
                        self.shouldWarn = true
                    }) {
                        Text("Delete")
                            .foregroundColor(.red)
                    }
                    .alert(isPresented: self.$shouldWarn, content: {
                        Alert(title: Text("Delete “\(self.course.name.isEmpty ? (self.course.message == "New Course" ? "New Course" : "Untitled Course") : self.course.name)”?"), message: Text("This course will be permanently deleted from your schedule."), primaryButton: .cancel(), secondaryButton: .destructive(Text("Delete"), action: {
                            self.course.message = "**deleted**"
                            self.onDismiss()
                        }))
                    })
                }
            }
            .onAppear(perform: {
                self.selectedIndex = self.colors.firstIndex(where: {
                    $0 == self.course.bgColor
                }) ?? 0
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
    @State var shouldWarn = false
    @State var currentIndex = 0
    @State var animationLength = 0.15
    @State var tempCourse = Course(name: "", code: "", day: "", time: "")
    
    var body: some View {
        VStack {
            Image(systemName: "plus")
                .padding(8)
                .foregroundColor(.blue)
                .opacity(self.adding ? 0.5 : 1)
                .onTapGesture {
                    self.animationLength = 0.6
                    self.tempCourse = Course(name: "", code: "", day: "", time: "", message: "New Course")
                    self.adding = true
            }
            .contextMenu {
                Button(action: {
                    self.animationLength = 0.4
                    self.mySchedule.courses.insert(Course(glyph: "scissors", name: "Ideation & Prototyping", code: "DM-UY 1143 Section C", day: "Monday & Wednesday", time: "8:30AM – 10:20AM", location: "370 Jay Street, Room 413"), at: 0)
                }) {
                    Text("Add New Dummy")
                    Image(systemName: "plus.square.on.square")
                }
            }
            .animation(.default)
            .sheet(isPresented: self.$adding) {
                EditingView(course: self.$tempCourse, onDismiss: {
                    if self.tempCourse.message != "**canceled**" && self.tempCourse.message != "**deleted**" {
                        self.mySchedule.courses.insert(self.tempCourse.copy(removeMessage: true), at: 0)
                    }
                    self.adding = false
                })
            }
            
            ZStack {
                Color(UIColor.secondarySystemBackground)
                    .edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    VStack {
                        ForEach(mySchedule.courses) { course in
                            CourseView(course: course)
                                .contextMenu {
                                    Button(action: {
                                        self.animationLength = 0.6
                                        self.currentIndex = self.mySchedule.courses.firstIndex(where: {
                                            $0.id == course.id
                                        })!
                                        self.tempCourse = self.mySchedule.courses[self.currentIndex].copy(removeMessage: true)
                                        self.editing = true
                                    }) {
                                        Text("Edit")
                                        Image(systemName: "pencil")
                                    }
                                    
                                    Button(action: {
                                        self.currentIndex = self.mySchedule.courses.firstIndex(where: {
                                            $0.id == course.id
                                        })!
                                        self.tempCourse = self.mySchedule.courses[self.currentIndex].copy(removeMessage: true)
                                        self.shouldWarn = true
                                    }) {
                                        Text("Delete")
                                        Image(systemName: "trash")
                                    }
                                    .alert(isPresented: self.$shouldWarn, content: {
                                        Alert(title: Text("Delete “\(self.tempCourse.name)”?"), message: Text("This course will be permanently deleted from your schedule."), primaryButton: .cancel(), secondaryButton: .destructive(Text("Delete"), action: {
                                            self.animationLength = 0.05
                                            self.mySchedule.courses.remove(at: self.currentIndex)
                                        }))
                                    })
                            }
                            .padding(.horizontal)
                            .onTapGesture {
                                self.animationLength = 0.6
                                self.currentIndex = self.mySchedule.courses.firstIndex(where: {
                                    $0.id == course.id
                                })!
                                self.tempCourse = self.mySchedule.courses[self.currentIndex].copy(removeMessage: true)
                                self.editing.toggle()
                            }
                            .sheet(isPresented: self.$editing) {
                                EditingView(course: self.$tempCourse, onDismiss: {
                                    if self.tempCourse.message == "**deleted**" {
                                        self.mySchedule.courses.remove(at: self.currentIndex)
                                        self.animationLength = 0.53
                                    } else if self.tempCourse.message != "**canceled**" {
                                        self.animationLength = 0.53
                                        self.mySchedule.courses[self.currentIndex] = self.tempCourse.copy(removeMessage: true)
                                    }
                                    self.editing = false
                                })
                            }
                        }
                    }
                    .padding(.vertical, 15)
                }
                .animation(Animation.spring(response: 0.55, dampingFraction: 0.825, blendDuration: 0.8).delay(animationLength * 1.65))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
