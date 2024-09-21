import { Drawer as MantineDrawer, DrawerProps, NavLink } from "@mantine/core";
import RouterNavLink from "./RouterNavLink.tsx";

const Drawer = (props: DrawerProps) => {
  return (
    <MantineDrawer
      position="right"
      overlayProps={{ backgroundOpacity: 0.5, blur: 4 }}
      {...props}
    >
      <RouterNavLink href="#my-lists" label="My Lists" />
      <RouterNavLink href="#claimed-items" label="Claimed items" />
      <RouterNavLink href="#following" label="Following" />
      <RouterNavLink href="#gift-ideas" label="Gift Ideas" />
      <RouterNavLink href="#account-settings" label="Account Settings" />
      <NavLink href="/logout" label="Logout" />
      <RouterNavLink href="#faqs" label="FAQs" />
      <RouterNavLink href="#poop" label="Test" />
      <RouterNavLink href="#contact-us" label="Contact Us" />
      <RouterNavLink href="#support" label="Support" />
      <RouterNavLink href="#invite-friends" label="Invite Friends" />
    </MantineDrawer>
  );
};

export default Drawer;
