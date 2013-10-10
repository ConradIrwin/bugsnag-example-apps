#!/usr/bin/env ruby

require_relative "./my_worker.rb"

Resque.enqueue MyWorker