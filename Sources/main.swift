import Prorsum
import Foundation

let server = try! HTTPServer { (request, writer) in
    do {
        let response = Response(
            headers: ["Server": "Prorsum Micro HTTP Server"],
            body: .buffer("Hello, Server Swift Swift by Prosum".data)
        )

        try writer.serialize(response)

        writer.close()
    } catch {
        fatalError("\(error)")
    }
}

try! server.bind(host: "0.0.0.0", port: 3000)
print("Server listening at 0.0.0.0:3000")
try! server.listen()

RunLoop.main.run()
