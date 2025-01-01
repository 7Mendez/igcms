import 'datatables.net';
import $ from 'jquery';

document.addEventListener('DOMContentLoaded', () => {
  $('#simpleDataTable').DataTable({
    paging: false,
    searching: false,
    ordering: true,
    lengthChange: false,
    layout: {
      bottomStart: null,
    },
  });
});
