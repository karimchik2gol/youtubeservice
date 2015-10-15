class IndexController < ApplicationController
  skip_before_filter :check_admin
  before_filter :check_user, only: [:applicants, :offers, :createoffer, :createofferpost, :editoffer, :account, :collabration, :destroyoffer,
                                    :updateoffer, :update_account, :offerdetails, :profile, :offerapplycreate, :createtopic, :directmessages,
                                    :topic, :createmessage, :searchingProfile, :sponsors, :createyslyga, :sponsorsdetails]
  layout "public"

  def check_user
  	unless session[:user_id] && session[:youtube_info_id]
  		redirect_to root_url 
  		return nil
  	end
  end

  def index
  	#session[:youtube_info_id]=nil
  	#session[:user_id]=nil
    if session[:youtube_info_id] && !session[:user_id]  
      redirect_to "/index/registration"
    elsif session[:youtube_info_id] && session[:user_id]
      redirect_to "/me"
    end
  end

  def me
    @user=User.find(session[:user_id])
    @youtubeinfooid=YoutubeInfoId.find(session[:youtube_info_id])  
    @offers=Offer.order("created_at DESC").limit(5).where(:user_id=>session[:user_id])
    @topics=Topic.order("created_at DESC").limit(5).where("(to_topic = ? or from_topic = ?)", session[:user_id], session[:user_id])
  end

  def logout
    session[:user_id]=nil
    session[:youtube_info_id]=nil
    redirect_to root_url
  end

  def registration
  	unless session[:youtube_info_id]
  		redirect_to root_url
  	else
      @url="/index/create"
  		@user=User.new
      redirect_to root_url if User.find_by_youtube_info_id(session[:youtube_info_id])
  	end
  end

  def create
    user=User.find_by_youtube_info_id(session[:youtube_info_id])
    error_validate=nil
    begin
    	if session[:youtube_info_id] and !user
        params[:user][:youtube_info_id]=session[:youtube_info_id]
        user=User.create(params[:user])
        if user.valid?
          user.save
          params[:anketa][:user_id]=user.id
          YoutubeInfoId.find(session[:youtube_info_id]).update_attributes(params[:anketa])
          session[:user_id]=user.id
        else
          error_validate=user.errors.to_a
        end
    	end
    rescue
      error_validate=true
    end

    respond_to do |format|
      format.json{render :json=>error_validate.to_json}
    end
  end

  def start
    thread_list=Thread.list.count

    objectYoutube=YoutubeInfoId.new
    youtube_info_id, auth=objectYoutube.startYoutubeApi

    respond_to do |format|
      format.json{render :json=>youtube_info_id.to_json}
    end
  end


  def getyoutubeauth
    youtube_info_id=YoutubeInfoId.execute_info(params[:code])
    session[:youtube_info_id]=youtube_info_id.id
    @user=User.find_by_youtube_info_id(youtube_info_id.id)
    if @user
      session[:user_id]=@user.id
      redirect_to root_url
    else
      redirect_to "/index/registration"
    end
  end

  def search
  	@users=User.order("created_at DESC")
  end

  def searchingCheckbox
  	youtubeinfoid=YoutubeInfoId.order("created_at DESC").search(params[:search])
  	@users=youtubeinfoid.result
    @id=params[:id] if params[:id] and !params[:id].to_s.empty?

  	respond_to do |format|
  		format.html{render :partial=>"channels.html.erb"}
  	end
  end

  def category
  	search=User.order("created_at DESC").search(:category_cont=>"id"+params[:id]+",")
  	@users=search.result
  end

  def profile
  	if session[:user_id]
  		@user=User.find(params[:id])
  	else
  		redirect_to "/index/registration"
  	end
  end

  def offers
  	@offers=Offer.where(:user_id=>session[:user_id])
  end

  def createoffer
  	@offer=Offer.new
  	@url="/index/createofferpost"
  end

  def createofferpost
  	params[:offer][:user_id]=session[:user_id]
  	offer=Offer.create(params[:offer])
    if offer.valid?
      offer.save
      error_validate=false
    else
      error_validate=offer.errors.to_a
    end
  	respond_to do |format|
      format.json{render :json=>error_validate.to_json}
    end
  end

  def editoffer
  	@offer=Offer.find(params[:id])
  	if @offer.user_id==session[:user_id]
  		@url="/index/#{@offer.id}/updateoffer"
  	else
  		redirect_to root_url
  	end
  end

  def updateoffer
  	@offer=Offer.find(params[:id])
    @offer.assign_attributes(params[:offer])
    error_validate=false
  	if @offer.user_id==session[:user_id]
      if @offer.valid?
  		  @offer.save
      else
        error_validate=offer.errors.to_a
      end

      respond_to do |format|
        format.json{render :json=>error_validate.to_json}
      end
  	end
  end

  def destroyoffer
  	@offer=Offer.find(params[:id])
  	if @offer.user_id==session[:user_id]
  		@offer.destroy
  		redirect_to "/offer"
  	else
  		redirect_to root_url
  	end
  end

  def collabration
    @offers=Offer.order("created_at DESC").where("user_id != ?", session[:user_id])
  end

  def account
    @user=User.find(session[:user_id])
    @url="/index/#{@user.id}/update_account"
  end

  def update_account
    @user=User.find(session[:user_id])
    error_validate=nil
    if session[:youtube_info_id] and session[:user_id]
      params[:user][:youtube_info_id]=session[:youtube_info_id]
      @user.assign_attributes(params[:user])
      if @user.valid?
        @user.save
        params[:anketa][:user_id]=@user.id
        YoutubeInfoId.find(session[:youtube_info_id]).update_attributes(params[:anketa])
      else
        error_validate=@user.errors.to_a
      end
    end

    respond_to do |format|
      format.json{render :json=>error_validate.to_json}
    end
  end

  def offerdetails
    @offer=Offer.find(params[:id])
  end

  def offerapplycreate
    hash={:user_id=>session[:user_id], :offer_id=>params[:id]}
    if Offermessage.where(hash).count<1
      Offermessage.create(hash).save
    end
    redirect_to request.referrer
  end

  def yslygaapplycreate
    hash={:user_id=>session[:user_id], :yslygi_id=>params[:id]}
    if Offermessage.where(hash).count<1
      Offermessage.create(hash).save
    end
    redirect_to request.referrer
  end

  def applicants
    offer=Offer.find(params[:id])
    if offer.user_id==session[:user_id]
      @offermessages=Offermessage.where(:offer_id=>params[:id])
    else
      redirect_to root_url
    end
  end

  def createtopic
    params[:topic][:to_topic]=params[:id]
    params[:topic][:from_topic]=session[:user_id]
    topic=Topic.create(params[:topic])
    error=nil
    if topic.valid?
      topic.save
    else
      error=topic.errors.to_a
    end

    respond_to do |format|
      format.json{render :json=>error.to_json}
    end
  end

  def directmessages
    @topics=Topic.where("(to_topic = ? or from_topic = ?)", session[:user_id], session[:user_id])
  end

  def topic
    @topic=Topic.where("id = ? and (to_topic = ? or from_topic = ?)", params[:id], session[:user_id], session[:user_id]).first
    if @topic
      @messages=Message.order("created_at DESC").limit(30).find_all_by_topic_id(@topic.id)
    else
      redirect_to request.referrer
    end
  end

  def createmessage
    topic=Topic.where("id = ? and (to_topic = ? or from_topic = ?)", params[:message][:topic_id], params[:id], params[:id]).first
    if topic
      params[:message][:to_message]=params[:id]
      params[:message][:from_message]=session[:user_id]
      @message=Message.create(params[:message])
      if @message.valid?
        error=true
        @message.save
      else
        error=nil
      end
    else
      error=nil
    end
    
    respond_to do |format|
      if error
        format.html{render :partial=>"itemMessage.html.erb"}
      else
        format.html{render :json=>nil.to_json}
      end
    end
  end

  def searchingProfile
    @users=YoutubeInfoId.order("created_at DESC").where("lower(name) LIKE ?", "%#{params[:title].mb_chars.downcase}%")
    respond_to do |format|
      format.html{render :partial=>"channels.html.erb"}
    end    
  end

  def sponsors
    @yslygi=Yslygi.order("created_at DESC").where(:to_topic=>session[:user_id])
  end

  def createyslyga
    params[:yslygi][:to_topic]=params[:id]
    params[:yslygi][:user_id]=session[:user_id]
    topic=Yslygi.create(params[:yslygi])
    error=nil
    if topic.valid?
      topic.save
    else
      error=topic.errors.to_a
    end

    respond_to do |format|
      format.json{render :json=>error.to_json}
    end
  end

  def sponsorsdetails
    @yslyga=Yslygi.find(params[:id])
  end
  #LOGIN ADMIN
  def admin
  end

  def checkAdmin
  	admin=Admin.find_by_email(params[:email])
  	if admin and admin.authenticate(params[:password])
  		session[:admin_id]=admin.id
  		redirect_to admins_path
  	else
  		redirect_to request.referrer
  	end
  end
end
