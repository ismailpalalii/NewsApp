import CoreData

protocol CoreDataServiceProtocol {
    func fetchData() -> [SaveNews]?
    func saveData(title: String)
    func deleteData(id: UUID)
}

class CoreDataService: CoreDataServiceProtocol {
    private let coreDataManager = CoreDataManager.shared

    func fetchData() -> [SaveNews]? {
        return coreDataManager.fetchData(SaveNews.self)
    }

    func saveData(title: String) {
        let context = coreDataManager.persistentContainer.viewContext
        let news = SaveNews(context: context)
        news.title = title
        news.id = UUID()
        coreDataManager.saveContext()
        print(news)
    }

    func deleteData(id: UUID) {
        if let news = fetchData(), let newsToDelete = news.first(where: { $0.id == id }) {
            coreDataManager.deleteObject(newsToDelete)
        }
    }
}
