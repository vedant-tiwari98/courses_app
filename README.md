# README

STEPS TO RUN THE SERVER: navigate to courses_app
INSIDE courses_app : run the following command: rails s -p 3000

Make a POST request from POSTMAN to http://localhost:3000/courses

with the following params:
{ "course": { "title": "test course", "code": "TEST_COURSE_01", "description": "Sample description", "tutors_attributes": [{
"name": "Tutor 1", "email": "test_tutor_1@1abc.com", "course_code": "TEST_COURSE_1"
}] } }

For running the test cases: run the following command : bundle exec rspec spec/controllers/courses_controller_spec.rb
