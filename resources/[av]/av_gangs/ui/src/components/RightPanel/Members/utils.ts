import { Member } from '../../../types/types';

export function filterData(data: Member[], search: string): Member[] {
  const query = search.toLowerCase().trim();
  return data.filter((item) =>
    (Object.keys(item) as Array<keyof Member>).some((key) =>
      item[key].toString().toLowerCase().includes(query)
    )
  );
}

export function sortData(
  data: Member[],
  payload: { sortBy: keyof Member | null; reversed: boolean; search: string }
): Member[] {
  const { sortBy, reversed } = payload;

  if (!sortBy) {
    return filterData(data, payload.search);
  }

  return filterData(
    [...data].sort((a, b) => {
      let aValue = a[sortBy];
      let bValue = b[sortBy];
      if (typeof aValue === 'number' && typeof bValue === 'number') {
        return reversed ? bValue - aValue : aValue - bValue;
      }
      return reversed
        ? bValue.toString().localeCompare(aValue.toString())
        : aValue.toString().localeCompare(bValue.toString());
    }),
    payload.search
  );
}