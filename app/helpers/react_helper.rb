module ReactHelper
  def react_component(name, props = {}, &block)
    target = content_tag(:div, '', data: { componentId: name, reactProps: props }, &block)
    javascript = vite_typescript_tag(name)
    target + javascript
  end
end
