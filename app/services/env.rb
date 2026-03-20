module Env
  # Public: Read an environment variable by name.
  # NOTE: Defaults are only used in the development and test environments.
  def self.require(*args, &block)
    if Rails.env.local?
      ENV.fetch(*args, &block)
    else
      ENV.fetch(args.first, nil)
    end
  end
end
