//
//  ContentView.swift
//  Shared
//
//  Created by Madeline LeClair on 7/20/21.
//

import SwiftUI

struct ContentView: View {
    @State private var date = Date()
    
    
    var body: some View {
        
        NavigationView{
            VStack{
                DatePicker(
                    "Start Date",
                    selection: $date,
                    displayedComponents: [.date]
                )
                .datePickerStyle(GraphicalDatePickerStyle())
                
                NavigationLink(destination: DayView(displayDate: date, workoutData: workoutData)){
                    VStack{
                        Text(date.toReadableString())
                            .font(.title)
                        Text("Click For Workout Breakdown")
                    }
                    .padding()
                    .border(Color.blue)
                    .cornerRadius(15.0)

                    
                }
                Spacer()
            }.navigationTitle("Digital Trainer")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
