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
      :value="modelValue"
      @input="$emit('update:modelValue', $event.target.value)"
    />
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
    modelValue: {
      type: String,
      required: true,
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
      return this.id || `textarea-input-${this.uid}`
    },
  },
  methods: {
    focus () {
      this.$refs.input.focus()
    },
    select () {
      this.$refs.input.select()
    },
  },
}
</script>
