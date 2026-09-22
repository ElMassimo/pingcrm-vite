<script setup lang="ts">
import { contacts, dashboard, organizations, reports } from '~/api'
import { usePage } from '~/composables/page'

const page = usePage()
const routes = {
  root: dashboard.index.path(),
  organizations: organizations.index.path(),
  contacts: contacts.index.path(),
  reports: reports.index.path(),
}

function isUrl (...urls: string[]) {
  const currentUrl = page.url.slice(1)
  if (urls[0] === '') return currentUrl === ''
  return urls.some(url => currentUrl.startsWith(url))
}
</script>

<template>
  <div>
    <div class="mb-4">
      <InertiaLink
        class="flex items-center group py-3"
        :href="routes.root"
        role="navigation"
        aria-label="Dashboard"
      >
        <Icon
          name="dashboard"
          class="w-4 h-4 mr-2"
          :class="isUrl('') ? 'fill-white' : 'fill-indigo-400 group-hover:fill-white'"
        />
        <div :class="isUrl('') ? 'text-white' : 'text-indigo-300 group-hover:text-white'">
          Dashboard
        </div>
      </InertiaLink>
    </div>
    <div class="mb-4">
      <InertiaLink
        class="flex items-center group py-3"
        :href="routes.organizations"
        role="navigation"
        aria-label="Organizations"
      >
        <Icon
          name="office"
          class="w-4 h-4 mr-2"
          :class="isUrl('organizations') ? 'fill-white' : 'fill-indigo-400 group-hover:fill-white'"
        />
        <div :class="isUrl('organizations') ? 'text-white' : 'text-indigo-300 group-hover:text-white'">
          Organizations
        </div>
      </InertiaLink>
    </div>
    <div class="mb-4">
      <InertiaLink
        class="flex items-center group py-3"
        :href="routes.contacts"
        role="navigation"
        aria-label="Contacts"
      >
        <Icon
          name="users"
          class="w-4 h-4 mr-2"
          :class="isUrl('contacts') ? 'fill-white' : 'fill-indigo-400 group-hover:fill-white'"
        />
        <div :class="isUrl('contacts') ? 'text-white' : 'text-indigo-300 group-hover:text-white'">
          Contacts
        </div>
      </InertiaLink>
    </div>
    <div class="mb-4">
      <InertiaLink
        class="flex items-center group py-3"
        :href="routes.reports"
        role="navigation"
        aria-label="Reports"
      >
        <Icon
          name="printer"
          class="w-4 h-4 mr-2"
          :class="isUrl('reports') ? 'fill-white' : 'fill-indigo-400 group-hover:fill-white'"
        />
        <div :class="isUrl('reports') ? 'text-white' : 'text-indigo-300 group-hover:text-white'">
          Reports
        </div>
      </InertiaLink>
    </div>
  </div>
</template>
