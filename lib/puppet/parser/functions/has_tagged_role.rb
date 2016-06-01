module Puppet::Parser::Functions
  newfunction(:has_tagged_role, :type => :rvalue ) do |args|
    raise ArgumentError, 'Wrong number of arguments (requires 2)' if args.length != 2
    raise ArgumentError, 'Wrong argument type for tag (string)' unless args[0].class == String
    raise ArgumentError, 'Wrong argument type for role (string)' unless args[1].class == String
    tag = args[0]
    role = args[1]
    lookupvar("ec2_tag_#{tag}").split(',').include?(role)
  end
end
