defmodule ErmWeb.InputHelpers do
  use Phoenix.HTML

  def array_add_button(form, field) do
    id = Phoenix.HTML.Form.input_id(form, field) <> "_container"
    data = [
      blueprint: create_li(form, field, [value: "", index: "index_holder"]) |> safe_to_string(),
      container: id
    ]
    link("Add", to: "#", data: data, title: "add", class: "add-array-item")
  end

  def array_input(form, field) do
    id = Phoenix.HTML.Form.input_id(form, field) <> "_container"
    values = Phoenix.HTML.Form.input_value(form, field) || [""]
    content_tag :ol, id: id, class: "input_container" do
      for {value, i} <- Enum.with_index(values) do
        input_opts = [
          value: value,
          id: nil,
          index: i
        ]
        create_li(form, field, input_opts, [index: i])
      end
    end
  end

  def create_li(form, field, input_opts \\ [], data \\ []) do
    type = Phoenix.HTML.Form.input_type(form, field)
    index = Keyword.get(input_opts, :index) || 0
    lat = Phoenix.HTML.Form.input_name(form, field) <> "[#{index}][lat]"
    lat_opts = Keyword.put_new(input_opts, :name, lat)
    long = Phoenix.HTML.Form.input_name(form, field) <> "[#{index}][long]"
    long_opts = Keyword.put_new(input_opts, :name, long)
    content_tag :li do
      [
        apply(Phoenix.HTML.Form, type, [form, field, lat_opts]),
        apply(Phoenix.HTML.Form, type, [form, field, long_opts]),
        link("Remove", to: "#", data: data, title: "Remove", class: "remove-array-item")
      ]
    end

  end

  def content_li(form, field, input_opts \\ [], data \\ []) do
    type = Phoenix.HTML.Form.input_type(form, field)
    name = Phoenix.HTML.Form.input_name(form, field) <> "[key_placeholder]"
    name_opts = Keyword.put_new(input_opts, :name, name)
    content_tag :li do
      [
        label(form, :name, "key_placeholder"),
        apply(Phoenix.HTML.Form, type, [form, field, name_opts]),
        link("Remove", to: "#", data: data, title: "Remove", class: "remove-content-item")
      ]
    end

  end

  def content_input(form, field) do
    id = Phoenix.HTML.Form.input_id(form, field) <> "_container"
    content_tag :ol, id: id, class: "content_container" do

    end
  end

  def content_add_button(form, field) do
    type = Phoenix.HTML.Form.input_type(form, field)
    name = Phoenix.HTML.Form.input_name(form, field) <> "_key"

    input_opts = [
      id: name,
      placeholder: "Name of key to add",
      name: name
    ]

    #name_opts = Keyword.put_new(input_data, :name, name)

    id = Phoenix.HTML.Form.input_id(form, field) <> "_container"
    data = [
      blueprint: content_li(form, field, [value: "", index: "index_holder"]) |> safe_to_string(),
      container: id,
      input: name
    ]

    content_tag :ul do
      [
        apply(Phoenix.HTML.Form, type, [form, field, input_opts]),
        link("Add", to: "#", data: data, title: "add", class: "add-content-item")
      ]
    end
  end
end
