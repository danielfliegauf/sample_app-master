# Be sure to restart your server when you modify this file.

# Add new mime types for use in respond_to blocks:
# Mime::Type.register "text/richtext", :rtf
Mime::Type.register_alias "text/html", :mobile

# tell Rack (and Sprockets) about modern font MIME types:
Rack::Mime::MIME_TYPES['.woff'] = 'application/x-font-woff'

Rack::Mime::MIME_TYPES['.ttf'] = 'font/truetype'
Rack::Mime::MIME_TYPES['.otf'] = 'font/opentype'
Rack::Mime::MIME_TYPES['.eot'] = 'application/vnd.ms-fontobject'
