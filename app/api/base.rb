class Base < Grape::API
  mount Base::V1

  add_swagger_documentation
end