import { createFileRoute, Outlet } from "@tanstack/react-router";
import { AppShell, Drawer, Skeleton } from "@mantine/core";
import { useDisclosure } from "@mantine/hooks";
import Header from "@components/Header/index.tsx";

const AppLayout = () => {
  const [opened, { toggle, close }] = useDisclosure();

  return (
    <AppShell header={{ height: 60 }} padding="md">
      <Header navBarOpened={opened} onBurgerClick={toggle} />
      <Drawer
        opened={opened}
        onClose={close}
        position="right"
        overlayProps={{ backgroundOpacity: 0.5, blur: 4 }}
      >
        {Array(15)
          .fill(0)
          .map((_, index) => (
            <Skeleton key={index} h={28} mt="sm" animate={false} />
          ))}
      </Drawer>

      <AppShell.Main>
        <Outlet />
      </AppShell.Main>
    </AppShell>
  );
};

export const Route = createFileRoute("/app/_layout")({
  component: AppLayout,
});
