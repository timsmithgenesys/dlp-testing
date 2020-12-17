# DLP Testing

## Prerequisites

* [jenv](https://www.jenv.be/) with OpenJDK 1.8 (suggested method using brew: `brew tap adoptopenjdk/openjdk && brew cask install adoptopenjdk/openjdk/adoptopenjdk8`)
* [NVM](https://github.com/nvm-sh/nvm) - `build-react` expects `v14.6.0`, but should work with any node version >= 12.0.0 when built manually outside of the makefile

## Running test cases

The tests have been organized in the `Makefile`. Run `make fullservice` to run everything from the beginning. Below are the individual targets:

* `fullservice` - runs everythign
* `clean` - deletes folders and files created by the tests
* `clone` - clones repos
* `configure` - writes config files required for builds
* `build-react` - installs yarn deps and creates a production build of a basic react app
* `build-swagger-codegen` - compiles the swagger-codegen project (prereq for SDK builds). This is a pretty straightforward java build
* `build-javasdk` - builds the Java SDK. The build is invoked via node and also executes the jar built by swagger-codegen. The SDK's integration tests have been disabled for this build

## Results

The output of commands are written to a file in the `.logs` directory instead of the console to keep the console clean and only showing timing results.

### Example console output

```
Cleaning...
platform-client-sdk-common | 33s
swagger-codegen            | 8s
react-app-example          | 56s
.logs                      | 0s
Clean total: 1:37

Cloning...
platform-client-sdk-common | 4s
swagger-codegen            | 13s
react-app-example          | 1s
Clone total: 0:18

Configuring...
Writing maven settings file...
Writing Java SDK local config file...

Initializing NVM...
Building React app...
Found '/Users/timsmith/genesys_src/git/dlp-testing/react-app-example/.nvmrc' with version <v14.6.0>
Now using node v14.6.0 (npm v6.14.6)
yarn install               | 60s
yarn build                 | 18s
React total: 1:30

Building swagger-codegen...
swagger-codegen            | 1:12

Java SDK pre-build...
Building Java SDK...
Java SDK                   | 4:55

Full-service total: 9:32
```
