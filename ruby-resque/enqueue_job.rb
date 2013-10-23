#!/usr/bin/env ruby

require_relative "./worker.rb"

Resque.enqueue Worker