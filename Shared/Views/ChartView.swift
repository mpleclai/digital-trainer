//
//  ChartView.swift
//  digital-trainer
//
//  Created by Madeline LeClair on 7/21/21.
//

import SwiftUI

public struct ChartView: View {
    public let values: [Double]
    public let names: [String]
    public let formatter: (Double) -> String
    public let textColor: Color
    
    public var colors: [Color]
    public var backgroundColor: Color
    
    public var widthFraction: CGFloat
    public var innerRadiusFraction: CGFloat
    
    @State private var activeIndex: Int = -1
    
    var slices: [SliceData] {
        let sum = values.reduce(0, +)
        var endDeg: Double = 0
        var tempSlices: [SliceData] = []
        
        if self.values.count == 0 {
            let degrees: Double = 360
            tempSlices.append(
                SliceData(
                    startAngle: Angle(degrees: 0.0),
                    endAngle: Angle(degrees: 360.0),
                    text: String(format: "%.0f%%", 0),
                    color: Color.gray
                )
            )
        } else {
            for (i, value) in values.enumerated() {
                let degrees: Double = value * 360 / sum
                tempSlices.append(
                    SliceData(
                        startAngle: Angle(degrees: endDeg),
                        endAngle: Angle(degrees: endDeg + degrees),
                        text: String(format: "%.0f%%", value * 100 / sum),
                        color: self.colors[i]
                    )
                )
                endDeg += degrees
            }
        }
        return tempSlices
    }
    
    public init(
        values:[Double],
        names: [String],
        formatter: @escaping (Double) -> String,
        textColor: Color,
        colors: [Color] = [Color.blue, Color.green, Color.orange],
        backgroundColor: Color = Color(red: 21 / 255, green: 24 / 255, blue: 30 / 255, opacity: 1.0),
        widthFraction: CGFloat = 0.75,
        innerRadiusFraction: CGFloat = 0.60
    ){
        self.values = values
        self.names = names
        self.formatter = formatter
        self.textColor = textColor
        
        self.colors = colors
        self.backgroundColor = backgroundColor
        self.widthFraction = widthFraction
        self.innerRadiusFraction = innerRadiusFraction
    }
    
    public var body: some View {
        VStack{
            GeometryReader { geometry in
                ZStack{
                    if values.count > 0  {
                        //Slice logic
                        ForEach(0..<self.values.count){ i in
                            SliceView(sliceData: self.slices[i])
                                .scaleEffect(self.activeIndex == i ? 1.03 : 1)
                        }
                    } else {
                        SliceView(sliceData: self.slices[0])
                    }
                    
                    //Center circle
                    Circle()
                        .fill(self.backgroundColor)
                        .frame(
                            width: widthFraction * geometry.size.width * innerRadiusFraction,
                            height: widthFraction * geometry.size.width * innerRadiusFraction
                        )
                    
                    //Total with value
                    VStack {
                        Text(self.activeIndex == -1 ? "Total" : names[self.activeIndex])
                            .font(.title)
                            .foregroundColor(Color.gray)
                        Text(self.formatter(self.activeIndex == -1 ? values.reduce(0, +) : values[self.activeIndex]))
                            .font(.title)
                    }
                }
            }
            .scaledToFit()
            .background(backgroundColor)
            .frame(width: .infinity, height: 300, alignment: .center)
            
            // Rows
            PieChartRows(
                colors: self.colors,
                names: self.names,
                values: self.values.map { self.formatter($0) },
                percents: self.values.map {
                    String(format: "%.0f%%", $0 * 100 / self.values.reduce(0, +))
                }
            )
            .padding()
        }
        .foregroundColor(textColor)
    }
}

struct PieChartRows: View {
    var colors: [Color]
    var names: [String]
    var values: [String]
    var percents: [String]
    
    var body: some View {
        VStack{
            ForEach(0..<self.values.count){ i in
                HStack {
                    RoundedRectangle(cornerRadius: 5.0)
                        .fill(self.colors[i])
                        .frame(width: 20, height: 20)
                    Text(self.names[i])
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text(self.values[i])
                        Text(self.percents[i])
                            .foregroundColor(Color.gray)
                    }
                }
            }
        }
    }
}

struct PieChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView(
            values: [10,15,12,20],
            names: ["Yoga", "Core", "HIIT", "Strength"],
            formatter: {value in String(format: "%.f minutes", value)},
            textColor: Color.black,
            colors: [Color.red, Color.purple, Color.orange, Color.green],
            backgroundColor: Color.white,
            innerRadiusFraction: 0.75
        )
        
        ChartView(
            values: [],
            names: ["No Workouts"],
            formatter: {value in String(format: "%.f minutes", value)},
            textColor: Color.primary,
            colors: [Color.gray],
            backgroundColor: Color.background,
            innerRadiusFraction: 0.75
        ).preferredColorScheme(.dark)
    }
}
