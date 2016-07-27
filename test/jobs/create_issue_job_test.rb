require 'test_helper'
class CreateIssueJobTest < ActiveJob::TestCase
  test "#perform" do
    response = CreateIssueJob.new.perform
    assert_equal "201" , response.code
  end
end
