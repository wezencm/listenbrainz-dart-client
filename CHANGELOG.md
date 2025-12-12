## 1.1.0

- Implements the Recordings endpoints.

- Change in architeture; for simplicity in code, fields that represent a time, will no receive a `int` time anymore, but a `DateTime` type, the lib will take care of conversion.


## 1.0.1

- Corrects the ListenBrainz constructor to accepts a RateLimiter instance.

## 1.0.0

- Initial version.
