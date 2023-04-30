% README.md

# Task

As a middle Ruby developer, your task is to develop a domain-specific language (DSL) for generating HTML tables.

The DSL should allow users to easily create HTML tables without the need for extensive knowledge of HTML syntax.

The DSL should support the following features:

1. Creating a table with a specified number of rows and columns
2. Setting the table's width and height
3. Specifying the table's border and cellpadding values
4. Adding headers to the table
5. Adding data to the table
6. Styling the table, headers, and data cells with CSS classes

To complete the task, you will need to write a Ruby module that defines the DSL and a set of tests to ensure that the DSL is working correctly. The DSL should be easy to use and read, with clear and concise syntax.

Note: You can use any Ruby libraries or frameworks you feel are necessary to complete the task. Please don't use chat gpt for code writing.

Deliver your code via any git repository.

# Example  

You can see my solution [here](lib/html_table_dsl.rb)

```ruby
require "./lib/html_table_dsl"

HTMLTableDSL::DSL.() do
  width '200px'
  height '100%'
  cellpadding top: '15px'
  border '1px solid black', collapse: 'collapse'

  tr class: 'yellow' do
    th '1'
    th '2'
    th '3'
  end
  tr do
    td '0', class: 'red'
    td 'X'
    td '0'
  end
  tr do
    td 'X'
    td '0', class: 'red'
    td 'X'
  end
  tr do
    td '0'
    td 'X'
    td '0', class: 'red'
  end
end
```

will produce the following output

```html
<style>
  tr, th {
    padding-top: 15px;
  }
  table, th, td {
    border-collapse: collapse;
    border: 1px solid black;
  }
</style>
<table width="200px" height="100%">
  <tr class="yellow">
    <th>
      1
    </th>
    <th>
      2
    </th>
    <th>
      3
    </th>
  </tr>
  <tr>
    <td class="red">
      0
    </td>
    <td>
      X
    </td>
    <td>
      0
    </td>
  </tr>
  <tr>
    <td>
      X
    </td>
    <td class="red">
      0
    </td>
    <td>
      X
    </td>
  </tr>
  <tr>
    <td>
      0
    </td>
    <td>
      X
    </td>
    <td class="red">
      0
    </td>
  </tr>
</table> 
```
