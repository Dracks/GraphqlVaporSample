import Fluent
import GraphQLKit
import GraphiQLVapor
import Vapor


func routes(_ app: Application) throws {


	// app.middleware.use(SessionsMiddleware(session: app.sessions.driver))
	// app.middleware.use(UserSessionAuthenticator())

	// generate GraphQLSchema
	let sampleSchema = try Schema.create(from: [
		SamplePartialSchema(),
	])

	// Register the schema and its resolver.
	app.register(
		graphQLSchema: sampleSchema, withResolver: SampleResolver())

	// Enable GraphiQL web page to send queries to the GraphQL endpoint
	if !app.environment.isRelease {
		app.enableGraphiQL(on: "graphiql")
	}


}
