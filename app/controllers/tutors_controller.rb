class TutorsController < ApplicationController
    skip_before_action :verify_authenticity_token

    def index
        tutors = Tutor.all
        render json: {tutors: tutors}.to_json, status: :ok
    end
    
    def create
        if params[:tutor][:course_id].present?
            if course.present?
                tutor = Tutor.new(tutor_params)
                course.tutors << tutor
                course.save
                if tutor.save
                    render json: {"message" => "Tutor created successfully", "tutor" => tutor}.to_json, status: :ok
                else
                    render json: {errors: [Errors::get_message("2", [tutor.errors.full_messages.join('\n')])]}.to_json, status: :bad_request
                end
            else
                render json: {errors: [Errors::get_message("3", [params[:tutor][:course_code]])]}.to_json, status: :not_found
            end
        else
            render json: {errors: [Errors::get_message("4")]}.to_json, status: :bad_request
        end
    end
end
