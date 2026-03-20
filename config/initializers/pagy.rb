# Pagy initializer file
# Customize only what you really need and notice that Pagy works also without any of the following lines.

require 'pagy/extras/metadata'

# For performance reason, you should explicitly set ONLY the metadata you use in the frontend
Pagy::DEFAULT[:metadata] = [:scaffold_url, :count, :page, :prev, :next, :last, :series]

# Instance variables
Pagy::DEFAULT[:limit] = 10
