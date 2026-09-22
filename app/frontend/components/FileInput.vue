<script setup lang="ts">
const {
  label = undefined,
  accept = undefined,
  errors = [],
} = defineProps<{
  label?: string
  accept?: string
  errors?: string[]
}>()
const model = defineModel<File | null>({ default: null })
const file = useTemplateRef<HTMLInputElement>('file')

watch(() => model.value, (value) => {
  if (!value && file.value) file.value.value = ''
})

function filesize (size: number) {
  const index = Math.floor(Math.log(size) / Math.log(1024))
  return `${(size / 1024 ** index).toFixed(2)} ${['B', 'kB', 'MB', 'GB', 'TB'][index]}`
}

function browse () {
  file.value?.click()
}

function change (event: Event) {
  const input = event.target as HTMLInputElement
  model.value = input.files?.[0] ?? null
}

function remove () {
  model.value = null
}
</script>

<template>
  <div>
    <label
      v-if="label"
      class="form-label"
    >{{ label }}:</label>
    <div
      class="form-input !p-0"
      :class="{ error: errors.length }"
    >
      <input
        ref="file"
        type="file"
        :accept="accept"
        class="hidden"
        @change="change"
      >
      <div
        v-if="!model"
        class="p-2"
      >
        <button
          type="button"
          class="px-4 py-1 bg-gray-700 hover:bg-gray-700 rounded-sm text-xs font-medium text-white"
          @click="browse"
        >
          Browse
        </button>
      </div>
      <div
        v-else
        class="flex items-center justify-between p-2"
      >
        <div class="flex-1 pr-1">
          {{ model.name }} <span class="text-gray-600 text-xs">({{ filesize(model.size) }})</span>
        </div>
        <button
          type="button"
          class="px-4 py-1 bg-gray-700 hover:bg-gray-700 rounded-sm text-xs font-medium text-white"
          @click="remove"
        >
          Remove
        </button>
      </div>
    </div>
    <div
      v-if="errors.length"
      class="form-error"
    >
      {{ errors[0] }}
    </div>
  </div>
</template>
