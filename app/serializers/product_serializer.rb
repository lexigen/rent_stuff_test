class ProductSerializer
  include JSONAPI::Serializer

  attributes :available, :total

  attribute :available do |object, params|
    object.available(params)
  end

  attribute :total, &:quantity
end
