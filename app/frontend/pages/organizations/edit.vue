<script setup lang="ts">
import { contacts as contactsApi, organizations } from '~/api'
import { useForm } from '~/composables/form'
import { omit } from '~/helpers/object'
import type { ContactList, OrganizationForm as OrganizationFormData } from '~/serializers'
import OrganizationForm from './form.vue'

type OrganizationData = Omit<OrganizationFormData, 'id' | 'deleted_at'>
defineOptions({ remember: 'form' })
const { organization, contacts } = defineProps<{
  organization: OrganizationFormData
  contacts: ContactList[]
}>()
const form = useForm<{ organization: OrganizationData }>({
  organization: omit(organization, 'id', 'deleted_at'),
})
const title = $computed(() => form.organization.name)

function pathToEditContact (contact: ContactList) {
  return contactsApi.edit.path(contact)
}

function destroy () {
  if (confirm('Are you sure you want to delete this organization?')) organizations.destroy(organization)
}

function restore () {
  if (confirm('Are you sure you want to restore this organization?')) organizations.restore(organization)
}
</script>

<template>
  <Head :title="title" />
  <div>
    <h1 class="mb-8 font-bold text-3xl">
      <InertiaLink
        class="text-indigo-500 hover:text-indigo-800"
        :href="organizations.index.path()"
      >
        Organizations
      </InertiaLink>
      <span class="text-indigo-400 font-medium">/</span>
      {{ form.organization.name }}
    </h1>
    <TrashedMessage
      v-if="organization.deleted_at"
      class="mb-6"
      @restore="restore"
    >
      This organization has been deleted.
    </TrashedMessage>
    <div class="bg-white rounded shadow overflow-hidden max-w-3xl">
      <OrganizationForm
        v-model="form"
        @submit="organizations.update({ params: organization, form })"
      >
        <div class="px-8 py-4 bg-gray-100 border-t border-gray-200 flex items-center">
          <button
            v-if="!organization.deleted_at"
            class="text-red-700 hover:underline"
            tabindex="-1"
            type="button"
            @click="destroy"
          >
            Delete Organization
          </button>
          <LoadingButton
            :loading="form.processing"
            class="btn-indigo ml-auto"
            type="submit"
          >
            Update Organization
          </LoadingButton>
        </div>
      </OrganizationForm>
    </div>
    <h2 class="mt-12 font-bold text-2xl">
      Contacts
    </h2>
    <div class="mt-6 bg-white rounded shadow overflow-x-auto">
      <table class="w-full whitespace-nowrap">
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
        <tr
          v-for="contact in contacts"
          :key="contact.id"
          class="hover:bg-gray-100 focus-within:bg-gray-100"
        >
          <td class="border-t">
            <InertiaLink
              class="px-6 py-4 flex items-center focus:text-indigo-500"
              :href="pathToEditContact(contact)"
            >
              {{ contact.name }}
              <Icon
                v-if="contact.deleted_at"
                name="trash"
                class="flex-shrink-0 w-3 h-3 fill-gray-500 ml-2"
              />
            </InertiaLink>
          </td>
          <td class="border-t">
            <InertiaLink
              class="px-6 py-4 flex items-center"
              :href="pathToEditContact(contact)"
              tabindex="-1"
            >
              {{ contact.city }}
            </InertiaLink>
          </td>
          <td class="border-t">
            <InertiaLink
              class="px-6 py-4 flex items-center"
              :href="pathToEditContact(contact)"
              tabindex="-1"
            >
              {{ contact.phone }}
            </InertiaLink>
          </td>
          <td class="border-t w-px">
            <InertiaLink
              class="px-4 flex items-center"
              :href="pathToEditContact(contact)"
              tabindex="-1"
            >
              <Icon
                name="cheveron-right"
                class="block w-6 h-6 fill-gray-500"
              />
            </InertiaLink>
          </td>
        </tr>
        <tr v-if="contacts.length === 0">
          <td
            class="border-t px-6 py-4"
            colspan="4"
          >
            No contacts found.
          </td>
        </tr>
      </table>
    </div>
  </div>
</template>
