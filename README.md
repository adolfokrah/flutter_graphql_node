#Flutter GraphQl Examplee

This projects demonstrates how to build a flutter powered app with GraphQL

The backend_graphql folder is server side GraphQL application built with node.js

The elibrary folder is the frontend mobile application built with flutter and dart GraphQL client


To run this project, open your termnial or CMD and clone this repo

`git clone https://github.com/adolfokrah/flutter_graphql_node.git`

`cd backend_graphql`

`npm install`

`npm start`

Open the elibrary folder (flutter app with VS code / android studio) 

and run `pub get`

in `lib/global_veriables_controller.dart`

replace `host: "http://xxxxxxxxx:xxxx/graphql"` with the url of your graphQl backend

and run `flutter run`
