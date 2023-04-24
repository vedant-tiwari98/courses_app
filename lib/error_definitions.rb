module Errors
    ERROR_CODES = HashWithIndifferentAccess.new(
        "1" => "Error occurred while creating course : %s",
        "2" => "Error occurred while creating tutor : %s",
        "3" => "No course found with code : %s",
        "4" => "Course Code cannot be empty"
    )

    def self.get_message(error_code, params = [])
        {code: error_code.to_s, message: (ERROR_CODES[error_code.to_s] % params)} 
    end
end