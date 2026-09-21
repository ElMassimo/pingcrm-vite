<script setup lang="ts">
import type { InertiaForm } from '@inertiajs/vue3'
import type { OrganizationForm } from '~/serializers'

type OrganizationData = Omit<OrganizationForm, 'id' | 'deleted_at'>
type OrganizationFormState = InertiaForm<{ organization: OrganizationData }> & {
  errors: Partial<Record<keyof OrganizationData, string[]>>
}

const form = defineModel<OrganizationFormState>({ required: true })
const emit = defineEmits<{ submit: [] }>()

function submit () {
  emit('submit')
}
</script>

<template>
  <form @submit.prevent="submit">
    <div class="p-8 -mr-6 -mb-8 flex flex-wrap">
      <TextInput
        v-model="form.organization.name"
        :errors="form.errors.name"
        class="pr-6 pb-8 w-full lg:w-1/2"
        label="Name"
      />
      <TextInput
        v-model="form.organization.email"
        :errors="form.errors.email"
        class="pr-6 pb-8 w-full lg:w-1/2"
        label="Email"
      />
      <TextInput
        v-model="form.organization.phone"
        :errors="form.errors.phone"
        class="pr-6 pb-8 w-full lg:w-1/2"
        label="Phone"
      />
      <TextInput
        v-model="form.organization.address"
        :errors="form.errors.address"
        class="pr-6 pb-8 w-full lg:w-1/2"
        label="Address"
      />
      <TextInput
        v-model="form.organization.city"
        :errors="form.errors.city"
        class="pr-6 pb-8 w-full lg:w-1/2"
        label="City"
      />
      <TextInput
        v-model="form.organization.region"
        :errors="form.errors.region"
        class="pr-6 pb-8 w-full lg:w-1/2"
        label="Province/State"
      />
      <SelectInput
        v-model="form.organization.country"
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
        v-model="form.organization.postal_code"
        :errors="form.errors.postal_code"
        class="pr-6 pb-8 w-full lg:w-1/2"
        label="Postal code"
      />
    </div>
    <slot />
  </form>
</template>
