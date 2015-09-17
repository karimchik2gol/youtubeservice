class IndexController < ApplicationController
  skip_before_filter :check_admin
  layout "public"
  def index
  	session[:youtube_info_id]=nil
  	session[:user_id]=nil
  end

  def registration
  	unless session[:youtube_info_id]
  		redirect_to "/index/start"
  	else
  		@user=User.new
  	end
  end

  def create
  	if session[:youtube_info_id]
  		if !User.find_by_youtube_info_id(session[:youtube_info_id])
  			params[:user][:youtube_info_id]=session[:youtube_info_id]

		  	user=User.create(params[:user])
		  	user.save

  			params[:anketa][:user_id]=user.id
  			YoutubeInfoId.find(session[:youtube_info_id]).update_attributes(params[:anketa])
		end
		redirect_to root_url
	else
		redirect_to "/index/start"
	end
  end

  def start
    objectYoutube=YoutubeInfoId.new
    youtube_info_id=objectYoutube.startYoutubeApi
    session[:youtube_info_id]=youtube_info_id.id

    if @user=User.find_by_youtube_info_id(youtube_info_id.id)
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
  	youtubeinfoid=YoutubeInfoId.search(params[:search])
  	@users=youtubeinfoid.result
  	respond_to do |format|
  		format.html{render :partial=>"channels.html.erb"}
  	end
  end

  def category
  	puts "id"+params[:id]+","
  	search=User.order("created_at DESC").search(:category_cont=>"id"+params[:id]+",")
  	@users=search.result
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
