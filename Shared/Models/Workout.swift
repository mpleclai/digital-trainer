//
//  Workout.swift
//  digital-trainer
//
//  Created by Madeline LeClair on 7/20/21.
//

import Foundation

class Workout: Codable, Identifiable {
    var workoutId: Int
    /*TODO change type to UUID */
    var name : String
    var minutes : Int
    var calories : Int
    var timestamp: String
}

extension String{
    //example: "2021-06-23T13:49:51Z" to a Date type
    func toISO8601Date() -> Date{
        let dateFormatter = ISO8601DateFormatter()
        let date: Date? = dateFormatter.date(from: self)
        return date ?? Date()
    }
}

extension Date{
    //example: Given date formats to "2021-06-23T13:49:51Z"
    func toISO8601String() -> String{
        let dateFormatter = ISO8601DateFormatter()
        let dateString: String? = dateFormatter.string(from: self)
        return dateString ?? "default"
    }
    
    //example: Given date formats to June 23, 2021
    func toReadableString() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d, yyyy "
        let dateString: String? = dateFormatter.string(from: self)
        return dateString ?? "default"
    }
}
