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
export default {
  inheritAttrs: false,
  setup () {
    return { uid: useId() }
  },
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
  computed: {
    inputId () {
      return this.id || `select-input-${this.uid}`
    },
  },
}
</script>
