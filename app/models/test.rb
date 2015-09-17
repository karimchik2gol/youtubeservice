#!/usr/bin/ruby

require 'rubygems'
gem 'google-api-client', '>0.7'
require 'google'
require 'google/api_client'
require 'google/api_client/client_secrets'
require 'google/api_client/auth/file_storage'
require 'google/api_client/auth/installed_app'
require 'trollop'
require 'openssl'

OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

# These OAuth 2.0 access scopes allow for read-only access to the authenticated
# user's account for both YouTube Data API resources and YouTube Analytics Data.
YOUTUBE_SCOPES = ['https://www.googleapis.com/auth/youtube.readonly',
  'https://www.googleapis.com/auth/yt-analytics.readonly']
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
  #google_plus = $client.discovered_api(YOUTUBE_GOOGLE_PLUS_API_SERVICE_NAME, YOUTUBE_GOOGLE_PLUS_API_VERSION)

  file_storage = Google::APIClient::FileStorage.new("#{$PROGRAM_NAME}-oauth2.json")
  if true
    client_secrets = Google::APIClient::ClientSecrets.load("client_secrets.json")
    flow = Google::APIClient::InstalledAppFlow.new(
      :client_id => client_secrets.client_id,
      :client_secret => client_secrets.client_secret,
      :scope => YOUTUBE_SCOPES
    )
    $client.authorization = flow.authorize(file_storage)
  else
    $client.authorization = file_storage.authorization
  end


  return youtube, youtube_analytics#, google_plus
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
    $youtube, $youtube_analytics = get_authenticated_services
    channels_response=execute_data_analytic

    ids="#{channels_response.data.items[0].id}"
    opts[:ids] = "channel==#{ids}"

    $hash_DATA[:name], $hash_DATA[:description], $hash_DATA[:trailer], $hash_DATA[:video_count], $hash_DATA[:published_at] = channel_name_and_description_and_trailer(ids)
    $hash_DATA[:channel_id]="#{ids}"
    $hash_DATA[:demographic]=demographic(opts)
    $hash_DATA[:views_per_month]=views_per_month(opts)
    $hash_DATA[:views]=views(opts)
    $hash_DATA[:average_views_per_video]=average_views_per_video
    $hash_DATA[:average_sharing]=average_sharing(opts)
    $hash_DATA[:average_likes]=average_likes(opts)
    $hash_DATA[:average_posted_videos_per_month]=average_posted_videos_per_month
    $hash_DATA[:country]=countries(opts)
    $hash_DATA[:subscribers]=subscribers(opts)



    puts $hash_DATA
  rescue Google::APIClient::TransmissionError => e
    puts e.result.body
  end

end

def countries(opts)
  opts[:dimensions] = 'country'
  opts[:metrics] = 'views'
  get_data(opts)
end

def average_posted_videos_per_month
  time_in_month=(Time.now - $hash_DATA[:published_at]).to_f/(3600*24)
  ($hash_DATA[:video_count].to_i/time_in_month)*30
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

main