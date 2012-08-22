#!/usr/bin/env ruby
require 'net/imap'

source = Net::IMAP.new('imap.duke.edu')
p source
source.capability
source.authenticate('LOGIN','aks35','6EF81ba8c2')
