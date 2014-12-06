require "json"
require "run_keeper"
require "sinatra"
require 'dotenv'
Dotenv.load

configure do
  set :runkeeper, RunKeeper.new(
    ENV["RUNKEEPER_CLIENT_ID"],
    ENV["RUNKEEPER_CLIENT_SECRET"],
    ENV["RUNKEEPER_PERSONAL_TOKEN"]
  )
end

get '/' do
  send_file File.expand_path('index.html', settings.public_folder)
end

get '/data.json' do
  @activities = settings.runkeeper.fitness_activities
  # We don't care about non-running activities for now
  @activities.delete_if { |a| a.type != "Running" }
  @events = @activities.map { |run|
    # total distance is in meters, this is america
    # i'm joking please don't send me emails ugh
    distance = (run.total_distance * 0.000621371).round(2)
    time_string = run.start_time.to_date.to_s
    {
      distance: distance,
      time: run.start_time,
      time_string: time_string,
      duration: run.duration / 60.0,
      pace: ((run.duration / 60.0) / distance)
    }
  }

  # these could be fixed up and sent based on query params to get
  # more specific views

  # @by_year  = @events.group_by { |e| e[:time].strftime("%Y") }.to_a
  # @by_month = @events.group_by { |e| e[:time].strftime("%m") }.to_a
  # @by_week  = @events.group_by { |e| e[:time].strftime("%U") }.to_a
  # @by_day   = @events.group_by { |e| e[:time].strftime("%j") }.to_a

  @events.sort_by! { |e| e[:time] }
  content_type :json

  # we send this as
  # [
  #   ["x", "2014-01-01", "2014-02-02"],
  #   ["pace", "1.234"]
  # ]
  # to appeal our c3.js overlords, if i was more patient i'd send the actual
  # objects in @events
  [@events.map { |e| e[:time_string] }.unshift("x"), @events.map { |e| e[:pace] }.unshift("pace")].to_json
end

