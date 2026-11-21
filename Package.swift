// swift-tools-version: 6.0


// // swift-tools-version: 6.0

// swift-tools-version: 6.0
import PackageDescription

let package = Package(
   name: "BibliotecaCLI",
   platforms: [
       .macOS(.v15)
   ],
   products: [
       .executable(
           name: "BibliotecaCLI",
           targets: ["BibliotecaCLI"]
       )
   ],
   targets: [
       .executableTarget(
           name: "BibliotecaCLI",
           path: "cli_biblioteca_ios"
       )
   ]
)

