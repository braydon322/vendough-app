class TagsController < ApplicationController
  def index
    @tags = Tag.completed_by_name
  end

  def show
  end

end
