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
      v-model="selected"
      v-bind="{ ...$attrs, class: null }"
      class="form-select"
      :class="{ error: errors.length }"
    >
      <slot/>
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
import * as Vue from 'vue'

const vueRuntime = Vue

export default {
  inheritAttrs: false,
  props: {
    id: {
      type: String,
      default: null,
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
  setup () {
    const uid = typeof vueRuntime.useId === 'function'
      ? vueRuntime.useId()
      : `fallback-${vueRuntime.getCurrentInstance().uid}`

    return { uid }
  },
  data () {
    return {
      selected: this.modelValue,
    }
  },
  computed: {
    inputId () {
      return this.id || `select-input-${this.uid}`
    },
  },
  watch: {
    selected (selected) {
      this.$emit('update:modelValue', selected)
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
