Redmine::Plugin.register :redmine_spent_time_filters do
  name 'Redmine Spent Time Filters plugin'
  author 'Flowing Code'
  description 'Adds support for filtering issues based on spent time loading date'
  version '0.1.0'
  url 'http://github.com/flowingcode/redmine-spent-time-filters'
  author_url 'https://www.flowingcode.com'
end
Rails.application.config.to_prepare do
  require_dependency 'issue_patch'
  require_dependency 'issue_query_patch'
  require File.dirname(__FILE__) + '/lib/issue_patch'
  require File.dirname(__FILE__) + '/lib/issue_query_patch'

  unless Query.available_columns.any? { |c| c.name == :spent_time_last_month }
    Query.add_available_column(
      QueryColumn.new(:spent_time_last_month,
                      caption: l(:field_spent_time_last_month),
                      sortable: false,
                      groupable: false)
    )
  end

  unless Query.available_columns.any? { |c| c.name == :spent_time_this_month }
    Query.add_available_column(
      QueryColumn.new(:spent_time_this_month,
                      caption: l(:field_spent_time_this_month),
                      sortable: false,
                      groupable: false)
    )
  end
end
