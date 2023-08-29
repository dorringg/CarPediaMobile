//
//  ContentView.swift
//  Shared
//
//  Created by George Dorrington on 21/08/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: CarListViewModel

    var body: some View {
        NavigationView {
            if viewModel.isLoggedIn {
                CarListView(viewModel: viewModel)
            } else {
                LoginView(viewModel: viewModel)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: CarListViewModel())
    }
}

