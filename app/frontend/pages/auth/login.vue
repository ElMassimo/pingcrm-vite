<script setup lang="ts">
import { usersSessions } from '@/api'
import { useForm } from '~/composables/form'

const form = useForm({
  user: {
    email: 'johndoe@example.com',
    password: 'secret',
    remember_me: null,
  },
})
const { user } = form

function login () {
  usersSessions.create({ form })
}
</script>

<template layout="base">
  <Head title="Login" />
  <div class="p-6 bg-indigo-800 min-h-screen flex justify-center items-center">
    <div class="w-full max-w-md">
      <Logo
        class="block mx-auto w-full max-w-xs text-white"
        height="50"
      />
      <form
        class="mt-8 bg-white rounded-lg shadow-xl overflow-hidden"
        @submit.prevent="login"
      >
        <div class="px-10 py-12">
          <FlashMessages />

          <h1 class="text-center font-bold text-3xl">
            Welcome Back!
          </h1>
          <div class="mx-auto mt-6 w-24 border-b-2" />
          <TextInput
            v-model="user.email"
            class="mt-10"
            label="Email"
            type="email"
            autofocus
            autocapitalize="off"
          />
          <TextInput
            v-model="user.password"
            class="mt-6"
            label="Password"
            type="password"
          />
          <label
            class="mt-6 select-none flex items-center"
            for="remember"
          >
            <input
              id="remember"
              v-model="user.remember_me"
              class="mr-1"
              type="checkbox"
            >
            <span class="text-sm">Remember Me</span>
          </label>
        </div>
        <div class="px-10 py-4 bg-gray-100 border-t border-gray-200 flex justify-between items-center">
          <a
            class="hover:underline"
            tabindex="-1"
            href="#reset-password"
          >Forget password?</a>
          <LoadingButton
            :loading="form.processing"
            class="btn-indigo"
            type="submit"
          >
            Login
          </LoadingButton>
        </div>
      </form>
    </div>
  </div>
</template>
