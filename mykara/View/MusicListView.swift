import SwiftUI

struct MusicListView: View {
    @ObservedObject var musicViewModel: MusicViewModel
    @State private var isPresentingEditMusic = false
    @State private var selectedMusic: Music? = nil  // 編集するMusic
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(musicViewModel.musics) { music in
                    Text(music.title)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            selectedMusic = music
                        }
                }
                .onDelete(perform: musicViewModel.delete)
            }
            .navigationTitle("My Karaoke List")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        isPresentingEditMusic = true
                    } label: {
                        Label("Add Music", systemImage: "plus")
                    }
                }
            }
        }
        .sheet(item: $selectedMusic) { binding in
            EditMusicView(musicViewModel: musicViewModel, music: .constant(binding))
                .presentationDetents([.medium])
                .presentationDragIndicator(.visible)
                .presentationCornerRadius(20)
            
        }
        .sheet(isPresented: $isPresentingEditMusic) {
            EditMusicView(musicViewModel: musicViewModel, music: .constant(nil))
                .presentationDetents([.medium])
                .presentationDragIndicator(.visible)
                .presentationCornerRadius(20)
        }
    }
}


#Preview {
    ContentView()
}
