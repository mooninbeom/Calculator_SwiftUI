//
//  ContentView.swift
//  SwiftUIStudy
//
//  Created by 문인범 on 2023/09/06.
//

import SwiftUI

struct ContentView: View {
    
    let buttons = [
        ["AC", "+/-", "%", "/"],
        ["7", "8", "9", "x"],
        ["4", "5", "6", "-"],
        ["1", "2", "3", "+"],
        ["0", ".", "="]
    ]
    
    @Environment(\.colorScheme) var colorScheme

    @State private var selectedOperator: String = ""
    @State private var screenWidth: CGFloat = 0
    @State private var screenHeight: CGFloat = 0
    @ObservedObject var calculatorManager = CalculatorManager()
    
    var body: some View {
        GeometryReader { proxy in
            
            VStack(spacing: 15) {
                
                Spacer(minLength: UIScreen.main.bounds.width/4)
                Text(calculatorManager.display)
                    .font(.system(size: screenHeight))
                    .fontWeight(.light)
                    .lineLimit(1)
                    .padding(.trailing, 20)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                
                ForEach(buttons, id: \.self) { buttonArray in
                    HStack(spacing: 15) {
                        ForEach(buttonArray, id: \.self) { button in
                            Button(action: {calculatorManager.pressButton(button)},
                                   label: {
                                Text(button)
                                    .font(.title)
                                    .fontWeight(.semibold)
                                    .foregroundColor(buttonTextColor(button))
                                //                                .background(buttonBackgroundColor(button))
                                //                                .cornerRadius(10)
                                    .padding(1)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity,
                                           alignment: getButtonZeroAlignment(button))
                                
                            }).buttonStyle(.bordered)
                                .background((isToggled(calculatorManager)) ? toggleBackgroundColor(button) : buttonBackgroundColor(button))
                                .cornerRadius(.infinity)
                                .frame(width: getButtonZeroWidth(button) ,height: screenWidth)
                        }
                    } //.frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }.padding(10)
                .onAppear{
                    screenWidth = proxy.size.width/5
                    screenHeight = proxy.size.height/8
                }
        }
    }
    
    func buttonTextColor(_ button: String) -> Color {
        switch (button) {
        case "AC","+/-","%": return Color(uiColor: UIColor.systemBackground)
        default: return .white
        }
    }
    
    func buttonBackgroundColor(_ button: String) -> Color {
        switch (button) {
        case "AC","+/-","%": return Color(uiColor: .white.withAlphaComponent(0.9))
        case "/", "x", "-", "+", "=": return Color(uiColor: .systemOrange)
        default: return Color(.darkGray.withAlphaComponent(0.5))
        }
    }
    
    func toggleBackgroundColor(_ button: String) -> Color {
        switch button {
        case "/", "x", "-", "+": return .white
        default: return buttonBackgroundColor(button)
        }
    }
    
    func getButtonZeroWidth(_ button: String) -> CGFloat {
        switch (button) {
        case "0": let width = screenWidth*2 + 15
            return width
        default: return screenWidth
        }
    }
    
    func getButtonZeroAlignment(_ button: String) -> Alignment {
        switch (button) {
        case "0": return .leading
        default: return .center
        }
    }
    
    func isToggled(_ manager: CalculatorManager) -> Bool {
        return manager.selectedOperator != ""
    }
    
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



