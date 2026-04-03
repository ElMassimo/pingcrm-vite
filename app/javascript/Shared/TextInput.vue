<template>
  <div>
    <label
      v-if="label"
      class="form-label"
      :for="id"
    >{{ label }}:</label>
    <input
      :id="id"
      ref="input"
      v-bind="$attrs"
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
let uid = 0

export default {
  inheritAttrs: false,
  props: {
    id: {
      type: String,
      default () {
        return `text-input-${++uid}`
      },
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
