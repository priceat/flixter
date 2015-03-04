class LessonsController < ApplicationController
  before_action :authenticate_user!
  
  def show
    course = current_lesson.section.course
    if current_user.enrolled_in?(course)
     render current_lesson
    else
      flash[:alert] = "You Must Be Enrolled to See Lessons"
      redirect_to course_path(course)
    end
  end

  private

  helper_method :current_lesson
  def current_lesson
    @current_lesson ||= Lesson.find(params[:id])
  end
end
