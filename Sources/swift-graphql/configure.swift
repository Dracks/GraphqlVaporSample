import Fluent
import FluentSQLiteDriver
import NIOSSL
import Vapor

// configures your application
public func configure(_ app: Application) async throws {
	do {

		app.migrations.add(SessionRecord.migration)
		// app.migrations.add(InitialMigration())

		app.databases.use(
			DatabaseConfigurationFactory.sqlite(.memory), as: .sqlite)

		try await app.autoMigrate()

		app.sessions.use(.fluent)

		// register routes
		try routes(app)
	} catch {
		print(error)
		try await app.asyncShutdown()
		throw error
	}
}
