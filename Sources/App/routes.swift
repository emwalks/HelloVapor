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

    app.get("hello", ":name") { req -> String in
    guard let name = req.parameters.get("name") else {
        throw Abort(.internalServerError)
    }
    return "Hello, \(name)!"
    }

    /*
    app.post("info") { req -> String in
    let data = try req.content.decode(InfoData.self)
    return "Hello \(data.name)!"
    }
    */

    app.post("info") { req -> InfoResponse in
    let data = try req.content.decode(InfoData.self)
    return InfoResponse(request: data)
    }


}

struct InfoData: Content {
    /*
    This struct conforms to Content which is Vapor’s wrapper around Codable. 
    Vapor uses Content to extract the request data, whether it’s the default JSON-encoded or form URL-encoded.
    */
 let name: String
}

struct InfoResponse: Content {
  let request: InfoData
}


