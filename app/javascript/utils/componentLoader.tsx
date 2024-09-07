import React from "react";
import { createRoot } from "react-dom/client";

const componentLoader = async (
  componentId: string,
  component: React.ComponentType<any>
) => {
  const element = document.querySelector(`[data-componentId="${componentId}"]`);
  if (!element) {
    throw new Error(`Element with data attribute ${componentId} not found`);
  }

  const props = JSON.parse(element.getAttribute("data-reactProps") ?? "{}");

  const componentRoot = createRoot(element);
  const Component = React.createElement(component, props);
  componentRoot.render(Component);
};

export default componentLoader;
