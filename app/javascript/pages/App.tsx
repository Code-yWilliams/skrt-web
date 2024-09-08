import { Autocomplete, Group, Burger, rem } from "@mantine/core";
import { useDisclosure } from "@mantine/hooks";
import { IconSearch } from "@tabler/icons-react";
import classes from "./HeaderSearch.module.css";
import { Drawer } from "@mantine/core";

const links = [
  { link: "/about", label: "Profile" },
  { link: "/pricing", label: "Claimed Items" },
  { link: "/learn", label: "Gift Ideas" },
];

function HeaderSearch() {
  const [opened, { open, close }] = useDisclosure(false);

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
    <>
      <header className={classes.header}>
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
            <Burger opened={opened} onClick={open} size="sm" />
          </Group>
        </div>
      </header>
      <Drawer
        opened={opened}
        onClose={close}
        position="right"
        overlayProps={{ backgroundOpacity: 0.5, blur: 4 }}
      ></Drawer>
    </>
  );
}

export default HeaderSearch;
