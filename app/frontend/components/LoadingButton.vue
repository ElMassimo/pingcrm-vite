<script setup lang="ts">
const { loading = false } = defineProps<{ loading?: boolean }>()
</script>

<template>
  <button
    :disabled="loading"
    class="flex items-center"
  >
    <div
      v-if="loading"
      class="btn-spinner mr-2"
    />
    <slot />
  </button>
</template>
