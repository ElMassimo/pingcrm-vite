<script setup lang="ts">
defineOptions({ inheritAttrs: false })

const {
  id = undefined,
  label = undefined,
  errors = [],
} = defineProps<{
  id?: string
  label?: string
  errors?: string[]
}>()
const model = defineModel<string | number | boolean | null>({ default: null })
const uid = useId()
const input = useTemplateRef<HTMLSelectElement>('input')
const inputId = $computed(() => id || `select-input-${uid}`)

defineExpose({
  focus: () => input.value?.focus(),
  select: () => input.value?.focus(),
})
</script>

<template>
  <div :class="$attrs.class">
    <label
      v-if="label"
      class="form-label"
      :for="inputId"
    >{{ label }}:</label>
    <select
      :id="inputId"
      ref="input"
      v-model="model"
      v-bind="{ ...$attrs, class: null }"
      class="form-select"
      :class="{ error: errors.length }"
    >
      <slot />
    </select>
    <div
      v-if="errors.length"
      class="form-error"
    >
      {{ errors[0] }}
    </div>
  </div>
</template>
