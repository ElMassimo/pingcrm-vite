<script setup lang="ts">
import type { InertiaForm } from '@inertiajs/vue3'
import type { ContactForm, Model } from '~/serializers'

type ContactData = Omit<ContactForm, 'id' | 'deleted_at'>
type ContactFormState = InertiaForm<{ contact: ContactData }> & {
  errors: Partial<Record<keyof ContactData, string[]>>
}

const { organizations } = defineProps<{ organizations: Model[] }>()
const form = defineModel<ContactFormState>({ required: true })
const emit = defineEmits<{ submit: [] }>()

function submit () {
  emit('submit')
}
</script>

<template>
  <form @submit.prevent="submit">
    <div class="p-8 -mr-6 -mb-8 flex flex-wrap">
      <TextInput
        v-model="form.contact.first_name"
        :errors="form.errors.first_name"
        class="pr-6 pb-8 w-full lg:w-1/2"
        label="First name"
      />
      <TextInput
        v-model="form.contact.last_name"
        :errors="form.errors.last_name"
        class="pr-6 pb-8 w-full lg:w-1/2"
        label="Last name"
      />
      <SelectInput
        v-model="form.contact.organization_id"
        :errors="form.errors.organization_id"
        class="pr-6 pb-8 w-full lg:w-1/2"
        label="Organization"
      >
        <option :value="null" />
        <option
          v-for="organization in organizations"
          :key="organization.id"
          :value="organization.id"
        >
          {{ organization.name }}
        </option>
      </SelectInput>
      <TextInput
        v-model="form.contact.email"
        :errors="form.errors.email"
        class="pr-6 pb-8 w-full lg:w-1/2"
        label="Email"
      />
      <TextInput
        v-model="form.contact.phone"
        :errors="form.errors.phone"
        class="pr-6 pb-8 w-full lg:w-1/2"
        label="Phone"
      />
      <TextInput
        v-model="form.contact.address"
        :errors="form.errors.address"
        class="pr-6 pb-8 w-full lg:w-1/2"
        label="Address"
      />
      <TextInput
        v-model="form.contact.city"
        :errors="form.errors.city"
        class="pr-6 pb-8 w-full lg:w-1/2"
        label="City"
      />
      <TextInput
        v-model="form.contact.region"
        :errors="form.errors.region"
        class="pr-6 pb-8 w-full lg:w-1/2"
        label="Province/State"
      />
      <SelectInput
        v-model="form.contact.country"
        :errors="form.errors.country"
        class="pr-6 pb-8 w-full lg:w-1/2"
        label="Country"
      >
        <option :value="null" />
        <option value="CA">
          Canada
        </option>
        <option value="US">
          United States
        </option>
      </SelectInput>
      <TextInput
        v-model="form.contact.postal_code"
        :errors="form.errors.postal_code"
        class="pr-6 pb-8 w-full lg:w-1/2"
        label="Postal code"
      />
    </div>

    <slot />
  </form>
</template>
