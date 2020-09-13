exports.handler = (event, context) => {
  console.log('Event received!', event)
  console.log('This is the context', context)
  return Promise.resolve({
    statusCode: 200,
    body: JSON.stringify({
      name: 'julian',
      boatId: '12345',
    })
  });
}
