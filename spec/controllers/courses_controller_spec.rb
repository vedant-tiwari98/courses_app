require "rails_helper"

RSpec.describe CoursesController, type: :controller do
  describe "GET #index" do
    it "gives list of courses with their tutors" do
      course1 = Course.create(title: "test course", code: "TEST_COURSE_1", description: "Sample description", tutors_attributes: [{
        name: "Tutor 1", email: "test_tutor@abc.com", course_code: "TEST_COURSE_1"
      }])
      tutor1 = course1.tutors[0]
      get :index
      expect(response.status).to eq(200)
      response_body = JSON.parse(response.body)
      expect(response_body["courses"].length).to eq(1)
      expect(response_body["courses"][0]["title"]).to eq(course1.title)
      expect(response_body["courses"][0]["code"]).to eq(course1.code)
      expect(response_body["courses"][0]["tutors"].length).to eq(1)
      expect(response_body["courses"][0]["tutors"][0]["name"]).to eq(tutor1.name)
      expect(response_body["courses"][0]["tutors"][0]["email"]).to eq(tutor1.email)
      expect(response_body["courses"][0]["tutors"][0]["course_code"]).to eq(tutor1.course_code)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      valid_params = { course: { title: "test course", code: "TEST_COURSE_TEST", description: "Sample description", tutors_attributes: [{
        name: "Tutor 1", email: "test_tutor_4@abc.com", course_code: "TEST_COURSE_1"
      }] } }
      it "creates a new course with tutors" do
        post :create, params: valid_params
        expect(response.status).to eq(200)
        response_body = JSON.parse(response.body)
        expect(response_body["course"]["title"]).to eq(valid_params[:course][:title])
        expect(response_body["course"]["code"]).to eq(valid_params[:course][:code])
        expect(response_body["course"]["tutors"].length).to eq(1)
        expect(response_body["course"]["tutors"][0]["name"]).to eq(valid_params[:course][:tutors_attributes][0][:name])
        expect(response_body["course"]["tutors"][0]["email"]).to eq(valid_params[:course][:tutors_attributes][0][:email])
      end
    end
  end

  describe "POST #create" do
    context "with course code absent" do
      invalid_params = { course: { title: 'Course 2', description: "test description",tutors_attributes: [{ name: 'Tutor 2', email: 'tutor2@example.com' }] } }
      it "creates a new course with tutors" do
        post :create, params: invalid_params
        expect(response.status).to eq(400)
        response_body = JSON.parse(response.body)
        expect(response_body["errors"][0]["code"]).to eq("1")
        expect(response_body["errors"][0]["message"]).to eq("Error occurred while creating course : Code can't be blank")
      end
    end
  end

  describe "POST #create" do
    context "with description absent" do
      invalid_params = { course: { title: 'Course 2', code: "1" ,description: "",tutors_attributes: [{ name: 'Tutor 2', email: 'tutor2@example.com' }] } }
      it "creates a new course with tutors" do
        post :create, params: invalid_params
        expect(response.status).to eq(400)
        response_body = JSON.parse(response.body)
        expect(response_body["errors"][0]["code"]).to eq("1")
        expect(response_body["errors"][0]["message"]).to eq("Error occurred while creating course : Description is too short (minimum is 10 characters)")
      end
    end
  end

  describe "POST #create" do
    context "with description absent" do
        course1 = Course.create(title: "test course", code: "TEST_COURSE_1", "description": "Sample description", "tutors_attributes": [{
            name: "Tutor 1", email: "test_tutor@abc.com", course_code: "TEST_COURSE_1"
          }])
      invalid_params = { course: { title: 'Course test 1', code: "1" ,"description": "test description",tutors_attributes: [
        { name: 'Tutor 1', email: 'test_tutor@abc.com', course_code: "1"}] 
        } }
      it "creates a new course with tutors" do
        post :create, params: invalid_params
        expect(response.status).to eq(400)
        response_body = JSON.parse(response.body)
        expect(response_body["errors"][0]["code"]).to eq("1")
        expect(response_body["errors"][0]["message"]).to eq("Error occurred while creating course : Tutors email has already been taken")
      end
    end
  end
end
