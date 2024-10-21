{%- macro calendar_key(calendar_date, column_alias = none) -%}
    {{ return(adapter.dispatch('calendar_key')(calendar_date, column_alias)) }}
{%- endmacro -%}
