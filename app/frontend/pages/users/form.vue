<script setup lang="ts">
import type { InertiaForm } from '@inertiajs/vue3'
import type { UserForm as UserFormData } from '~/serializers'

type UserData = Omit<UserFormData, 'id' | 'deleted_at' | 'photo'> & {
  password?: string
  photo: File | null
}
type UserFormState = InertiaForm<{ user: UserData }> & {
  errors: Partial<Record<keyof UserData, string[]>>
}

const form = defineModel<UserFormState>({ required: true })
const emit = defineEmits<{ submit: [] }>()

function submit () {
  emit('submit')
}
</script>

<template>
  <form @submit.prevent="submit">
    <div class="p-8 -mr-6 -mb-8 flex flex-wrap">
      <TextInput
        v-model="form.user.first_name"
        :errors="form.errors.first_name"
        class="pr-6 pb-8 w-full lg:w-1/2"
        label="First name"
      />
      <TextInput
        v-model="form.user.last_name"
        :errors="form.errors.last_name"
        class="pr-6 pb-8 w-full lg:w-1/2"
        label="Last name"
      />
      <TextInput
        v-model="form.user.email"
        :errors="form.errors.email"
        class="pr-6 pb-8 w-full lg:w-1/2"
        label="Email"
      />
      <TextInput
        v-model="form.user.password"
        :errors="form.errors.password"
        class="pr-6 pb-8 w-full lg:w-1/2"
        type="password"
        autocomplete="new-password"
        label="Password"
      />
      <SelectInput
        v-model="form.user.owner"
        :errors="form.errors.owner"
        class="pr-6 pb-8 w-full lg:w-1/2"
        label="Owner"
      >
        <option :value="true">
          Yes
        </option>
        <option :value="false">
          No
        </option>
      </SelectInput>
      <FileInput
        v-model="form.user.photo"
        :errors="form.errors.photo"
        class="pr-6 pb-8 w-full lg:w-1/2"
        type="file"
        accept="image/*"
        label="Photo"
      />
    </div>
    <slot />
  </form>
</template>
