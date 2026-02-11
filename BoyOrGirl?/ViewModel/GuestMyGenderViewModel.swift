//
//  GuestMyGenderViewModel.swift
//  BoyOrGirl?
//
//  Created by Cedrick on 2/11/26.
//

import Combine
import Foundation

class GuestMyGenderViewModel: ObservableObject {
    @Published var gender: GenderResponse?
    @Published var inputName: String = ""
    @Published var isLoading: Bool = false
    
    func getGender(for name: String) async throws {
        isLoading = true
        
        guard let endpoint = URL(string: "https://api.genderize.io/?name=\(name)") else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: endpoint)
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        do {
            let decoder = JSONDecoder()
            gender = try decoder.decode(GenderResponse.self, from: data)
            isLoading = false
        } catch {
            print(error.localizedDescription)
        }
    }
}
