import { mapValues } from 'lodash-es'
export { omit, pickBy as clean, throttle } from 'lodash-es'

export function reset (value: any) {
  return mapValues(value, () => null)
}
