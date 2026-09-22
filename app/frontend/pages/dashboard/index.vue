<script setup lang="ts">
import * as timeago from 'timeago.js'

interface Release {
  commit?: string
  created_at: string
}
interface Repository {
  url: string
}

const { release, repo } = defineProps<{
  release: Release
  repo: Repository
}>()
const relativeCommitTime = $computed(() => timeago.format(release.created_at))
const releaseUrl = $computed(() => release.commit
  ? `${repo.url}/commit/${release.commit}`
  : repo.url)
</script>

<template>
  <Head title="Dashboard" />
  <div>
    <h1 class="mb-8 font-bold text-3xl">
      Dashboard
    </h1>
    <p class="mb-4 leading-loose">
      Hey there! Welcome to
      <ExternalLink href="https://github.com/ElMassimo/pingcrm-vite">
        Ping CRM
      </ExternalLink>, a demo app designed to help illustrate how
      <ExternalLink href="https://inertiajs.com">
        Inertia.js
      </ExternalLink>
      works with
      <ExternalLink href="https://rubyonrails.org/">
        Ruby on Rails
      </ExternalLink>.
    </p>
    <p class="mb-4 leading-loose">
      This demo is running on
      <ExternalLink href="https://vite-rails.netlify.app/">
        Vite ⚡️ Rails
      </ExternalLink>
      instead of Webpacker, which provides a
      <ExternalLink href="https://vite-rails.netlify.app/guide/introduction">
        faster development experience
      </ExternalLink>
      thanks to
      <ExternalLink href="https://vite-rails.netlify.app/guide/introduction">
        Vite
      </ExternalLink>.
      <br>
      It also uses
      <ExternalLink href="https://js-from-routes.netlify.app/">
        JS From Routes
      </ExternalLink>
      to simplify navigation and making requests to the Rails server without hardcoding paths.
    </p>
    <p class="mb-4 leading-loose">
      Pages are server-side rendered thanks to the SSR support provided by both <ExternalLink href="https://inertiajs.com/server-side-rendering">
        Inertia
      </ExternalLink> and <ExternalLink href="https://vite-rails.netlify.app/config/#ssr-options-experimental">
        Vite Ruby
      </ExternalLink>. Try disabling JS!
    </p>

    <p class="mb-14 leading-loose">
      Version
      <a
        :href="releaseUrl"
        class="hover:underline"
      >{{ release.commit || 'development' }}</a>
      &minus;
      {{ relativeCommitTime }}
    </p>
  </div>
</template>
