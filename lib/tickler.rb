require 'webmachine'

Webmachine::Dispatcher.add_route(['tickle'], FunnyBone)
Webmachine.run
