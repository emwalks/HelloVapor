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

}
