#Question 1
#Create tables: 1.topics with the list of therms 2.lesson_topics as connection between lessons and topics

#Question 2
#In table: 1.topics - name:string 2.lesson_topics - topic_id:references and lesson_id:references 

#Question 3
#No other columns need to be included

#Question 4
#topics table: id, name, created_at, updated_at
#lesson_topics table: id, lesson_id, topic_id, created_at, updated_at

#Question 5
bin/rails generate migration CreateTopics
#Add line: t.string :name to the create_topics
bin/rails db:migrate

#Question 6
bin/rails generate migration CreateLessonTopics

#Question 7: Done
bin/rails db:migrate

#Question 8
bin/rails generate model Topic name:string

#Question 9
bin/rails generate model CreateLessonTopics

#Question 10
#added to file: 
    t.references :lesson, null: false, foreign_key: true
    t.references :topic, null: false, foreign_key: true

#Question 11
bin/rails db:migrate

#Question 12
#create lesson_topic model

#Question 13
Topic.create!(name: "SQL") 
#and 7 more from topic titleslist


