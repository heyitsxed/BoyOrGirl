//
//  GuestMyGender.swift
//  BoyOrGirl?
//
//  Created by Cedrick on 2/11/26.
//

import SwiftUI
import SDWebImageSwiftUI

struct GuestMyGender: View {
    @StateObject private var viewModel = GuestMyGenderViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            
            HStack {
                Spacer()

                Text("Guess the Gender")
                    .font(.title)
                    .bold()
                
                Spacer()
            }
            
            ZStack {
                Color.white
                
                if let genderResult = viewModel.gender, !viewModel.inputName.isEmpty, !viewModel.isLoading {
                    VStack(spacing: 15) {
                        VStack(spacing: 12) {
                            
                            HStack {
                                Image(systemName: genderResult.gender.lowercased() == "male" ? "person.fill" : "person.fill.viewfinder")
                                    .foregroundColor(genderResult.gender.lowercased() == "male" ? .blue : .pink)
                                    .font(.system(size: 28))
                                
                                Text("Gender: \(genderResult.gender)")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(genderResult.gender.lowercased() == "male" ? .blue : .pink)
                                
                                Spacer()
                            }
                            
                            HStack {
                                Image(systemName: "percent")
                                    .foregroundColor(.orange)
                                Text("Probability: \(Int(genderResult.probability * 100))%")
                                    .font(.headline)
                                Spacer()
                            }
                            
                            HStack {
                                Image(systemName: "person.2.fill")
                                    .foregroundColor(.green)
                                Text("Count: \(genderResult.count)")
                                    .font(.headline)
                                Spacer()
                            }
                            
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(15)
                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 3)
                        .padding(.horizontal)
                    }

                } else if viewModel.inputName.isEmpty || viewModel.gender == nil {
                    AnimatedImage(url: URL(string: "https://i.redd.it/5unqv87oj8y91.gif"))
                        .resizable()
                        .scaledToFit()
                }
            }
            .frame(height: 230)
            .cornerRadius(20)
            .padding()
            .padding(.bottom, 30)
            
             
            Text("Enter name to predict gender")
                .font(.system(size: 15, weight: .semibold))
            
            TextField("Enter Name", text: $viewModel.inputName)
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 3)
            
            HStack {
                Spacer()
                
                Button {
                    Task { try await viewModel.getGender(for: viewModel.inputName) }
                } label: {
                    Text(viewModel.isLoading ? "Loading..." : "Predict Gender")
                        .padding()
                        .background(Color.yellow)
                        .foregroundColor(.white)
                        .cornerRadius(25)
                        .font(.system(size: 16, weight: .semibold))
                        .textCase(.uppercase)
                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 3)
                }

                
                Spacer()
            }
            .padding()
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    GuestMyGender()
}
