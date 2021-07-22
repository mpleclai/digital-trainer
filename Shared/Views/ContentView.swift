//
//  ContentView.swift
//  Shared
//
//  Created by Madeline LeClair on 7/20/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack{
            Text("Date")
                .font(.title)
                .bold()
            
            ChartView(
                values: [10,15,12],
                names: ["Yoga", "Core", "HIIT"],
                formatter: {value in String(format: "%.f minutes", value)},
                textColor: Color.black,
                colors: [Color.red, Color.purple, Color.orange, ],
                backgroundColor: Color.white,
                innerRadiusFraction: 0.75
            )
            .padding()
            Button("Add workout") {
                print("eeeeee")
            }
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
