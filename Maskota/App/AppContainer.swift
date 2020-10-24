import Foundation

final class AppContainer {
    let localDataSource: CatRealmDataSource
    let catRepository: CatRepository
    let catUseCase: CatUseCase

    static let shared = AppContainer()

    private init() {
        localDataSource = CatRealmDataSourceImp(realm: RealmFactory().createInstance())
        catRepository = CatRepositoryImp(localDataSource: localDataSource)
        catUseCase = CatUseCaseImp(repository: catRepository)
    }
}
