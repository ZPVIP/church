class FriendsController < ApplicationController
  before_action :set_friend, only: [:show, :edit, :update, :destroy]

  # GET /friends
  # GET /friends.json
  def index
    #@friends = Friend.where(:authenticated => false)
  end

  # GET /friends/1
  # GET /friends/1.json
  def show
    @friend = Friend.find(params[:id])
    if @friend.register_ip!=my_ip \
      or (Time.parse(DateTime.now.to_s) - Time.parse(@friend.created_at.to_s))/3600 > 2
      redirect_to new_friend_path
    end
  end

  # GET /friends/new
  def new
    @friend = Friend.new
    @my_ip =  my_ip
  end

  # GET /friends/1/edit
  def edit
    if @friend.register_ip!=my_ip \
      or (Time.parse(DateTime.now.to_s) - Time.parse(@friend.created_at.to_s))/3600 > 2
      redirect_to new_friend_path
    end
  end

  # POST /friends
  # POST /friends.json
  def create
    @friend = Friend.new(friend_params)
    respond_to do |format|
      if @friend.save
        format.html { redirect_to friend_path(@friend), notice: '谢谢！您的信息已被保存.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  # PATCH/PUT /friends/1
  # PATCH/PUT /friends/1.json
  def update
    respond_to do |format|
      if @friend.update(friend_params)
        format.html { redirect_to friend_path(@friend), notice: '信息更新成功！' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_friend
    @friend = Friend.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def friend_params
    params.require(:friend).permit(
        :name,
        :gender,
        :telephone,
        :mobile,
        :email,
        :wechat,
        :birthday,
        :come,
        :job,
        :find_us,
        :find_us_additional,
        :pray,
        :comment,
        :register_ip,
        :participated_gathering_ids => []
    )
  end
end
