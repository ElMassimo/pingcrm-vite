<script setup lang="ts">
import { contacts } from '~/api'
import { useForm } from '~/composables/form'
import { omit } from '~/helpers/object'
import type { ContactForm as ContactFormData, Model } from '~/serializers'
import ContactForm from './form.vue'

type ContactData = Omit<ContactFormData, 'id' | 'deleted_at'>
defineOptions({ remember: 'form' })
const { contact, organizations } = defineProps<{
  contact: ContactFormData
  organizations: Model[]
}>()

const form = useForm<{ contact: ContactData }>({
  contact: omit(contact, 'id', 'deleted_at'),
})
const title = $computed(() => `${form.contact.first_name} ${form.contact.last_name}`)

function destroy () {
  if (confirm('Are you sure you want to delete this contact?')) contacts.destroy(contact)
}

function restore () {
  if (confirm('Are you sure you want to restore this contact?')) contacts.restore(contact)
}
</script>

<template>
  <Head :title="title" />
  <div>
    <h1 class="mb-8 font-bold text-3xl">
      <InertiaLink
        class="text-indigo-500 hover:text-indigo-800"
        :href="contacts.index.path()"
      >
        Contacts
      </InertiaLink>
      <span class="text-indigo-400 font-medium">/</span>
      {{ form.contact.first_name }} {{ form.contact.last_name }}
    </h1>
    <TrashedMessage
      v-if="contact.deleted_at"
      class="mb-6"
      @restore="restore"
    >
      This contact has been deleted.
    </TrashedMessage>
    <div class="bg-white rounded shadow overflow-hidden max-w-3xl">
      <ContactForm
        v-model="form"
        :organizations="organizations"
        @submit="contacts.update({ params: contact, form })"
      >
        <div class="px-8 py-4 bg-gray-100 border-t border-gray-200 flex items-center">
          <button
            v-if="!contact.deleted_at"
            class="text-red-700 hover:underline"
            tabindex="-1"
            type="button"
            @click="destroy"
          >
            Delete Contact
          </button>
          <LoadingButton
            :loading="form.processing"
            class="btn-indigo ml-auto"
            type="submit"
          >
            Update Contact
          </LoadingButton>
        </div>
      </ContactForm>
    </div>
  </div>
</template>
