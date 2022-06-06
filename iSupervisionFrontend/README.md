# isupervision

## Getting Started

1. Create schema in MySQL Workbench with name mydb

2. If possible create database user with username = root and password = root. Otherwise change username or password in resources/application.properties

3. Start backend application: Open and run in IntelliJ

4. Start frontend application: Open VSCode -> Strg + S in pubspec.yaml file. Then on the right bottom where stands windows choose Chrome.
Flutter and Chrome also has to be installed. Run the application in main.dart!

5. Everything should work :) 

## Bugs

There are still some bugs in it, which i couldn't detect and repair. 

1. All Screens wont get updated if something changes. 
2. Users at projects arent listet because of JSON
3. And some little mistakes like: Assistant can sign in into Project which is expired... and so on

## TODO's

Focus on that project was functionality, so the design has suffered a little bit. Security doesn't even exist. So passwords are saved as raw plain text and everyone who knows the https request has access to it. Obviously that must be improved.

