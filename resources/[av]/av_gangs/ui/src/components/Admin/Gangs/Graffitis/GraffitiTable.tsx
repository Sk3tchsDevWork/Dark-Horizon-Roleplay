import React from "react";
import { Table } from "@mantine/core";

interface MemberTableProps {
  rows: any;
  lang: any;
}

const GraffitiTable: React.FC<MemberTableProps> = ({ rows, lang }) => {
  return (
    <Table
      horizontalSpacing="md"
      verticalSpacing="xs"
      layout="fixed"
      withRowBorders={false}
    >
      <Table.Tbody>
        <Table.Tr>
          <Table.Th>{lang.location}</Table.Th>
          <Table.Th>{lang.properties.actions}</Table.Th>
        </Table.Tr>
      </Table.Tbody>
      <Table.Tbody>{rows.length > 0 ? rows : null}</Table.Tbody>
    </Table>
  );
};

export default GraffitiTable;
