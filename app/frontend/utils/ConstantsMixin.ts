export default {
  // Internal: Allows to define constants in a separate section of the component.
  beforeCreate () {
    Object.assign(this, this.$options.constants)
  },
}
