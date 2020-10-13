import RealmSwift
import Foundation

final class RealmFactory {
    private let realmName = "app.maskota.realm"

    func createInstance() -> Realm {
        do {
            let url = try getUrl()

            let configuration = Realm.Configuration(
                fileURL: url,
                schemaVersion: 0
            )

            return try Realm(configuration: configuration)

        } catch {
            deleteRealm()
            return createInstance()
        }
    }

    private func deleteRealm() {
        do {
            try FileManager.default.removeItem(at: getUrl())
        } catch {
            print(error.localizedDescription)
        }
    }

    private func getUrl() throws -> URL {
        let fileManager = FileManager()

        guard
            let directory = NSSearchPathForDirectoriesInDomains(
                .documentDirectory,
                .userDomainMask,
                true
            ).first else {
                throw ErrorApp.foo
        }

        if !fileManager.fileExists(atPath: directory) {
            try fileManager.createDirectory(
                atPath: directory,
                withIntermediateDirectories: true,
                attributes: nil
            )
        }

        return .init(fileURLWithPath: "\(directory)/\(realmName)")
    }
}

