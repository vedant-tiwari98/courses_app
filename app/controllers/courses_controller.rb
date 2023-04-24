class CoursesController < ApplicationController
    skip_before_action :verify_authenticity_token

    def index
        # Eager loading to minimize the number of DB calls 
        courses = Course.all.includes(:tutors)
        render json: {courses: courses}.to_json(include: :tutors), status: :ok
    end
    
    def create
        course = Course.new(course_params)        
        tutors_params = params[:course][:tutors_attributes]
        if course.save
            if tutors_params.present?
                tutors_params.each do |tutor|
                    tutor = Tutor.create
                end
            end
            render json: {course: course}.to_json(include: :tutors), status: :ok
        else
            render json: {errors: [Errors::get_message("1", [course.errors.full_messages.join('\n')])]}.to_json, status: :bad_request
        end
    end

    private
    def course_params
        params.require(:course).permit(:title, :code, :description, tutors_attributes: [:name, :email, :course_id, :course_code])
    end
end
