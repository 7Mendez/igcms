import 'datatables.net';
import $ from 'jquery';

document.addEventListener('DOMContentLoaded', () => {
  $('#offeringsDataTable').DataTable({
    paging: false,
    searching: false,
    ordering: true,
    lengthChange: false,
    layout: {
      bottomStart: null,
    },
  });
});
