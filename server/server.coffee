geo = new GeoCoder
  "geocoderProvider": "google"
  "extra.apiKey": "AIzaSyCO_NvDDs6yqtWOiQS4ZFHWJquK_jjh2pM"
  "extra.clientId": "babbata@gmail.com"

i = 0
storeLocation = (item) ->
  Meteor.setTimeout ->
    geo.geocode "#{item.address}, #{item.city}", (err, data) ->
      if err
        console.log err
      else
        console.log data
        if data?.length > 0
          res = _.extend(item, _.pick(data[0], 'latitude', 'longitude'))
          Dentals.insert res
        else
          console.log 'No results found for', item
  , 500 + i++ * 500

Meteor.startup ->
  if Dentals.find().count() == 0
    data = EJSON.parse Assets.getText('data.json')
    _.each data, storeLocation
