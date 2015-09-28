#!/usr/bin/ruby
root="/home/deployer/apps/blog/shared/bundle/ruby/1.9.1/gems/google-api-client-0.8.6/lib"
require 'rubygems'
require "#{root}/google/api_client"
require "#{root}/google/api_client/client_secrets"
require "#{root}/google/api_client/auth/file_storage"
require "#{root}/google/api_client/auth/installed_app"
require 'openssl'

OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
class YoutubeApi
  # These OAuth 2.0 access scopes allow for read-only access to the authenticated
  # user's account for both YouTube Data API resources and YouTube Analytics Data.
  YOUTUBE_SCOPES = ['https://www.googleapis.com/auth/youtube.readonly',
  'https://www.googleapis.com/auth/yt-analytics.readonly', 'https://www.googleapis.com/auth/plus.me']
  YOUTUBE_API_SERVICE_NAME = 'youtube'
  YOUTUBE_API_VERSION = 'v3'
  YOUTUBE_ANALYTICS_API_SERVICE_NAME = 'youtubeAnalytics'
  YOUTUBE_GOOGLE_PLUS_API_SERVICE_NAME = 'plus'
  YOUTUBE_ANALYTICS_API_VERSION = 'v1'
  YOUTUBE_GOOGLE_PLUS_API_VERSION = 'v1'
  $PROGRAM_NAME="Test"
  now = Time.new.to_i
  seconds_in_day = 60 * 60 * 24
  $one_day_ago = Time.now.strftime('%Y-%m-%d')
  $start_data = "1980-01-01"
  $month_ago = Time.at(now - seconds_in_day*31).strftime("%Y-%m-%d")
  $hash_DATA={}

  def get_authenticated_services
    $client = Google::APIClient.new(
      :application_name => $PROGRAM_NAME,
      :application_version => '1.0.0'
    )
    youtube = $client.discovered_api(YOUTUBE_API_SERVICE_NAME, YOUTUBE_API_VERSION)
    youtube_analytics = $client.discovered_api(YOUTUBE_ANALYTICS_API_SERVICE_NAME, YOUTUBE_ANALYTICS_API_VERSION)
    plus = $client.discovered_api(YOUTUBE_GOOGLE_PLUS_API_SERVICE_NAME, YOUTUBE_GOOGLE_PLUS_API_VERSION) 
    
    if true
      if Rails.root.to_s.include?("releases/")
        root="/home/deployer/apps/blog/current"
      else
        root=Rails.root
      end
      
      file_storage = Google::APIClient::FileStorage.new("#{root}/#{$PROGRAM_NAME}-oauth2.json") 

      client_secrets = Google::APIClient::ClientSecrets.load("#{root}/client_secrets.json")
      flow = Google::APIClient::InstalledAppFlow.new(
        :client_id => client_secrets.client_id,
        :client_secret => client_secrets.client_secret,
        :scope => YOUTUBE_SCOPES
      )
      $client.authorization = flow.authorize(file_storage)
    else
      $client.authorization = file_storage.authorization
    end
    $hash_DATA[:refresh_token]=file_storage.authorization.refresh_token




    return youtube, youtube_analytics, plus#, google_plus
  end

  def opts_initialize
    opts = Trollop::options do
      opt :metrics, 'Report metrics', :type => String, :default => "viewerPercentage"#views,comments,likes,dislikes,videosAddedToPlaylists,videosRemovedFromPlaylists,shares,favoritesAdded,favoritesRemoved,estimatedMinutesWatched,averageViewDuration,averageViewPercentage,annotationClickThroughRate,annotationCloseRate,annotationImpressions,annotationClickableImpressions,annotationClosableImpressions,annotationClicks,annotationCloses,subscribersGained,subscribersLost"
      opt :dimensions, 'Report dimensions', :type => String, :default => 'ageGroup,gender'
      opt 'start-date', 'Start date, in YYYY-MM-DD format', :type => String, :default => $start_data
      opt 'end-date', 'Start date, in YYYY-MM-DD format', :type => String, :default => $one_day_ago
    end
    opts  
  end

  def execute_data_analytic
    channels_response = $client.execute!(
        :api_method => $youtube.channels.list,
        :parameters => {
          :mine => true,
          :part => 'id'
        }
      )
    channels_response
  end

  def main
    begin
      opts=opts_initialize
      $youtube, $youtube_analytics, $plus = get_authenticated_services
      channels_response=execute_data_analytic

      ids="#{channels_response.data.items[0].id}"
      opts[:ids] = "channel==#{ids}"

      $hash_DATA[:name], $hash_DATA[:description], $hash_DATA[:trailer], $hash_DATA[:video_count], $hash_DATA[:published_at] = channel_name_and_description_and_trailer(ids)
      $hash_DATA[:channel_id]="#{ids}"
      $hash_DATA[:demographic]=demographic(opts)
      $hash_DATA[:gender], $hash_DATA[:gender_percentage]=gender(opts)
      $hash_DATA[:age_gteq], $hash_DATA[:age_lteq]=age(opts)
      $hash_DATA[:views_per_month]=views_per_month(opts)
      $hash_DATA[:views]=views(opts)
      $hash_DATA[:average_views_per_video]=average_views_per_video
      $hash_DATA[:average_sharing]=average_sharing(opts)
      $hash_DATA[:average_likes]=average_likes(opts)
      $hash_DATA[:average_posted_videos_per_month]=average_posted_videos_per_month
      $hash_DATA[:country]=countries(opts)
      $hash_DATA[:subscribers]=subscribers(opts)
      $hash_DATA[:image]=getProfileImage

      puts $hash_DATA
    rescue Google::APIClient::TransmissionError => e
      puts e.result.body
    end
    return $hash_DATA
  end

  def getProfileImage
    response = $client.execute($plus.people.get, {'userId' => "me"})
    return JSON.parse(response.body)['image']['url']
  end


  def countries(opts)
    opts[:dimensions] = 'country'
    opts[:metrics] = 'views'
    get_data(opts)
  end

  def average_posted_videos_per_month
    time_in_month=(Time.now - $hash_DATA[:published_at]).to_f/(3600*24)
    (($hash_DATA[:video_count].to_i/time_in_month)*30).round(2)
  end

  def average_likes(opts)
    opts["metrics"]="likes"
    number_of_likes=get_data(opts)
    (number_of_likes.to_f/$hash_DATA[:video_count].to_f).round(2)
  end

  def average_sharing(opts)
    opts["metrics"]="shares"
    number_of_sharing=get_data(opts)
    (number_of_sharing.to_f/$hash_DATA[:video_count].to_f).round(2)
  end

  def gender(opts)
    opts[:dimensions] = 'gender'
    opts[:metrics] = 'viewerPercentage'
    gender=get_data(opts)
    genders=gender.split(",")
    genderTwo=nil
    if(genders[1].to_i>=75)
      genderTwo=genders[0]
    elsif(genders[3].to_i>=75)
      genderTwo=genders[2]
    end

    return gender, genderTwo
  end

  def age(opts)
    opts[:dimensions] = 'ageGroup'
    opts[:metrics] = 'viewerPercentage'
    ages=get_data(opts)
    index=0
    curMax=0
    max=0
    splited=ages.split(",")
    splited.each do |f|
      if f.to_f>max
        max=f.to_f 
        curMax=index
      end
      index+=1
    end

    if splited[curMax-1]
      splited=splited[curMax-1].gsub("age","").split("-")

      splited[0]=0 if splited[0].to_i==0
      splited[1]=100 if splited[1].to_i==0 

      return splited[0].to_i, splited[1].to_i
    else
      return nil
    end
  end

  def views(opts)
    opts["start-date"]=$start_data
    get_data(opts)
  end

  def average_views_per_video
    $hash_DATA[:views].to_i/$hash_DATA[:video_count].to_i
  end

  def channel_name_and_description_and_trailer(ids)
    opts = Trollop::options do
      opt :part, 'Report metrics', :type => String, :default => "brandingSettings,statistics,topicDetails,snippet"
    end
    opts[:id]=ids
    youtube_data_response=$client.execute!(
      :api_method => $youtube.channels.list,
      :parameters => opts
    )

    dataItems=youtube_data_response.data.items[0]['brandingSettings']['channel']
    name=dataItems['title']
    description=dataItems['description']
    trailer=dataItems['unsubscribedTrailer']
    videoCount=youtube_data_response.data.items[0]['statistics']['videoCount']
    publishedAt=youtube_data_response.data.items[0]['snippet']['publishedAt']
    return name, description, trailer, videoCount, publishedAt
  end

  def demographic(opts)
    get_data(opts)
  end

  def views_per_month(opts)
    opts.delete(:dimensions) # VIEWS FOR 1 MONTHS
    opts[:metrics]="views"
    opts['start-date']=$month_ago

    get_data(opts)
  end

  def subscribers(opts)
    opts = Trollop::options do
      opt :metrics, 'Report metrics', :type => String, :default => "subscribersGained,subscribersLost"
      opt 'start-date', 'Start date, in YYYY-MM-DD format', :type => String, :default => $start_data
      opt 'end-date', 'Start date, in YYYY-MM-DD format', :type => String, :default => $one_day_ago
    end
    opts[:ids]="channel==#{$hash_DATA[:channel_id]}"

    analytics_response = $client.execute!(
      :api_method => $youtube_analytics.reports.query,
      :parameters => opts
    )

    gainedSubscribers=analytics_response.data.rows[0][0].to_i
    lostSubscribers=analytics_response.data.rows[0][1].to_i
    subscribers=gainedSubscribers - lostSubscribers
    subscribers
  end

  def get_data(opts)
      analytics_response = $client.execute!(
        :api_method => $youtube_analytics.reports.query,
        :parameters => opts
      )

      str=""
      rows=analytics_response.data.rows
      rows.each do |row|
        row.each do |value|
          str+=value.to_s
          str+="," if rows.last!=row || row.last!=value
        end
      end
      str
    end
end