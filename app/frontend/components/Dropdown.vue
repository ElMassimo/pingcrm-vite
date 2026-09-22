<script setup lang="ts">
import { createPopper, type Instance, type Placement } from '@popperjs/core'

const {
  placement = 'bottom-end',
  autoClose = true,
} = defineProps<{
  placement?: Placement
  autoClose?: boolean
}>()

const root = useTemplateRef<HTMLButtonElement>('root')
const dropdown = useTemplateRef<HTMLElement>('dropdown')
let show = $ref(false)
let popper: Instance | undefined

watch(() => show, async (isShown) => {
  if (isShown) {
    await nextTick()
    if (root.value && dropdown.value) {
      popper = createPopper(root.value, dropdown.value, {
        placement,
        modifiers: [{ name: 'preventOverflow', options: { altBoundary: true } }],
      })
    }
  }
  else if (popper) {
    setTimeout(() => popper?.destroy(), 100)
  }
})

function onEscape (event: KeyboardEvent) {
  if (event.key === 'Escape') show = false
}

onMounted(() => document.addEventListener('keydown', onEscape))
onUnmounted(() => document.removeEventListener('keydown', onEscape))
</script>

<template>
  <button
    ref="root"
    type="button"
    @click="show = true"
  >
    <slot />
    <Teleport
      v-if="show"
      to="#dropdown"
    >
      <div>
        <div
          style="position: fixed; top: 0; right: 0; left: 0; bottom: 0; z-index: 99998; background: black; opacity: .2"
          @click="show = false"
        />
        <div
          ref="dropdown"
          style="position: absolute; z-index: 99999;"
          @click.stop="show = !autoClose"
        >
          <slot name="dropdown" />
        </div>
      </div>
    </Teleport>
  </button>
</template>
