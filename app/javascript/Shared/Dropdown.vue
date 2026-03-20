<template>
  <button
    type="button"
    @click="show = true"
  >
    <slot />
    <Teleport to="#dropdown">
      <div v-if="show">
        <div
          style="position: fixed; top: 0; right: 0; left: 0; bottom: 0; z-index: 99998; background: black; opacity: .2"
          @click="show = false"
        />
        <div
          ref="dropdown"
          style="position: absolute; z-index: 99999;"
          @click.stop="show = autoClose ? false : true"
        >
          <slot name="dropdown" />
        </div>
      </div>
    </Teleport>
  </button>
</template>

<script>
import { createPopper } from '@popperjs/core'

export default {
  props: {
    placement: {
      type: String,
      default: 'bottom-end',
    },
    boundary: {
      type: String,
      default: 'scrollParent',
    },
    autoClose: {
      type: Boolean,
      default: true,
    },
  },
  data () {
    return {
      show: false,
    }
  },
  watch: {
    show (show) {
      if (show) {
        this.$nextTick(() => {
          this.popper = createPopper(this.$el, this.$refs.dropdown, {
            placement: this.placement,
            modifiers: [
              {
                name: 'preventOverflow',
                options: {
                  boundariesElement: this.boundary,
                },
              },
            ],
          })
        })
      }
      else if (this.popper) {
        setTimeout(() => this.popper.destroy(), 100)
      }
    },
  },
  mounted () {
    this._onKeydown = (e) => {
      if (e.keyCode === 27)
        this.show = false
    }
    document.addEventListener('keydown', this._onKeydown)
  },
  beforeUnmount () {
    if (this._onKeydown) {
      document.removeEventListener('keydown', this._onKeydown)
    }
  },
}
</script>
