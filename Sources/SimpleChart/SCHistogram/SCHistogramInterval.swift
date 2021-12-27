//
//  SCHistogramInterval.swift
//  
//
//  Created by fung on 18/12/2021.
//

import SwiftUI

//@available(iOS 15, macOS 12.0, *)
@available(iOS 13, macOS 10.15, tvOS 13, watchOS 6, *)
internal struct SCHistogramInterval: View {
    
    @State var config: SCHistogramConfig
    @State var size: CGSize
    
    internal init(_ config: SCHistogramConfig, _ size: CGSize){
        self.config = config
        self.size = size
    }
    
    internal var body: some View {
        ZStack(alignment: .topLeading){
            Path { path in
                let xRoot = 0.0
                if config.showXAxis && config.showYAxis {
                    path.move(to: CGPoint(x: xRoot, y: 0.0))
                    path.addLine(to: CGPoint(x: xRoot, y: size.height))
                    path.addLine(to: CGPoint(x: size.width, y: size.height))
                }
                else if config.showXAxis || config.showYAxis {
                    if config.showYAxis {
                        path.move(to: CGPoint(x: xRoot, y: 0.0))
                        path.addLine(to: CGPoint(x: xRoot, y: size.height))
                    }
                    else if config.showXAxis {
                        path.move(to: CGPoint(x: xRoot, y: size.height))
                        path.addLine(to: CGPoint(x: size.width, y: size.height))
                    }
                }
                if config.showInterval {
                    for i in 1..<(config.numOfInterval+1) {
                        let intervalPoints = Double(size.height)/Double(config.numOfInterval + 1)
                        path.move(to: CGPoint(x: xRoot, y: size.height - (intervalPoints*Double(i))))
                        path.addLine(to: CGPoint(x: size.width, y: size.height - (intervalPoints*Double(i))))
                    }
                }
            }.stroke(lineWidth: 0.5).foregroundColor(.secondary)
            if config.showYAxisFigure {
                VStack{
                    Text(String(format: "%.0f", config.actualMax))
                        .font(.system(size: size.height/15))
                        .foregroundColor(config.yAxisFigureColor)
                        .offset(x: size.width/100, y: 0)
                    Spacer()
                    Text(String(format: "%.0f", config.actualMin))
                        .font(.system(size: size.height/15))
                        .foregroundColor(config.yAxisFigureColor)
                        .offset(x: size.width/100, y: 0)
                }
            }
        }
    }
}

//@available(iOS 15, macOS 12.0, *)
@available(iOS 13, macOS 10.15, tvOS 13, watchOS 6, *)
internal struct SCHistogramInterval_Previews: PreviewProvider {
    static internal var previews: some View {
        let temp: [SCHistogramData] = [
            SCHistogramData(0.0),
            SCHistogramData(1.0),
            SCHistogramData(2.0),
            SCHistogramData(1.0),
            SCHistogramData(4.0),
            SCHistogramData(3.0),
            SCHistogramData(2.0),
            SCHistogramData(3.0),
            SCHistogramData(5.0),
            SCHistogramData(3.5)]
        SCHistogramInterval(SCHistogramConfig(chartData: temp), CGSize(width: 150, height: 150))
            .frame(width: 150, height: 150)
    }
}
