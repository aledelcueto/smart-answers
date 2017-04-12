require_relative "../integration_test_helper"
require_relative "../helpers/fixture_flows_helper"

class StartPageTest < ActionDispatch::IntegrationTest
  include FixtureFlowsHelper

  context "each smart answer start page" do
    should "contain the correct start button text and href" do
      RegisterableSmartAnswers.new.flow_presenters.each do |flow_presenter|
        slug = flow_presenter.slug
        stub_smart_answer_in_content_store(slug)
        text_and_link = button_text_and_link(slug)

        visit "/#{slug}"

        assert_current_url "/#{slug}"
        within '.intro' do
          assert page.has_link?(
            text_and_link[:start_button_text],
            href: text_and_link[:href]
          )
        end
      end
    end
  end
end
