# README

- MineSweeper app implementation in Ruby.

- The application allows a user to choose between preset level games or create custom one when on the new game screen.

- This application uses Ruby version 3.2.2 To install, use rvm or rbenv.

- RVM

`rvm install 3.2.2`

`rvm use 3.2.2`

- Rbenv

`rbenv install 3.2.2`

- Bundler provides a consistent environment for Ruby projects by tracking and installing
  the exact gems and versions that are needed. I recommend bundler version 2.0.2. To install:

- You need Rails. The rails version being used is rails version 7

- To install:

`gem install rails -v '~> 7'`

\*To get up and running with the project locally, follow the following steps.

- Clone the app

- With SSH

`git@github.com:Mutuba/ruby-mines-sweeper.git`

- With HTTPS

`https://github.com/Mutuba/ruby-mines-sweeper.git`

- Move into the directory and install all the requirements.

- cd ruby-mines-sweeper

- run `bundle install` to install application packages

- Run `rails db:create` to create a database for the application

- Run `rails db:migrate` to run database migrations and create database tables

- The application can be run by running the below command:-

`rails s` or `rails server`

- To run tests, run the following command
  `rspec`

Screenshots:

Games listing page
<img width="1440" alt="Screenshot 2024-08-02 at 17 03 06" src="https://github.com/user-attachments/assets/62f16845-b06b-4fb0-ae49-144a13233d42">


Custom game set up page
<img width="1435" alt="Screenshot 2024-08-02 at 17 06 19" src="https://github.com/user-attachments/assets/f37c28c5-1a9d-4b53-a16f-f023ec11c397">


A game in session
<img width="1440" alt="Screenshot 2024-08-02 at 17 05 39" src="https://github.com/user-attachments/assets/4857c260-a72f-416b-82da-cb968c4597cc">


A lost game

<img width="1440" alt="Screenshot 2024-08-02 at 17 05 14" src="https://github.com/user-attachments/assets/9a25a481-35d9-4379-95f3-e3a311c08cbd">


Game levels listing

<img width="1440" alt="Screenshot 2024-08-02 at 17 23 23" src="https://github.com/user-attachments/assets/992872a3-a4f2-49a6-821b-abdd8172252f">
