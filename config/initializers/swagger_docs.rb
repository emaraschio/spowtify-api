Swagger::Docs::Config.base_api_controller = ActionController::API
Swagger::Docs::Config.register_apis({
  "1.0" => {
    :api_file_path => "public/",
    :base_path => "http://localhost:3000",
    :clean_directory => true,
    :base_api_controller => ActionController,
    :attributes => {
      :info => {
        "title" => "Spowtify API",
        "description" => "Spowtify API with Rails 5.1",
        "license" => "Apache 2.0",
        "licenseUrl" => "http://www.apache.org/licenses/LICENSE-2.0.html"
      }
    }
  }
})