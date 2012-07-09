require_relative '../test_helper'

class SmartAnswerPresenterTest < ActionController::TestCase
  def setup
    @request = mock
    @request.stubs(:params).returns({})
    @flow = mock
    @presenter = SmartAnswerPresenter.new(@request, @flow)
  end

  def setup_artefact_mocks(params={})
    @flow.stubs(:name).returns(:sample)
    @presenter.expects(:fetch_artefact).with(slug: :sample).returns(params[:artefact] || :my_artefact)
  end

  should "retrieve the proposition name when business" do
    artefact = mock
    artefact.stubs(:business_proposition).returns(true)
    setup_artefact_mocks(artefact: artefact)
    assert_equal "business", @presenter.proposition
  end

  should "retrieve the proposition name when citizen" do
    artefact = mock
    artefact.stubs(:business_proposition).returns(false)
    setup_artefact_mocks(artefact: artefact)
    assert_equal "citizen", @presenter.proposition
  end
end