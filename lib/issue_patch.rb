require_dependency 'issue'

module IssuePatch
  def self.included(base)
    base.class_eval do
      safe_attributes 'spent_time_last_month'
      safe_attributes 'spent_time_this_month'

      def spent_time_last_month
        time_entries.where("spent_on >= ? AND spent_on < ?", 1.month.ago.beginning_of_month, 1.month.ago.end_of_month).exists?
      end
      def spent_time_this_month
        time_entries.where("spent_on >= ? AND spent_on < ?", Date.today.beginning_of_month, Date.today.end_of_month).exists?
      end
    end
  end
end

Issue.include IssuePatch
