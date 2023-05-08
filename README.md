# CodeRate

Web-application for creating programming courses. You can create theoretical and practical tasks and run your code on 11 languages.

You need to install and run [RemoteCodeCompiler](https://github.com/zakariamaaraki/RemoteCodeCompiler)

## Requirements:

- **Ruby** 3.0.1
- **Rails** 7.0.4
- **PostgreSQL** 9.5+
- **Docker**

## Running Specs
Check if all tests are passing before you commit your changes.

Make sure you have all the requirements installed.
```sh
rspec spec/
```
## Running Locally

Make sure you have all the requirements installed.

```sh
git clone git@github.com:Starlexxx/CodeRate.git # or clone your own fork
cd CodeRate
bundle install
rails db:create:migrate
rails s
```

Your app should now be running on [localhost:3000](http://localhost:3000/).
