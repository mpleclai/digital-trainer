//
//  Workout.swift
//  digital-trainer
//
//  Created by Madeline LeClair on 7/20/21.
//

import Foundation

class Workout {
    var minutes : Int
    var calories : Int
    var name : String
    var date : Date
    
    init(){
        minutes = 0
        calories = 0
        name = ""
        date = Date()
    }
}
