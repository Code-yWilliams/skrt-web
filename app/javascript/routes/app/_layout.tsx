import { createFileRoute, Outlet } from "@tanstack/react-router";
import { AppShell } from "@mantine/core";
import { useDisclosure } from "@mantine/hooks";
import Header from "@components/Header/index.tsx";
import Drawer from "@components/Drawer.tsx";

const AppLayout = () => {
  const [opened, { toggle, close }] = useDisclosure();

  return (
    <AppShell header={{ height: 60 }} padding="md">
      <Header navBarOpened={opened} onBurgerClick={toggle} />
      <Drawer opened={opened} onClose={close} />

      <AppShell.Main>
        <Outlet />
      </AppShell.Main>
    </AppShell>
  );
};

export const Route = createFileRoute("/app/_layout")({
  component: AppLayout,
});
