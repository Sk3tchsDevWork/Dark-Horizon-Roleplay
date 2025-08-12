import React from 'react';
import { Table, UnstyledButton, Group, Text, Center } from '@mantine/core';
import { IconSelector, IconChevronDown, IconChevronUp } from '@tabler/icons-react';
import classes from './memberStyle.module.css';

interface ThProps {
  children: React.ReactNode;
  reversed: boolean;
  sorted: boolean;
  onSort(): void;
}

const Th = ({ children, reversed, sorted, onSort }:ThProps) => {
  const Icon = sorted ? (reversed ? IconChevronUp : IconChevronDown) : IconSelector;
  return (
    <Table.Th className={classes.th}>
      <UnstyledButton onClick={onSort} className={classes.control}>
        <Group justify="space-between">
          <Text fw={500} fz="sm">
            {children}
          </Text>
          <Center className={classes.icon}>
            <Icon style={{ width: '16px', height: '16px' }} stroke={1.5} />
          </Center>
        </Group>
      </UnstyledButton>
    </Table.Th>
  );
};

export default Th;
