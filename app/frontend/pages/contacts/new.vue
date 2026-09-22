<script setup lang="ts">
import { contacts } from '~/api'
import { useForm } from '~/composables/form'
import type { ContactForm as ContactFormData, Model } from '~/serializers'
import ContactForm from './form.vue'

type ContactData = Omit<ContactFormData, 'id' | 'deleted_at'>
defineOptions({ remember: 'form' })
const { contact, organizations } = defineProps<{
  contact: ContactFormData
  organizations: Model[]
}>()

const form = useForm<{ contact: ContactData }>({
  contact,
})
</script>

<template>
  <Head title="Create Contact" />
  <div>
    <h1 class="mb-8 font-bold text-3xl">
      <InertiaLink
        class="text-indigo-400 hover:text-indigo-600"
        :href="contacts.index.path()"
      >
        Contacts
      </InertiaLink>
      <span class="text-indigo-400 font-medium">/</span> Create
    </h1>
    <div class="bg-white rounded shadow overflow-hidden max-w-3xl">
      <ContactForm
        v-model="form"
        :organizations="organizations"
        @submit="contacts.create({ form })"
      >
        <div class="px-8 py-4 bg-gray-100 border-t border-gray-200 flex justify-end items-center">
          <LoadingButton
            :loading="form.processing"
            class="btn-indigo"
            type="submit"
          >
            Create Contact
          </LoadingButton>
        </div>
      </ContactForm>
    </div>
  </div>
</template>
