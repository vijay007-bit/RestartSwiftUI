//
//  OnboardingView.swift
//  Restart
//
//  Created by Vijay Singh on 28/02/24.
//

import SwiftUI

struct OnboardingView: View {
    
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = true
    @State private var buttonWidth: Double = UIScreen.main.bounds.width - 80
    @State private var buttonOffset: CGFloat = 0
    @State private var isAnimationg: Bool = false
    @State private var imageOffset: CGSize = .zero
    @State private var indicatorOpacity: Double = 1.0
    @State private var textTitle: String = "Share."
    
    let hapticFeedback = UINotificationFeedbackGenerator()
    
    
    
    var body: some View {
        ZStack {
            Color("ColorBlue")
                .ignoresSafeArea(.all, edges: .all)
                
            VStack(spacing: 20) {
                Spacer()
                //MARK: - Header
                VStack(spacing: 0){
                    Text(textTitle)
                        .font(.system(size: 60))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .transition(.opacity)
                    
                    Text("""
                        It's not how much we give but
                        how much love we put into giving.
                        """)
                    .font(.title3)
                    .fontWeight(.light)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 10)
                }//VSTACK
                .opacity(isAnimationg ? 1 : 0)
                .offset(y: isAnimationg ? 0 : -40)
                .animation(.easeOut(duration: 1), value: isAnimationg)
                //MARK: - Center
                ZStack{
                    CircleGroupView(ShapeColor: .white, ShapeOpacity: 0.2)
                        .offset(x:imageOffset.width * -1)
                        .blur(radius: abs(imageOffset.width / 5))
                        .animation(.easeOut(duration: 1), value: imageOffset)
                    Image("character-1")
                        .resizable()
                        .scaledToFit()
                        .opacity(isAnimationg ? 1 : 0)
                        .animation(.easeOut(duration: 2), value: isAnimationg)
                        .offset(x: imageOffset.width * 1.2, y: 0)
                        .rotationEffect(.degrees(Double(imageOffset.width/20)))
                        .gesture(
                            DragGesture()
                                .onChanged({ gesture in
                                    if abs(imageOffset.width) <= 150{
                                        imageOffset = gesture.translation
                                        
                                        withAnimation(.linear(duration: 0.25)){
                                            indicatorOpacity = 0
                                            textTitle = "Give."
                                        }
                                    }
                                })
                            
                                .onEnded({ _ in
                                    imageOffset = .zero
                                    
                                    withAnimation(.linear(duration: 0.25)) {
                                        indicatorOpacity = 1
                                        textTitle = "Share."
                                    }
                                })
                        ).animation(.easeOut(duration: 1), value: imageOffset)
                }//: Center
                .overlay(
                    Image(systemName: "arrow.left.and.right.circle")
                        .font(.system(size: 44,weight: .ultraLight))
                        .foregroundColor(.white)
                        .offset(y: 20)
                        .opacity(isAnimationg ? 1 : 0)
                        .animation(.easeOut(duration: 1).delay(2), value: isAnimationg)
                        .opacity(indicatorOpacity)
                    ,       alignment: .bottom
                )
                Spacer()
                //MARK: - Footer
                ZStack{
                    //Background static
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                        .padding(8)
                    
                    //Call to action static
                    
                    Text("Get Started")
                        .font(.system(.title3,design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .offset(x: 20)
                    //Capsule dynamic width
                    HStack {
                        Capsule()
                            .fill(Color("ColorRed"))
                        .frame(width: buttonOffset + 80)
                        Spacer()
                    }
                    //Circle draggable
                    
                    HStack {
                        ZStack{
                            Circle()
                                .fill(Color("ColorRed"))
                            Circle()
                                .fill(.black.opacity(0.15))
                                .padding(8)
                            Image(systemName: "chevron.right.2")
                                .font(.system(size: 24,weight: .bold))
                        }
                        .foregroundColor(.white)
                        .frame(width: 80, height: 80, alignment: .center)
                        .offset(x: buttonOffset)
                        .gesture(
                                DragGesture()
                                    .onChanged({ gesture in
                                        if gesture.translation.width > 0 && gesture.translation.width < buttonWidth - 80{
                                            buttonOffset = gesture.translation.width
                                        }
                                    })
                                
                                    .onEnded({ gesture in
                                        withAnimation(.easeOut(duration: 2)){
                                            if buttonOffset > buttonWidth / 2{
                                                hapticFeedback.notificationOccurred(.success)
                                                buttonOffset = buttonWidth - 80
                                                isOnboardingViewActive = false
                                                playSound(sound: "chimeup", type: "mp3")
                                            }else{
                                                hapticFeedback.notificationOccurred(.warning)
                                                buttonOffset = 0
                                            }
                                        }
                                    })
                            )//:ENdGesture
                        Spacer()
                    }
                }//:FOOTER
                .frame(width:buttonWidth,height: 80,alignment: .center)
                .padding()
                .opacity(isAnimationg ? 1 : 0)
                .offset(y: isAnimationg ? 0 : 40)
                .animation(.easeOut(duration: 1), value: isAnimationg)
                
            }
        }
        .onAppear(perform: {
            isAnimationg = true
        })
        .preferredColorScheme(.dark)
    }
}

#Preview {
    OnboardingView()
}
