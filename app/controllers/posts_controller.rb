class PostsController < ApplicationController
  before_action :authenticate_user
  before_action :set_post, only: [:show, :update, :destroy]

  api! 'Posts Index'
  # resource_description do
  #   formats [:json]
  #   api_versions 'public'
  # end

  # api :POST, '/posts' 'Create post'
  # description 'Create post with specifed post params'
  # param :post, Hash, desc: 'Post information' do
  #   param :title, String, desc: 'Title of the post'
  #   param :content, Fixnum, desc: 'Content of the post'
  # end

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all

    render json: @posts
  end

  # GET /posts/1
  # GET /posts/1.json
  api! 'Posts Show'
  header 'X-User-Email', '...expected value...'
  error code: 401, desc: 'Unauthorized'
  param :title, String, required: true
  param :content, String, required: true
  example 'Success Request:
  {
    "title": "To Kill a Mocking Bird",
    "content": "Some Relevant Content"
  }'

  example 'Error Response:
  {
    "code": 401,
    "message": "Unauthorized"
  }'

  def show
    render json: @post
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)

    if @post.save
      render json: @post, status: :created, location: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      head :no_content
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy

    head :no_content
  end

  private

    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :content)
    end
end
