//
//  AddWorkoutView.swift
//  digital-trainer
//
//  Created by Madeline LeClair on 7/28/21.
//

import SwiftUI

struct AddWorkoutView: View {
    var date =  Date()
    @State private var name: String = ""
    @State private var calories: String = ""
    @State private var time: String = ""

    var body: some View {
        VStack{
            Text(date.toReadableString())
                .font(.title)
                .bold()
                .padding()
            
            VStack(alignment: .leading){
                Text("Enter workout name:")
                    .padding(.leading)
            
                // Enter Workout Name
                TextField("Name", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding([.leading, .bottom, .trailing])
                
                Text("Enter workout calories spent:")
                    .padding(.leading)
                // Enter Workout Calories
                TextField("Calories", text: $calories)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                    .padding()

                Text("Enter workout time in minutes:")
                    .padding(.leading)
                // Enter Workout Minutes
                TextField("Minutes", text: $time)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                    .padding()
            }
            Button("Submit Form"){
                //  on button click
                //  workoutList.addWorkout(name, calories, time, date)
            }
        }
        .navigationTitle("Add New Workout")
    }
}

struct AddWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        AddWorkoutView()
    }
}
