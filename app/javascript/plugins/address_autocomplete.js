function addressAutocomplete() {
  const addressInput = document.getElementById('event_address');
  if (addressInput) {
    const autocomplete = new google.maps.places.Autocomplete(addressInput);
  }
}

export { addressAutocomplete };
