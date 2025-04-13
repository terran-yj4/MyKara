import SwiftUI
import SwiftData

class MusicViewModel: ObservableObject {
    @Published var musics: [Music] = []
    
    private var modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        fetchAll()
    }
    
    /// 全ての曲を取得（ソート指定可能）
    func fetchAll(sortedBy sortDescriptors: [SortDescriptor<Music>] = [.init(\.title)]) {
        do {
            let descriptor = FetchDescriptor<Music>(sortBy: sortDescriptors)
            musics = try modelContext.fetch(descriptor)
        } catch {
            print("❌ Fetch failed: \(error.localizedDescription)")
        }
    }
    
    /// 曲を追加
    func addMusic(_ music: Music) {
        modelContext.insert(music)
        musics.append(music) // ← fetchAll() ではなく1件追加で効率化
    }
    
    /// 曲を削除（インデックスで）
    func delete(at offsets: IndexSet) {
        for index in offsets.sorted(by: >) {
            let music = musics[index]
            modelContext.delete(music)
        }
        musics.remove(atOffsets: offsets) // ← fetchAll() ではなく直接更新
    }
    
    /// 曲を削除（インスタンス指定）
    func delete(music: Music) {
        modelContext.delete(music)
        musics.removeAll { $0.id == music.id }
    }
    
    /// 曲を更新（必要なら追加）
    func update(music: Music) {
        // SwiftDataの自動マージに任せる or 将来バリデーション追加
        if !musics.contains(where: { $0.id == music.id }) {
            musics.append(music)
        }
    }
    
    /// 曲を保存
    func saveChanges() {
        do {
            try modelContext.save()
        } catch {
            print("保存に失敗: \(error)")
        }
    }
}
