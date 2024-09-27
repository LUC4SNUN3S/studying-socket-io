# !/bin/bash

init_project() {
    yarn init -y
}

init_repo_git() {
    git init
}

install_package_for_update_package_json() {
    yarn add npe
}

remove_package_for_update_package_json() {
    yarn remove npe
}

install_typescript() {
    yarn add typescript -D
    yarn add ts-node-dev -D

    yarn npe scripts.dev "ts-node-dev ./src/app.ts"
}

install_plugins_pattern_commits() {
    yarn add @commitlint/config-conventional @commitlint/cli -D
    echo "module.exports = { extends: ['@commitlint/config-conventional'] };" >commitlint.config.js

    yarn add husky --dev
    yarn husky install
    yarn husky add .husky/commit-msg 'yarn commitlint --edit $1'
    yarn add commitizen -D
    yarn commitizen init cz-conventional-changelog --yarn --dev --exact

    yarn npe scripts.commit "git-cz"
}

install_eslint() {
    yarn add eslint@^7.2.0 -D
    yarn add eslint-plugin-import@^2.22.1 -D
    yarn add @typescript-eslint/parser@^5.0.0 -D
    yarn add @typescript-eslint/eslint-plugin -D
    yarn add eslint-config-airbnb-base@14.2.1 -D
    yarn add eslint-import-resolver-typescript@2.5.0 -D
    yarn add eslint-import-resolver-typescript@2.5.0 -D
    yarn eslint --init
}

create_folders() {
    mkdir src
    mkdir dist
}

create_file_app () {
    echo "// code here" > ./src/app.ts
}

create_file_gitignore() {
    echo "node_modules" >>.gitignore
    echo "dist" >>.gitignore
}

create_file_tsconfig() {
    echo '{
  "compilerOptions": {
    "target": "es6",                                     
    "module": "commonjs",                                
    "rootDir": "./src",                                  
    "outDir": "./dist",                                   
    "esModuleInterop": true,                           
    "forceConsistentCasingInFileNames": true,           
    "strict": true,                                      
    "skipLibCheck": true,                                
    "moduleResolution": "node",
    "resolveJsonModule": true
  }
}' >tsconfig.json
}

init_project
create_file_gitignore
create_file_tsconfig
init_repo_git
install_package_for_update_package_json
install_typescript
install_plugins_pattern_commits
install_eslint
remove_package_for_update_package_json
create_folders
create_file_app
