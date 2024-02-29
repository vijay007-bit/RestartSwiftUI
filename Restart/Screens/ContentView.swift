//
//  ContentView.swift
//  Restart
//
//  Created by Vijay Singh on 28/02/24.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = true
    
    var body: some View {
        ZStack{
            if isOnboardingViewActive{
                OnboardingView()
            }else{
                HomeView()
            }
        }//: ZSTACK
    }
}

#Preview {
    ContentView()
}
