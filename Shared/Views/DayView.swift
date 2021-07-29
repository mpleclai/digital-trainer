//
//  DayView.swift
//  digital-trainer
//
//  Created by Madeline LeClair on 7/21/21.
//

import SwiftUI

struct DayView: View {
    let displayDate: Date // Date for which to display info
    var workoutData: [Workout] //Full list of workouts
    
    var body: some View {
        VStack{
            //Create workoutList of workouts for given date
            let workoutList : [Workout] = workoutListFromDate(workoutData: workoutData, date: displayDate)
            
            if (workoutList.count > 0){
                //Chart
                ChartView(
                   values: getMinuteList(workoutData: workoutList),
                   names: getNameList(workoutData: workoutList),
                   formatter: {value in String(format: "%.f minutes", value)},
                    textColor: Color.primary,
                    colors: [Color.red, Color.purple, Color.orange, Color.blue, Color.green, Color.pink],
                   backgroundColor: Color.background,
                   innerRadiusFraction: 0.75
               )
                .padding()

            } else {
                ChartView(
                    values: [],
                    names: ["No Workouts"],
                    formatter: {value in String(format: "%.f minutes", value)},
                    textColor: Color.primary,
                    colors: [Color.gray],
                    backgroundColor: Color.background,
                    innerRadiusFraction: 0.75
                )
                .padding()
            }
           
            
            NavigationLink(destination: AddWorkoutView(date: displayDate)){
                //open form to enter name, calories, time
                Text ("Add workout")
                    .foregroundColor(.blue)
            }
            Spacer()
        }
        // Convert string in is08601 format to date & make readable
        .navigationTitle(displayDate.toReadableString())
    }
}

/*
 Given a list of Workouts and a date, produce a list workouts that occured on that Day
 Used to determine data to display for a specific day view
 */
func workoutListFromDate(workoutData: [Workout], date: Date) -> [Workout]{
    var workoutListByDate : [Workout] = []
    for workout in workoutData {
        // Modify date string to only consider MM/DD/YYYY
        if workout.timestamp.toISO8601Date().toReadableString() == date.toReadableString(){
            workoutListByDate.append(workout)
        }
    }
    return workoutListByDate
}

/*
 Given a list of Workouts, produce a list of minute Double values
 (To be passed into ChartView View)
 */
func getMinuteList(workoutData: [Workout]) -> [Double]{
    var minuteList : [Double] = []
    
    for workout in workoutData {
        minuteList.append(Double(workout.minutes))
    }
    
    return minuteList
}

/*
 Given a list of Workouts, produce a list of name String values
 (To be passed into ChartView View)
 */
func getNameList(workoutData: [Workout]) -> [String]{
    var nameList : [String] = []
    
    for workout in workoutData {
        nameList.append(workout.name)
    }
    
    return nameList
}

struct DayView_Previews: PreviewProvider {
    static var previews: some View {
        // Create Date Formatter
        let currentDate = "2021-06-23T13:49:51Z"
        DayView(displayDate: currentDate.toISO8601Date(), workoutData: workoutData)
        
        let secondDate = "2021-08-26T04:17:47Z"
        DayView(displayDate: secondDate.toISO8601Date(), workoutData: workoutData)
            .preferredColorScheme(.dark)
    }
}
