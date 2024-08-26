//
//  ContentView.swift
//  DextersLabArticles
//
//  Created by Deepak Singh on 26/08/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = CatService()

    var body: some View {
        VStack(spacing: 20){
            Button("Get Facts with Closure") {
                viewModel.fetchCatFacts() { catFacts in
                    print(catFacts)
                }
            }
            
            Button("Get Facts with Aysnc Await") {
                Task(priority: .userInitiated) {
                    let catFacts = await viewModel.asyncFetchCatFacts()
                    print(catFacts)
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
