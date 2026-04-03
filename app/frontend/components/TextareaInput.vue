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
      return this.id || `textarea-input-${this.uid}`
    },
  },
}
</script>
