//
//  SliceViewView.swift
//  digital-trainer
//
//  Created by Madeline LeClair on 7/21/21.
//

import SwiftUI

struct SliceView: View {
    var sliceData: SliceData
    
    var midRadians: Double {
        return Double.pi / 2.0 - (sliceData.startAngle + sliceData.endAngle).radians / 2.0
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Path { path in
                    let width: CGFloat = min(geometry.size.width, geometry.size.height)
                    let height = width
                    path.move(
                        to: CGPoint(
                            x: width * 0.5,
                            y: height * 0.5
                        )
                    )
                    
                    path.addArc(center: CGPoint(x: width * 0.5, y: height * 0.5), radius: width * 0.5, startAngle: Angle(degrees: -90.0) + sliceData.startAngle, endAngle: Angle(degrees: -90.0) + sliceData.endAngle, clockwise: false)
                    
                }
                .fill(sliceData.color)
                
                Text(sliceData.text)
                    .position(
                        x: geometry.size.width * 0.5 * CGFloat(1.0 + 0.78 * cos(self.midRadians)),
                        y: geometry.size.height * 0.5 * CGFloat(1.0 - 0.78 * sin(self.midRadians))
                    )
                    .foregroundColor(Color.white)
            }
        }
        .aspectRatio(1, contentMode: .fit)
    }
}

struct SliceData {
    var startAngle: Angle
    var endAngle: Angle
    var text: String
    var color: Color
}

struct PieSlice_Previews: PreviewProvider {
    static var previews: some View {
        SliceView(sliceData: SliceData(startAngle: Angle(degrees: 0.0), endAngle: Angle(degrees: 120.0), text: "30%", color: Color.black))
    }
}
