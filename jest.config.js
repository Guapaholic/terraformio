module.exports = {
  roots: ['<rootDir>/functions/src'],
  testMatch: ['<rootDir>/**/__tests__/**/*.(spec|test).js'],
  testPathIgnorePatterns: ['dist'],
  moduleFileExtensions: ['ts', 'tsx', 'js', 'jsx', 'json', 'node'],
  testEnvironment: 'node',
  collectCoverage: true,
  coverageReporters: ['html', 'lcov', 'text', 'text-summary'],
}
