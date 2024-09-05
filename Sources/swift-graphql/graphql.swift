import Graphiti
import Vapor
import GraphQL


struct User: Content {
	var name: String
	func getGroup(req: Request, parent user: User) -> [Group] {
		return [Group(name: "Group \(user.name)")]
	}
}

struct Group: Content {
	var name: String
}

class SampleResolver {
	func getUsers(req: Request, arguments: NoArguments) -> [User] {
		return [
			User(name: "User 1"),
			User(name: "User 2")
		]
	}
}

class SamplePartialSchema: PartialSchema<SampleResolver, Request> {
	@TypeDefinitions
	override var types: Types {
		Type(User.self){
			Field("name", at: \.name)
			Field("groups", at: User.getGroup)
		}

		Type(Group.self){
			Field("name", at: \.name)
		}
	}

	@FieldDefinitions
	override var query: Fields {
		Field("users", at: SampleResolver.getUsers)
	}
}
