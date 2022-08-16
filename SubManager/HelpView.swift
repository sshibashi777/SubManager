//
//  HelpView.swift
//  SubManager
//
//  Created by Shun Ishibashi on 2022/08/16.
//

import SwiftUI

struct HelpView: View {
    var body: some View {
        VStack(spacing: 30) {
            VStack {
                Text("How to use this app")
                    .font(.custom("title", size: 32))
                    .padding(.top, 30)
                
                Text("🧐")
                    .font(.largeTitle)
            }
            
            ScrollView {
                VStack {
                    HStack(alignment: .top) {
                        Spacer()
                        
                        Text("1.")
                            .font(.custom("largeTitle", size: 100))
                        
                        Spacer()
                        
                        VStack {
                            Text("Tap the add button")
                                .frame(width: 200, height: 40)
                            
                            Image(systemName: "plus.circle.fill")
                                .font(.largeTitle)
                        }
                        .padding(.top, 10)
                        
                        Spacer()
                    }
                    
                    HStack(alignment: .top) {
                        Spacer()
                        
                        Text("2.")
                            .font(.custom("largeTitle", size: 100))
                        
                        Spacer()
                        
                        VStack {
                            Text("Choose the date your subscription renews")
                                .frame(width: 200, height: 70)
                            
                            Image("datePicker")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200, height: 200)
                        }
                        .padding(.top, 10)
                        
                        Spacer()
                    }
                    
                    HStack(alignment: .center) {
                        Spacer()
                        
                        Text("3.")
                            .font(.custom("largeTitle", size: 100))
                        
                        Spacer()
                        
                        VStack {
                            Text("Enter the name of the servie")
                                .frame(width: 200, height: 70)
                        }
                        .padding(.top, 10)
                        
                        Spacer()
                    }
                    
                    HStack(alignment: .center) {
                        Spacer()
                        
                        Text("4.")
                            .font(.custom("largeTitle", size: 100))
                        
                        Spacer()
                        
                        VStack {
                            Text("Enter the amount you pay monthly/annualy")
                                .frame(width: 200, height: 70)
                        }
                        .padding(.top, 10)
                        
                        Spacer()
                    }
                    
                    Button {
                        
                    } label: {
                        Text("Understood!")
                            .bold()
                            .foregroundColor(.white)
                            .frame(width: 250, height: 40)
                    }
                    .background(.blue)
                    .cornerRadius(25)
                }
            }
        }
    }
}

struct HelpView_Previews: PreviewProvider {
    static var previews: some View {
        HelpView()
    }
}
