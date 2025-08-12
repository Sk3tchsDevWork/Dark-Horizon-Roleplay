import React from "react";
import { Table } from "@mantine/core";
import Th from "./Th";
import { Member } from "../../../types/types";

interface MemberTableProps {
  sortBy: keyof Member | null;
  reverseSortDirection: boolean;
  setSorting: (field: keyof Member) => void;
  rows: any;
  lang: any;
}

const MemberTable: React.FC<MemberTableProps> = ({
  sortBy,
  reverseSortDirection,
  setSorting,
  rows,
  lang,
}) => {
  return (
    <Table horizontalSpacing="md" verticalSpacing="xs" layout="fixed">
      <Table.Tbody>
        <Table.Tr>
          <Table.Th w={60}></Table.Th>
          <Th
            sorted={sortBy === "name"}
            reversed={reverseSortDirection}
            onSort={() => setSorting("name")}
          >
            {lang.members.name}
          </Th>
          <Th
            sorted={sortBy === "rank"}
            reversed={reverseSortDirection}
            onSort={() => setSorting("rank")}
          >
            {lang.members.rank}
          </Th>
          <Th
            sorted={sortBy === "joined"}
            reversed={reverseSortDirection}
            onSort={() => setSorting("joined")}
          >
            {lang.members.joined}
          </Th>
          <Table.Th>{lang.actions}</Table.Th>
        </Table.Tr>
      </Table.Tbody>
      <Table.Tbody>{rows.length > 0 ? rows : null}</Table.Tbody>
    </Table>
  );
};

export default MemberTable;
