//
//  ContentView.swift
//  mykara
//
//  Created by Yo_4040 on 2025/04/07.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
//    @StateObject private var musicViewModel: MusicViewModel? = nil
    @State private var isPresentingEditMusic = false
    
    var body: some View {
        let musicViewModel = MusicViewModel(modelContext: modelContext)
        MusicListView(musicViewModel: musicViewModel)
    }
}


#Preview {
    ContentView()
}
