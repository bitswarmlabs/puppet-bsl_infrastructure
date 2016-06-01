module Puppet::Parser::Functions
  newfunction(:get_tag, :type => :rvalue ) do |args|
    raise ArgumentError, 'Wrong number of arguments (requires 1)' if args.length != 1
    raise ArgumentError, 'Wrong argument type for tag (string)' unless args[0].class == String
    tag = args[0]
    lookupvar("ec2_tag_#{tag}")
  end
end
