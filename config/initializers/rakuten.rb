RakutenWebService.configure do |c|
  #楽天アプリケーションID(キーはgitにあげたくないので.envファイルへ)
  c.application_id = ENV['RWS_APPLICATION_ID']
end