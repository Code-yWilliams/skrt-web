import { NavLink, NavLinkProps } from "@mantine/core";
import { Link } from "@tanstack/react-router";

interface RouterNavLinkProps extends NavLinkProps {
  href: string;
}

const RouterNavLink = ({ href, ...props }: RouterNavLinkProps) => {
  return <NavLink component={Link} to={href} {...props} />;
};

export default RouterNavLink;
