module Tableless
  class TimeInterval
    include ActiveAttr::Attributes
    include ActiveAttr::BasicModel

    attribute :from
    attribute :till

    validates_datetime :from
    validates_datetime :till
    validates_datetime :till, after: :from
  end
end
