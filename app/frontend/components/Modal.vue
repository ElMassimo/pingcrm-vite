<script setup lang="ts">
const {
  open = false,
  title = undefined,
} = defineProps<{
  open?: boolean
  title?: string
}>()
const emit = defineEmits<{ close: [] }>()

let showModal = $ref(false)
let showBackdrop = $ref(false)
let showContent = $ref(false)
let backdropLeaving = $ref(false)
let cardLeaving = $ref(false)
const leaving = $computed(() => backdropLeaving || cardLeaving)

watch(() => open, value => value ? show() : close(), { immediate: true })
watch(() => leaving, (isLeaving) => {
  if (!isLeaving) {
    showModal = false
    emit('close')
  }
})

function show () {
  showModal = true
  showBackdrop = true
  showContent = true
  if (!import.meta.env.SSR) document.body.style.setProperty('overflow', 'hidden')
}

function close () {
  showBackdrop = false
  showContent = false
  if (!import.meta.env.SSR) document.body.style.removeProperty('overflow')
}

function onEscape (event: KeyboardEvent) {
  if (open && event.key === 'Escape') close()
}

onMounted(() => document.addEventListener('keydown', onEscape))
onUnmounted(() => document.removeEventListener('keydown', onEscape))
</script>

<!-- Source: https://github.com/adamwathan/vue-tailwind-examples -->

<template>
  <Teleport to="#modals">
    <div
      v-if="showModal"
      class="fixed inset-0"
    >
      <Transition
        enter-active-class="transition-all transition-fast ease-out-quad"
        leave-active-class="transition-all transition-medium ease-in-quad"
        enter-class="opacity-0"
        enter-to-class="opacity-100"
        leave-class="opacity-100"
        leave-to-class="opacity-0"
        appear
        @before-leave="backdropLeaving = true"
        @after-leave="backdropLeaving = false"
      >
        <div v-if="showBackdrop">
          <div class="fixed inset-0 bg-black opacity-50" />
        </div>
      </Transition>

      <Transition
        enter-active-class="transition-all transition-fast ease-out-quad"
        leave-active-class="transition-all transition-medium ease-in-quad"
        enter-class="opacity-0 scale-70"
        enter-to-class="opacity-100 scale-100"
        leave-class="opacity-100 scale-100"
        leave-to-class="opacity-0 scale-70"
        appear
        @before-leave="cardLeaving = true"
        @after-leave="cardLeaving = false"
      >
        <div
          v-if="showContent"
          class="relative h-full overflow-y-auto text-center"
          @click="close"
        >
          <div class="absolute inline-block align-middle w-0 h-screen" />

          <div
            class="inline-block align-middle text-left my-6 rounded overflow-hidden"
            @click.stop
          >
            <div class="px-8 py-4 bg-gray-100 border-b border-gray-200 flex justify-between items-center">
              <h1 class="font-bold text-xl">
                {{ title }}
              </h1>

              <button
                type="button"
                class="p-1 rounded hover:bg-gray-300"
                title="Close"
                @click="close"
              >
                <svg
                  xmlns="http://www.w3.org/2000/svg"
                  class="w-4 h-4"
                  viewBox="0 0 20 20"
                >
                  <path d="M10 8.59L2.93 1.51 1.51 2.93 8.59 10l-7.08 7.07 1.42 1.42L10 11.41l7.07 7.08 1.42-1.42L11.41 10l7.08-7.07-1.42-1.42L10 8.59z" />
                </svg>
              </button>
            </div>

            <slot />
          </div>
        </div>
      </Transition>
    </div>
  </Teleport>
</template>
