import SwiftUI
import SwiftData

struct EditMusicView: View {
    @ObservedObject var musicViewModel: MusicViewModel
    @Binding var music: Music?
    
    @Environment(\.dismiss) var dismiss
    
    @State private var showAlert = false
    
    @State private var title: String
    @State private var artist: String
    @State private var genre: String
    @State private var releaseYear: Int?
    @State private var highScore: Int?
    @State private var dateSung: Date
    @State private var key: Int
    @State private var comments: String
    @State private var star: Int
    @State private var vocalRange: String
    @State private var karaokeType: KaraokeType?
    @State private var lyrics: String
    @State private var count: Int
    
    init(musicViewModel: MusicViewModel, music: Binding<Music?>) {
        self.musicViewModel = musicViewModel
        self._music = music
        print(music)
        
        let m = music.wrappedValue
        
        _title = State(initialValue: m?.title ?? "")
        _artist = State(initialValue: m?.artist ?? "")
        _genre = State(initialValue: m?.genre ?? "")
        _releaseYear = State(initialValue: m?.releaseYear)
        _highScore = State(initialValue: m?.highScore)
        _dateSung = State(initialValue: m?.dateSung ?? Date())
        _key = State(initialValue: m?.key ?? 0)
        _comments = State(initialValue: m?.comments ?? "")
        _star = State(initialValue: m?.star ?? 0)
        _vocalRange = State(initialValue: m?.vocalRange ?? "")
        _karaokeType = State(initialValue: m?.karaokeType)
        _lyrics = State(initialValue: m?.lyrics ?? "")
        _count = State(initialValue: m?.count ?? 0)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("曲情報")) {
                    TextField("タイトル", text: $title)
                    TextField("アーティスト", text: $artist)
                    TextField("ジャンル", text: $genre)
                    TextField("リリース年", value: $releaseYear, format: .number)
                        .keyboardType(.numberPad)
                }
                
                Section(header: Text("マイカラ情報")) {
                    TextField("ハイスコア", value: $highScore, format: .number)
                        .keyboardType(.numberPad)
                    DatePicker("最後に歌った日", selection: $dateSung, displayedComponents: .date)
                    Stepper("キー: \(key)", value: $key, in: -12...12)
                    TextField("コメント", text: $comments)
                    Picker("お気に入り度", selection: $star) {
                        Text("なし").tag(0)
                        ForEach(1...5, id: \.self) { i in
                            Text("★ \(i)")
                        }
                    }
                    TextField("音域", text: $vocalRange)
                    Picker("カラオケ種別", selection: $karaokeType) {
                        Text("なし").tag(KaraokeType?.none)
                        ForEach(KaraokeType.allCases) { type in
                            Text(type.rawValue).tag(Optional(type))
                        }
                    }
                    TextField("歌詞メモ", text: $lyrics)
                    Stepper("歌った回数: \(count)", value: $count, in: 0...100)
                }
            }
            .navigationTitle(music == nil ? "音楽を追加" : "音楽を編集")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        guard !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
                            showAlert = true
                            return
                        }
                        
                        if let editingMusic = music {
                            // 編集モード
                            editingMusic.title = title
                            editingMusic.artist = artist
                            editingMusic.genre = genre
                            editingMusic.releaseYear = releaseYear
                            editingMusic.highScore = highScore
                            editingMusic.dateSung = dateSung
                            editingMusic.key = key
                            editingMusic.comments = comments
                            editingMusic.star = star
                            editingMusic.vocalRange = vocalRange
                            editingMusic.karaokeType = karaokeType
                            editingMusic.lyrics = lyrics
                            editingMusic.count = count
                            
                            musicViewModel.saveChanges()
                        } else {
                            // 新規追加
                            let newMusic = Music(
                                title: title,
                                artist: artist,
                                genre: genre,
                                releaseYear: releaseYear,
                                highScore: highScore,
                                dateSung: dateSung,
                                key: key,
                                comments: comments,
                                star: star,
                                vocalRange: vocalRange,
                                karaokeType: karaokeType,
                                lyrics: lyrics,
                                count: count
                            )
                            musicViewModel.addMusic(newMusic)
                        }
                        music = nil
                        dismiss()
                    } label: {
                        Text(music == nil ? "追加" : "保存")
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("キャンセル") {
                        dismiss()
                    }
                }
            }
        }
        .alert("タイトルが未入力です", isPresented: $showAlert) {
            Button("OK", role: .cancel) { }
        }
    }
}

#Preview {
    ContentView()
}
