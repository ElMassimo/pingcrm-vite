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
      :value="modelValue"
      @input="$emit('update:modelValue', $event.target.value)"
    >
    <div
      v-if="errors.length"
      class="form-error"
    >
      {{ errors[0] }}
    </div>
  </div>
</template>

<script>
import { getCurrentInstance, useId } from 'vue'

export default {
  inheritAttrs: false,
  props: {
    id: {
      type: String,
      default: null,
    },
    type: {
      type: String,
      default: 'text',
    },
    modelValue: {
      type: String,
      default: null,
    },
    label: {
      type: String,
      default: null,
    },
    errors: {
      type: Array,
      default: () => [],
    },
  },
  emits: ['update:modelValue'],
  setup () {
    const instance = getCurrentInstance()
    const uid = typeof useId === 'function' ? useId() : `fallback-${instance.uid}`

    return { uid }
  },
  computed: {
    inputId () {
      return this.id || `text-input-${this.uid}`
    },
  },
  methods: {
    focus () {
      this.$refs.input.focus()
    },
    select () {
      this.$refs.input.select()
    },
    setSelectionRange (start, end) {
      this.$refs.input.setSelectionRange(start, end)
    },
  },
}
</script>
