class Log
  include Mongoid::Document

  field :ip, type: String
  field :path, type: String
end