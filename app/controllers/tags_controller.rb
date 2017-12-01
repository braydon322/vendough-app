class TagsController < ApplicationController
  def index
    @tags = Tag.completed_by_name
  end

  def show
    @tag = Tag.find(params[:id])
    @dealings = Dealing.all_with_tags_completed(@tag)
  end

end
