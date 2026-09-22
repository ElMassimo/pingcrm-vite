<script setup lang="ts">
defineOptions({ inheritAttrs: false })

const {
  id = undefined,
  type = 'text',
  label = undefined,
  errors = [],
} = defineProps<{
  id?: string
  type?: string
  label?: string
  errors?: string[]
}>()
const model = defineModel<string | null>({ default: null })
const uid = useId()
const input = useTemplateRef<HTMLInputElement>('input')
const inputId = $computed(() => id || `text-input-${uid}`)

function updateModelValue (event: Event) {
  model.value = (event.target as HTMLInputElement).value
}

defineExpose({
  focus: () => input.value?.focus(),
  select: () => input.value?.select(),
  setSelectionRange: (start: number, end: number) => input.value?.setSelectionRange(start, end),
})
</script>

<template>
  <div :class="$attrs.class">
    <label
      v-if="label"
      class="form-label"
      :for="inputId"
    >{{ label }}:</label>
    <input
      :id="inputId"
      ref="input"
      v-bind="{ ...$attrs, class: null }"
      class="form-input"
      :class="{ error: errors.length }"
      :type="type"
      :value="model"
      @input="updateModelValue"
    >
    <div
      v-if="errors.length"
      class="form-error"
    >
      {{ errors[0] }}
    </div>
  </div>
</template>
