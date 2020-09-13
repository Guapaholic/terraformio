const { handler } = require('..')

describe('handler', () => {
  it('returns statusCode, name, and boatId', async () => {
    const result = await handler({ foo: 'bar' }, { fiz: 'baz' })

    expect(result.statusCode).toEqual(200)
    expect(JSON.parse(result.body)).toEqual(
      expect.objectContaining({
        name: expect.any(String),
        boatId: expect.any(String),
      }),
    )
  })
})
