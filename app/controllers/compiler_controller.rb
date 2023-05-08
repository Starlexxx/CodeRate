# frozen_string_literal: true

class CompilerController < ApplicationController
  def execute; end

  def submit_code
    params.merge!(source: :compiler_controller).permit!

    @response = RemoteCodeCompiler.call(params)
  end
end
