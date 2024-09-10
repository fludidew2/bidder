import consumer from "channels/consumer"

consumer.subscriptions.create("BidsChannel", {
  received(data) {
    const requestElement = document.getElementById(`request-${data.request_id}-bids-count`);
    if (requestElement) {
      requestElement.textContent = `${data.count} Bids`;
    }
  }
});