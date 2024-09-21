import { AppShell, Autocomplete, Burger, Group, rem } from "@mantine/core";
import { IconSearch } from "@tabler/icons-react";
import classes from "./Header.module.css";

const Header = ({
  navBarOpened,
  onBurgerClick,
}: {
  navBarOpened: boolean;
  onBurgerClick: () => void;
}) => {
  const links = [
    { link: "/about", label: "Profile" },
    { link: "/pricing", label: "Claimed Items" },
    { link: "/learn", label: "Gift Ideas" },
  ];

  const items = links.map((link) => (
    <a
      key={link.label}
      href={link.link}
      className={classes.link}
      onClick={(event) => event.preventDefault()}
    >
      {link.label}
    </a>
  ));

  return (
    <AppShell.Header className={classes.header}>
      <div className={classes.inner}>
        <Group>
          Moldy Sandwich
          <Autocomplete
            className={classes.search}
            placeholder="Find Friends"
            leftSection={
              <IconSearch
                style={{ width: rem(16), height: rem(16) }}
                stroke={1.5}
              />
            }
            data={["Cod", "Em", "Kit", "Jo", "Margul", "Teeb", "Zo"]}
            visibleFrom="xs"
          />
        </Group>

        <Group>
          <Group ml={50} gap={5} className={classes.links} visibleFrom="sm">
            {items}
          </Group>
          <Burger opened={navBarOpened} onClick={onBurgerClick} size="sm" />
        </Group>
      </div>
    </AppShell.Header>
  );
};

export default Header;
