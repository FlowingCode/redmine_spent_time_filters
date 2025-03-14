# Spent Time Filters

**Spent Time Filters** is a Redmine plugin that adds two new boolean filters to the issues view:
- **Spent Time Last Month**: Indicates whether the issue has logged time in the previous month.
- **Spent Time This Month**: Indicates whether the issue has logged time in the current month.

These filters allow users to filter issues based on whether they have time entries within the specified periods, making it easier to track and analyze logged work.

## Installation

1. **Clone the repository into Redmine's plugins folder:**
   ```sh
   cd /path/to/redmine/plugins
   git clone https://github.com/flowingcode/redmine-spent-time-filters.git
   ```

2. **Restart Redmine to apply the changes:**
   ```sh
   cd /path/to/redmine
   bundle exec rails server -e production
   ```
   If you are using Docker, restart the Redmine container:
   ```sh
   docker-compose restart redmine
   ```

## Usage

1. Go to the **Issues** section in Redmine.
2. In the filter bar, select **Add filter**.
3. Find the **Spent Time Last Month** or **Spent Time This Month** filters and add them.
4. Configure the filters as needed (**Yes** to show issues with logged time, **No** for those without).
5. Optionally, you can add these columns in the issues view to display the values for each issue.

## Author

Developed by [Flowing Code](https://www.flowingcode.com).

