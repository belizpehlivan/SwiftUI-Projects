//
//  DatePickerTutorialView.swift
//  BetterRest
//
//  Created by Beliz on 7/19/25.
//

import SwiftUI

struct DatePickerTutorialView: View {
    @State private var sleepAmount = 8.0
    @State private var wakeUp = Date.now
    
    var body: some View {
        VStack {
            List {
                Stepper("\(sleepAmount.formatted())", value: $sleepAmount, in: 4...12, step: 0.25)
                
                //  The view binds to a Date instance.
                DatePicker("Please enter a date", selection: $wakeUp, in: Date.now..., displayedComponents: [.date, .hourAndMinute])
                DatePicker("Choose time", selection: $wakeUp, in: Date.now..., displayedComponents: [.hourAndMinute])
                DatePicker("Choose day", selection: $wakeUp, in: Date.now..., displayedComponents: [.date]) 

                Text("\(wakeUp)")
                
                // Automatically rearranges based on the locale
                Text(Date.now, format: .dateTime.day().month().year())
                Text(Date.now , format: .dateTime.hour().minute())
                Text(Date.now, format: .dateTime.hour().minute().day().month().year())
                Text(Date.now.formatted(date: .long, time: .shortened))
                
            }
        }
    }
    
    func trivialExample() {
        let components = Calendar.current.dateComponents([.hour, .minute], from: Date.now)
        let hour = components.hour ?? 0
        let minute = components.minute ?? 0
        
        print("Current time is \(hour):\(minute)")
    }
}

#Preview {
    DatePickerTutorialView()
}
 


