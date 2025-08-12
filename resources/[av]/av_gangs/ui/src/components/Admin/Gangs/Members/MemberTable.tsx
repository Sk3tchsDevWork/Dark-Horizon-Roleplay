import React from "react";
import { Table } from "@mantine/core";

interface MemberTableProps {
  rows: any;
  lang: any;
}

const MemberTable: React.FC<MemberTableProps> = ({ rows, lang }) => {
  return (
    <Table horizontalSpacing="md" verticalSpacing="xs" layout="fixed">
      <Table.Tbody>
        <Table.Tr>
          <Table.Th w={60}></Table.Th>
          <Table.Th>{lang.members.name}</Table.Th>
          <Table.Th>{lang.members.rank}</Table.Th>
          <Table.Th>{lang.members.joined}</Table.Th>
          <Table.Th>{lang.actions}</Table.Th>
        </Table.Tr>
      </Table.Tbody>
      <Table.Tbody>{rows.length > 0 ? rows : null}</Table.Tbody>
    </Table>
  );
};

export default MemberTable;
