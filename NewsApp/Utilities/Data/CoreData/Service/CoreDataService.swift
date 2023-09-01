import CoreData

// MARK: CoreDataServiceProtocol
protocol CoreDataServiceProtocol {
    func fetchData() -> [SaveNews]?
    func saveData(title: String)
    func deleteData(title: String)
}

// MARK: CoreDataService

class CoreDataService: CoreDataServiceProtocol {
    private let coreDataManager = CoreDataManager.shared

    // MARK: Fetch Data
    func fetchData() -> [SaveNews]? {
        return coreDataManager.fetchData(SaveNews.self)
    }

    // MARK: Save Data
    func saveData(title: String) {
        let context = coreDataManager.persistentContainer.viewContext
        let news = SaveNews(context: context)
        news.title = title
        news.id = UUID()
        coreDataManager.saveContext()
        print(news)
    }

    // MARK: Delete Data
    func deleteData(title: String) {
        if let news = fetchData(), let newsToDelete = news.first(where: { $0.title == title }) {
            coreDataManager.deleteObject(newsToDelete)
        }
    }
}
