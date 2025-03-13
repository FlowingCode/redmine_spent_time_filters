require_dependency 'query'

module IssueQueryPatch
  def self.included(base)
    base.class_eval do
      alias_method :available_filters_without_spent_time_last_month, :available_filters

      def available_filters
        filters = available_filters_without_spent_time_last_month
        filters['spent_time_last_month'] = QueryFilter.new(
          :spent_time_last_month,
          type: :list,
          values: [[l(:general_text_yes), "1"], [l(:general_text_no), "0"]],
          name: l(:field_spent_time_last_month))
        filters
      end

      alias_method :available_filters_without_spent_time_this_month, :available_filters

      def available_filters
        filters = available_filters_without_spent_time_this_month
        filters['spent_time_this_month'] = QueryFilter.new(
          :spent_time_this_month,
          type: :list,
          values: [[l(:general_text_yes), "1"], [l(:general_text_no), "0"]],
          name: l(:field_spent_time_this_month))
        filters
      end

      def sql_for_spent_time_last_month_field(field, operator, value)
        subquery = <<-SQL
          EXISTS (
            SELECT 1 FROM time_entries
            WHERE time_entries.issue_id = issues.id
            AND time_entries.spent_on >= '#{1.month.ago.beginning_of_month}'
            AND time_entries.spent_on <= '#{1.month.ago.end_of_month}'
          )
        SQL

        case operator
        when '='
          value.include?('1') ? subquery : "NOT #{subquery}"
        else
          "1=0" # No match
        end
      end

      def sql_for_spent_time_this_month_field(field, operator, value)
        subquery = <<-SQL
          EXISTS (
            SELECT 1 FROM time_entries
            WHERE time_entries.issue_id = issues.id
            AND time_entries.spent_on >= '#{Date.today.beginning_of_month}'
            AND time_entries.spent_on <= '#{Date.today.end_of_month}'
          )
        SQL

        case operator
        when '='
          value.include?('1') ? subquery : "NOT #{subquery}"
        else
          "1=0" # No match
        end
      end

      available_columns << QueryColumn.new(
        :spent_time_last_month,
        caption: l(:field_spent_time_last_month),
        sortable: false,
        groupable: false
      ) unless available_columns.any? { |c| c.name == :spent_time_last_month }

      available_columns << QueryColumn.new(
        :spent_time_this_month,
        caption: l(:field_spent_time_this_month),
        sortable: false,
        groupable: false
      ) unless available_columns.any? { |c| c.name == :spent_time_this_month }
    end
  end
end

IssueQuery.include IssueQueryPatch
