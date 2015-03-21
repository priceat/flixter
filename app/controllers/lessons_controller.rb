class LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_in_course
  
  def show
  end

  private

  helper_method :current_lesson
  
  def current_lesson
    @current_lesson ||= Lesson.find(params[:id])
  end

  def require_in_course
    if !current_lesson.section.course.user.enrolled_courses.include?(current_lesson.section.course) 
      redirect_to course_path(current_lesson.section.course), :alert => "You cannot access this course if you are not enrolled."
    end
  end
end