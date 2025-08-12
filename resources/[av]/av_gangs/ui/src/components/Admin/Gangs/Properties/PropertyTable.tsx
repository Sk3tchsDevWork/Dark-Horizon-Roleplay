import React from "react";
import { Table } from "@mantine/core";

interface MemberTableProps {
  rows: any;
  lang: any;
}

const PropertyTable: React.FC<MemberTableProps> = ({ rows, lang }) => {
  return (
    <Table horizontalSpacing="md" verticalSpacing="xs" layout="fixed">
      <Table.Tbody>
        <Table.Tr>
          <Table.Th>{lang.properties.name}</Table.Th>
          <Table.Th>{lang.properties.type}</Table.Th>
          <Table.Th>{lang.properties.nextCook}</Table.Th>
          <Table.Th>{lang.properties.upgrades}</Table.Th>
          <Table.Th>{lang.actions}</Table.Th>
        </Table.Tr>
      </Table.Tbody>
      <Table.Tbody>{rows.length > 0 ? rows : null}</Table.Tbody>
    </Table>
  );
};

export default PropertyTable;
