function addressAutocomplete() {
  const addressInput = document.getElementById('event_address');
  const filterAddressInput = document.getElementById('filter_city');
  if (addressInput) {
    const autocomplete = new google.maps.places.Autocomplete(addressInput);
  } else if (filterAddressInput) {
    // const autocomplete = new google.maps.places.Autocomplete(filterAddressInput, { types: ['(cities)'] })
  }
}

export { addressAutocomplete };
