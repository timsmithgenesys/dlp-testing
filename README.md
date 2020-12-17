# DLP Testing

## Prerequisites

* [jenv](https://www.jenv.be/) with OpenJDK 1.8 (suggested method using brew: `brew tap adoptopenjdk/openjdk && brew cask install adoptopenjdk/openjdk/adoptopenjdk8`)
* [Node.js](https://nodejs.org/) - LTS or current should be fine

## Running test cases

The tests have been organized in the `Makefile`. Run `make fullservice` to run everything from the beginning. Below are the individual targets:

* `fullservice` - runs everythign
* `clean` - deletes folders and files created by the tests
* `clone` - clones repos
* `configure` - writes config files required for builds
* `build-swagger-codegen` - compiles the swagger-codegen project (prereq for SDK builds). This is a pretty straightforward java build
* `build-javasdk` - builds the Java SDK. The build is invoked via node and also executes the jar built by swagger-codegen. The SDK's integration tests have been disabled for this build

## Results

The output of commands are written to a file in the `.logs` directory instead of the console to keep the console clean and only showing timing results.

### Example console output

```
Cleaning...
platform-client-sdk-common | 6s
swagger-codegen            | 6s
.logs                      | 0s
Clean total: 0:12

Cloning...
platform-client-sdk-common | 9s
swagger-codegen            | 8s
Clone total: 0:17

Configuring...
Writing maven settings file...
Writing Java SDK local config file...

Building swagger-codegen...
swagger-codegen            | 1:09

Java SDK pre-build...
Building Java SDK...
Java SDK                   | 6:05

Full service total: 7:43
```
