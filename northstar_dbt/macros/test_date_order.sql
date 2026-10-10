
-- Generic test to validate that a comparison date column is chronologically greater than or equal to a base date column.
        
{% test date_order(model, column_name, comparison_column, key_column) %}
    SELECT 
        {{ key_column }} AS failure_record_id,
        {{ column_name }} AS latest_data,
        {{ comparison_column }} AS earlier_date 
    FROM {{ model }}
    WHERE {{ column_name }} < {{ comparison_column }}

{% endtest %}