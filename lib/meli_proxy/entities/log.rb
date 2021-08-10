class Log
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  field :ip, type: String
  field :path, type: String
end