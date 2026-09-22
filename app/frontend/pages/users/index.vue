<script setup lang="ts">
import { users as usersApi } from '~/api'
import { clean, reset, throttle } from '~/helpers/object'
import type { User } from '~/serializers'

interface Filters {
  search?: string | null
  role?: string | null
  trashed?: string | null
}

const { users, filters, can } = defineProps<{
  users: User[]
  filters: Filters
  can: { create_user: boolean }
}>()
const form = $ref({
  search: filters.search,
  role: filters.role,
  trashed: filters.trashed,
})

watch(() => form, throttle(function () {
  const query = clean(form)
  usersApi.index({
    query: Object.keys(query).length ? query : { remember: 'forget' },
    preserveState: true,
    preserveScroll: true,
    replace: true,
    only: ['users'],
  })
}, 150), { deep: true })

function pathToEdit (user: User) {
  return usersApi.edit.path(user)
}

function resetFilters () {
  Object.assign(form, reset(form))
}
</script>

<template>
  <Head title="Users" />
  <div>
    <h1 class="mb-8 font-bold text-3xl">
      Users
    </h1>
    <div class="mb-6 flex justify-between items-center">
      <SearchFilter
        v-model="form.search"
        class="w-full max-w-md mr-4"
        @reset="resetFilters"
      >
        <label
          class="block text-gray-800"
          for="role-filter"
        >Role:</label>
        <select
          id="role-filter"
          v-model="form.role"
          class="mt-1 w-full form-select"
        >
          <option :value="null" />
          <option value="user">
            User
          </option>
          <option value="owner">
            Owner
          </option>
        </select>
        <label
          class="mt-4 block text-gray-800"
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
      <InertiaLink
        v-if="can.create_user"
        class="btn-indigo"
        :href="usersApi.new.path()"
      >
        Create <span class="hidden md:inline">User</span>
      </InertiaLink>
    </div>
    <div class="bg-white rounded shadow overflow-x-auto">
      <table class="w-full whitespace-nowrap">
        <thead>
          <tr class="text-left font-bold">
            <th class="px-6 pt-6 pb-4">
              Name
            </th>
            <th class="px-6 pt-6 pb-4">
              Email
            </th>
            <th
              class="px-6 pt-6 pb-4"
              colspan="2"
            >
              Role
            </th>
          </tr>
        </thead>
        <tbody>
          <tr
            v-for="user in users"
            :key="user.id"
            class="hover:bg-gray-100 focus-within:bg-gray-100"
          >
            <td class="border-t">
              <InertiaLink
                class="px-6 py-4 flex items-center focus:text-indigo-500"
                :href="pathToEdit(user)"
                aria-label="Edit"
              >
                <img
                  v-if="user.photo"
                  class="block w-5 h-5 rounded-full mr-2 -my-2"
                  :src="user.photo"
                  alt="Photo"
                >
                {{ user.name }}
                <Icon
                  v-if="user.deleted_at"
                  name="trash"
                  class="flex-shrink-0 w-3 h-3 fill-gray-500 ml-2"
                />
              </InertiaLink>
            </td>
            <td class="border-t">
              <InertiaLink
                class="px-6 py-4 flex items-center"
                :href="pathToEdit(user)"
                tabindex="-1"
                aria-label="Edit"
              >
                {{ user.email }}
              </InertiaLink>
            </td>
            <td class="border-t">
              <InertiaLink
                class="px-6 py-4 flex items-center"
                :href="pathToEdit(user)"
                tabindex="-1"
                aria-label="Edit"
              >
                {{ user.owner ? 'Owner' : 'User' }}
              </InertiaLink>
            </td>
            <td class="border-t w-px">
              <InertiaLink
                class="px-4 flex items-center"
                :href="pathToEdit(user)"
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
          <tr v-if="users.length === 0">
            <td
              class="border-t px-6 py-4"
              colspan="4"
            >
              No users found.
            </td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>
