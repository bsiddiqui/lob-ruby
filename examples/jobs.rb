$:.unshift File.expand_path("../lib", File.dirname(__FILE__))
require 'lob'

# initialize Lob object
Lob.api_key = 'test_0dc8d51e0acffcb1880e0f19c79b2f5b0cc'
@lob = Lob.load

# find the setting_id for the object you want to create
settings = @lob.settings.list
setting_index = settings.find_index { |setting| setting["type"] === "documents" }
setting_id = settings[setting_index]["id"]

# create a file object to user later
michigan_logo = @lob.objects.create(
  name: "Michigan Logo Document",
  file: "https://www.lob.com/goblue.pdf",
  setting_id: setting_id
)

# create a to address
to_address = @lob.addresses.create(
  name: "ToAddress",
  address_line1: "120 6th Ave",
  city: "Boston",
  state: "MA",
  country: "US",
  zip: 12345
)

# create a from address
from_address = @lob.addresses.create(
  name: "FromAddress",
  address_line1: "120 6th Ave",
  city: "Boston",
  state: "MA",
  country: "US",
  zip: 12345
)


# send the object you created
puts @lob.jobs.create(
  name: "Michigan Logo to Harry",
  to: to_address["id"],
  from: from_address["id"],
  objects: michigan_logo["id"]
)
