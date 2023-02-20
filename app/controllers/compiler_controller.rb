# frozen_string_literal: true

class CompilerController < ApplicationController
  before_action :compiler_params, only: :submit_code

  def execute; end

  def submit_code
    @response = RemoteCodeCompiler.call(params)
  end

  private

  def compiler_params
    params.permit(:lanuage, :sourse_code, :inputs)
  end
end
