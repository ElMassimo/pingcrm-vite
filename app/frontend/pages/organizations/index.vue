<script setup lang="ts">
import { organizations as organizationsApi } from '~/api'
import { clean, reset, throttle } from '~/helpers/object'
import type { Organization } from '~/serializers'
import NewOrganization from './_new.vue'

interface Filters {
  search?: string | null
  trashed?: string | null
}
interface PaginationMeta {
  page: number
  previous: number | null
  next: number | null
  series: string[]
  url_template: string
}
interface PaginatedOrganizations {
  data: Organization[]
  meta: PaginationMeta
}

const { organizations, filters } = defineProps<{
  organizations: PaginatedOrganizations
  filters: Filters
}>()
const form = $ref({
  search: filters.search,
  trashed: filters.trashed,
})
let modalNew = $ref(false)

watch(() => form, throttle(function () {
  const query = clean(form)
  organizationsApi.index({
    query: Object.keys(query).length ? query : { remember: 'forget' },
    preserveState: true,
    preserveScroll: true,
    replace: true,
    only: ['organizations'],
  })
}, 150), { deep: true })

function pathToEdit (organization: Organization) {
  return organizationsApi.edit.path(organization)
}

function resetFilters () {
  Object.assign(form, reset(form))
}
</script>

<template>
  <Head title="Organizations" />
  <div>
    <h1 class="mb-8 font-bold text-3xl">
      Organizations
    </h1>
    <div class="mb-6 flex justify-between items-center">
      <SearchFilter
        v-model="form.search"
        class="w-full max-w-md mr-4"
        @reset="resetFilters"
      >
        <label
          class="block text-gray-800"
          for="trashed-filter"
        >Trashed:</label>
        <select
          id="trashed-filter"
          v-model="form.trashed"
          class="mt-1 w-full form-select"
        >
          <option :value="null" />
          <option value="with">
            With Trashed
          </option>
          <option value="only">
            Only Trashed
          </option>
        </select>
      </SearchFilter>

      <button
        class="btn-indigo"
        @click="modalNew = true"
      >
        Create <span class="hidden md:inline">Organization</span>
      </button>
      <Modal
        :open="modalNew"
        title="Create Organization"
        @close="modalNew = false"
      >
        <NewOrganization @success="modalNew = false" />
      </Modal>
    </div>
    <div class="bg-white rounded shadow overflow-x-auto">
      <table class="w-full whitespace-nowrap">
        <thead>
          <tr class="text-left font-bold">
            <th class="px-6 pt-6 pb-4">
              Name
            </th>
            <th class="px-6 pt-6 pb-4">
              City
            </th>
            <th
              class="px-6 pt-6 pb-4"
              colspan="2"
            >
              Phone
            </th>
          </tr>
        </thead>
        <tbody>
          <tr
            v-for="organization in organizations.data"
            :key="organization.id"
            class="hover:bg-gray-100 focus-within:bg-gray-100"
          >
            <td class="border-t">
              <InertiaLink
                class="px-6 py-4 flex items-center focus:text-indigo-500"
                :href="pathToEdit(organization)"
              >
                {{ organization.name }}
                <Icon
                  v-if="organization.deleted_at"
                  name="trash"
                  class="flex-shrink-0 w-3 h-3 fill-gray-500 ml-2"
                />
              </InertiaLink>
            </td>
            <td class="border-t">
              <InertiaLink
                class="px-6 py-4 flex items-center"
                :href="pathToEdit(organization)"
                tabindex="-1"
                aria-label="Edit"
              >
                {{ organization.city }}
              </InertiaLink>
            </td>
            <td class="border-t">
              <InertiaLink
                class="px-6 py-4 flex items-center"
                :href="pathToEdit(organization)"
                tabindex="-1"
                aria-label="Edit"
              >
                {{ organization.phone }}
              </InertiaLink>
            </td>
            <td class="border-t w-px">
              <InertiaLink
                class="px-4 flex items-center"
                :href="pathToEdit(organization)"
                tabindex="-1"
                aria-label="Edit"
              >
                <Icon
                  name="cheveron-right"
                  class="block w-6 h-6 fill-gray-500"
                />
              </InertiaLink>
            </td>
          </tr>
          <tr v-if="organizations.data.length === 0">
            <td
              class="border-t px-6 py-4"
              colspan="4"
            >
              No organizations found.
            </td>
          </tr>
        </tbody>
      </table>
    </div>
    <Pagination :meta="organizations.meta" />
  </div>
</template>
