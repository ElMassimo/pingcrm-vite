<script setup lang="ts">
defineEmits<{ restore: [] }>()
</script>

<template>
  <div class="p-4 bg-yellow-300 rounded border border-yellow-500 flex items-center justify-between">
    <div class="flex items-center">
      <Icon
        name="trash"
        class="flex-shrink-0 w-4 h-4 fill-yellow-900 mr-2"
      />
      <div class="text-yellow-900">
        <slot />
      </div>
    </div>
    <button
      class="text-yellow-900 hover:underline"
      tabindex="-1"
      type="button"
      @click="$emit('restore')"
    >
      Restore
    </button>
  </div>
</template>
