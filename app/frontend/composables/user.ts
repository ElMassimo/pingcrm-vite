import { usePage } from '~/composables/page'
import type { CurrentUser } from '~/serializers'

export interface SharedData {
  user: CurrentUser
  [key: string]: unknown
}

export function useUser () {
  const page = usePage<SharedData>()
  return {
    user: computed(() => page.props.user),
  }
}
