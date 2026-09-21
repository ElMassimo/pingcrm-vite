<script setup lang="ts">
interface PaginationMeta {
  page: number
  previous: number | null
  next: number | null
  series: string[]
  url_template: string
}

const { meta } = defineProps<{ meta: PaginationMeta }>()

function url (pageNumber: number | string | null) {
  return pageNumber ? meta.url_template.replace('P ', String(pageNumber)) : null
}

function active (pageNumber: string) {
  return String(meta.page) === pageNumber
}

const links = $computed(() => [
  { label: 'Previous', url: url(meta.previous), active: false },
  ...meta.series.map(page => ({ label: page, url: url(page), active: active(page) })),
  { label: 'Next', url: url(meta.next), active: false },
])
</script>

<template>
  <div class="mt-6 -mb-1 flex flex-wrap">
    <template
      v-for="(link, key) in links"
      :key="key"
    >
      <div
        v-if="link.label === 'gap'"
        class="mr-1 mb-1 px-4 py-3 text-sm text-gray-500"
      >
        …
      </div>
      <div
        v-else-if="link.url === null"
        class="mr-1 mb-1 px-4 py-3 text-sm border rounded text-gray-700 border-gray-400"
        :class="{ 'ml-auto': link.label === 'Next' }"
      >
        {{ link.label }}
      </div>
      <InertiaLink
        v-else
        class="mr-1 mb-1 px-4 py-3 text-sm border rounded text-gray-900 border-gray-400 hover:bg-white focus:border-indigo-500 focus:text-indigo-500"
        :class="{ 'bg-white': link.active, 'ml-auto': link.label === 'Next' }"
        :href="link.url"
        preserve-state
        preserve-scroll
      >
        {{ link.label }}
      </InertiaLink>
    </template>
  </div>
</template>
