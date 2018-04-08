# frozen_string_literal: true
Time::DATE_FORMATS[:default] = ->(time) { time.iso8601(6) }
