import { usePage } from '~/composables/page'
import type { CurrentUser } from '~/serializers'

export interface SharedData {
  user: CurrentUser
}

export function useUser () {
  const { props } = $(usePage<SharedData>())
  return {
    user: computed(() => props.user),
  }
}
