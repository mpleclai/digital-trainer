//
//  DayView.swift
//  digital-trainer
//
//  Created by Madeline LeClair on 7/21/21.
//

import SwiftUI

struct DayView: View {
    let date: Date // Date for which to display info
    var workoutData: [Workout] //Full list of workouts

    var body: some View {
        VStack{
            //Create workoutList of workouts for given date
            let workoutList : [Workout] = workoutListFromDate(workoutData: workoutData, date: date)
            
            // Convert string in is08601 format to date & make readable
            Text(workoutList[0].timestamp.toISO8601Date().toReadableString())
                .font(.title)
                .bold()
            
            ChartView(
               values: getMinuteList(workoutData: workoutList),
               names: getNameList(workoutData: workoutList),
               formatter: {value in String(format: "%.f minutes", value)},
               textColor: Color.black,
                colors: [Color.red, Color.purple, Color.orange, Color.blue, Color.green, Color.pink],
               backgroundColor: Color.white,
               innerRadiusFraction: 0.75
           )
           .padding()

            Button("Add workout") {
                print("eeeeee")
                //open form to enter name, calories, time
                //add button to submitt form
                //    on button click
                //    workoutList.addWorkout(name, calories, time, date)
            }
            Spacer()
        }
    }
}

/*
 Given a list of Workouts and a date, produce a list workouts that occured on that Day
 Used to determine data to display for a specific day view
 */
func workoutListFromDate(workoutData: [Workout], date: Date) -> [Workout]{
    var workoutListByDate : [Workout] = []
    for workout in workoutData {
        /*TODO - Modify to only consider MM/DD/YYYY */
        if workout.timestamp == date.toISO8601String(){
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
        DayView(date: currentDate.toISO8601Date(), workoutData: workoutData)
        
        let secondDate = "2021-07-26T04:17:47Z"
        DayView(date: secondDate.toISO8601Date(), workoutData: workoutData)
    }
}
