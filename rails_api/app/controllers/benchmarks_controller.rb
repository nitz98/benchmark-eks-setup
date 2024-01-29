# frozen_string_literal: true

# controller class for benchmarks
class BenchmarksController < ApplicationController
  def index
    i = 0
    i += 1 while i < 1_000_000
    sleep 0.02
    message = 'it works'
    render json: { message: message }
  end
end
