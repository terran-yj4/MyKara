enum KaraokeType: String, CaseIterable, Identifiable, Codable {
    case dam = "DAM"
    case joysound = "JOYSOUND"
    case other = "その他"
    
    var id: String { self.rawValue }    // Identifiableに準拠して.idを持っているから、ForEach(KaraokeType.allCases)のように書ける
}
