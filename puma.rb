#!/usr/bin/env puma
# frozen_string_literal: true

threads_count = 6

threads threads_count, threads_count

port 8080

workers 2
