commands:
	@echo "Commands: "

fullservice:
	@start=$$(date +%s); \
	make clean clone configure build-react build-swagger-codegen build-javasdk && \
	seconds=$$(($$(date +%s)-start)); \
	echo "\nFull-service total: $$((seconds/60)):$$(printf "%02d" $$((seconds%60)))"

clean:
	@echo "\nCleaning..." && \
	start=$$(date +%s); \
	d=$$(date +%s); \
	rm -rf platform-client-sdk-common && \
	echo "platform-client-sdk-common | $$(($$(date +%s)-d))s" && \
	d=$$(date +%s); \
	rm -rf swagger-codegen && \
	echo "swagger-codegen            | $$(($$(date +%s)-d))s" && \
	d=$$(date +%s); \
	rm -rf react-app-example && \
	echo "react-app-example          | $$(($$(date +%s)-d))s" && \
	d=$$(date +%s); \
	rm -rf .logs && \
	echo ".logs                      | $$(($$(date +%s)-d))s" && \
	seconds=$$(($$(date +%s)-start)); \
	echo "Clean total: $$((seconds/60)):$$(printf "%02d" $$((seconds%60)))" && \
	mkdir .logs

clone:
	@echo "\nCloning..." && \
	start=$$(date +%s); \
	d=$$(date +%s); \
	git clone https://github.com/purecloudlabs/platform-client-sdk-common.git &> .logs/clone-platform-client-sdk-common.txt && \
	echo "platform-client-sdk-common | $$(($$(date +%s)-d))s" && \
	d=$$(date +%s); \
	git clone https://github.com/purecloudlabs/swagger-codegen.git &> .logs/clone-swagger-codegen.txt && \
	echo "swagger-codegen            | $$(($$(date +%s)-d))s" && \
	d=$$(date +%s); \
	git clone https://github.com/timsmithgenesys/react-app-example.git &> .logs/clone-react-app-example.txt && \
	echo "react-app-example          | $$(($$(date +%s)-d))s" && \
	seconds=$$(($$(date +%s)-start)); \
	echo "Clone total: $$((seconds/60)):$$(printf "%02d" $$((seconds%60)))"

configure:
	@echo "\nConfiguring..." && \
	echo "Writing maven settings file..." && \
	echo "<settings></settings>" > settings.xml
	@dir=$$(pwd); \
	echo "Writing Java SDK local config file..." && \
	cd platform-client-sdk-common/resources/sdk/purecloudjava && echo "---\nenvVars:\n  x:\n    WORKSPACE: $$dir\n    SKIP_TESTS: true\n    EXCLUDE_NOTIFICATIONS: true\n    BUILD_NUMBER: 999\noverrides:\n  settings:\n    mavenTarget: package\n    mavenSettingsFilePath: $$dir/settings.xml" > localConfig.yml

build-swagger-codegen:
	@echo "\nBuilding swagger-codegen..." && \
	start=$$(date +%s); \
	make build-swagger-codegen-impl &> .logs/build-swagger-codegen.txt && \
	seconds=$$(($$(date +%s)-start)); \
	echo "swagger-codegen            | $$((seconds/60)):$$(printf "%02d" $$((seconds%60)))"

build-swagger-codegen-impl:
	@cd swagger-codegen && \
	export JENV_VERSION=1.8 && \
	java -version && \
	mvn clean package

build-javasdk:
	@echo "\nJava SDK pre-build..." && \
	rm -rf platform-client-sdk-common/package-lock.json && \
	rm -rf platform-client-sdk-common/resources/sdk/purecloudjava/extensions/extensions/notifications
	@echo "Building Java SDK..." && \
	start=$$(date +%s); \
	make build-javasdk-impl &> .logs/build-javasdk.txt && \
	seconds=$$(($$(date +%s)-start)); \
	echo "Java SDK                   | $$((seconds/60)):$$(printf "%02d" $$((seconds%60)))"

build-javasdk-impl:
	@cd platform-client-sdk-common && \
	npm i && \
	node sdkBuilder --sdk purecloudjava

build-react:
	@start=$$(date +%s); \
	echo "\nInitializing NVM..." && \
	source ${NVM_DIR}/nvm.sh && \
	nvm list &> .logs/nvm.txt && \
	echo "Building React app..." && \
	cd react-app-example && \
	nvm use && \
	d=$$(date +%s); \
	yarn install &> ../.logs/build-react-yarn-build.txt && \
	echo "yarn install               | $$(($$(date +%s)-d))s" && \
	d=$$(date +%s); \
	yarn build &> ../.logs/build-react-yarn-build.txt && \
	echo "yarn build                 | $$(($$(date +%s)-d))s" && \
	seconds=$$(($$(date +%s)-start)); \
	echo "React total: $$((seconds/60)):$$(printf "%02d" $$((seconds%60)))"
