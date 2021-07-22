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
            NavigationLink(destination: DayView()){
                DatePicker(
                    "Start Date",
                    selection: $date,
                    displayedComponents: [.date]
                )
                .datePickerStyle(GraphicalDatePickerStyle())
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
