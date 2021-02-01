import Vapor

func routes(_ app: Application) throws {
    app.get { req in
        return req.view.render("index", ["title": "Hello Vapor!"])
    }

    app.get("hello") { req -> String in
        return "Hello, world!"
    }

    app.get("hello", "emma") { req -> String in
        return "Hello, Emma!"
    }

    // 1
    app.get("hello", ":name") { req -> String in
    //2
    guard let name = req.parameters.get("name") else {
        throw Abort(.internalServerError)
    }
    // 3
    return "Hello, \(name)!"
    }

    // 1
    app.post("info") { req -> String in
    // 2
    let data = try req.content.decode(InfoData.self)
    // 3
    return "Hello \(data.name)!"
    }

}

struct InfoData: Content {
 let name: String
}

