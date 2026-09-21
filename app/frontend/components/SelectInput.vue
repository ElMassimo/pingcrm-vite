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
import { useId } from 'vue'

export default {
  inheritAttrs: false,
  emits: ['update:modelValue'],
  props: {
    id: {
      type: String,
      default: null,
    },
    modelValue: [String, Number, Boolean],
    label: {
      type: String,
      default: null,
    },
    errors: {
      type: Array,
      default: () => [],
    },
  },
  setup () {
    return { uid: useId() }
  },
  computed: {
    inputId () {
      return this.id || `select-input-${this.uid}`
    },
  },
  data () {
    return {
      selected: this.modelValue,
    }
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
