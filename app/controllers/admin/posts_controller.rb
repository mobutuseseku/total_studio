class Admin::PostsController < ApplicationController
  before_action :find_posts, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin!, except: [:show]

  def new
    @post =  current_admin.posts.build 
    @post.post_images.build
    @post.videos.build
  end

  def create
    @post = current_admin.posts.build(post_params)
    respond_to do |format|
      if @post.save
        format.html { redirect_to [ :admin, @post ], notice: 'Contact was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render 'new' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to ([ :admin, @post ])
    else
      render 'edit'
    end
  end

  def destroy
    @post.destroy
    redirect_to '/blog', notice: "Uspesno obrisan post!"
  end

  private

  def post_params
    params.require(:post).permit(:title, :description, :category_name, :datum, post_images_attributes: [ :caption, :id, :photo, :_destroy ], videos_attributes: [ :id, :title, :url, :description, :_destroy ])
  end

  def find_posts
    @post = Post.find(params[:id])
  end
end