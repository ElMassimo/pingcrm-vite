<template>
  <div>
    <label
      v-if="label"
      class="form-label"
      :for="id"
    >{{ label }}:</label>
    <select
      :id="id"
      ref="input"
      v-model="selected"
      v-bind="$attrs"
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

<script>
let uid = 0

export default {
  inheritAttrs: false,
  props: {
    id: {
      type: String,
      default () {
        return `select-input-${++uid}`
      },
    },
    modelValue: {
      type: [String, Number, Boolean],
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
  data () {
    return {
      selected: this.modelValue,
    }
  },
  watch: {
    selected (selected) {
      this.$emit('update:modelValue', selected)
    },
    modelValue (val) {
      this.selected = val
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
