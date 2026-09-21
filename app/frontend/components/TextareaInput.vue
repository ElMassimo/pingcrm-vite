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
const model = defineModel<string>({ required: true })
const uid = useId()
const input = useTemplateRef<HTMLTextAreaElement>('input')
const inputId = $computed(() => id || `textarea-input-${uid}`)

function updateModelValue (event: Event) {
  model.value = (event.target as HTMLTextAreaElement).value
}

defineExpose({
  focus: () => input.value?.focus(),
  select: () => input.value?.select(),
})
</script>

<template>
  <div :class="$attrs.class">
    <label
      v-if="label"
      class="form-label"
      :for="inputId"
    >{{ label }}:</label>
    <textarea
      :id="inputId"
      ref="input"
      v-bind="{ ...$attrs, class: null }"
      class="form-textarea"
      :class="{ error: errors.length }"
      :value="model"
      @input="updateModelValue"
    />
    <div
      v-if="errors.length"
      class="form-error"
    >
      {{ errors[0] }}
    </div>
  </div>
</template>
