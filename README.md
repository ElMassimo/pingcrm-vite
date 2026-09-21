<h1 align="center">
  <a href="https://vite-rails.netlify.app/">
    <img src="https://raw.githubusercontent.com/ElMassimo/vite_rails/main/logo.svg" width="120px"/>
  </a>

  <br>

  <a href="https://vite-rails.netlify.app/">
    PingCRM on Vite Rails
  </a>
</h1>

[original demo]: https://github.com/ledermann/pingcrm
[vite rails]: https://github.com/ElMassimo/vite_rails
[js_from_routes]: https://github.com/ElMassimo/js_from_routes
[vite-plugin-full-reload]: https://github.com/ElMassimo/vite-plugin-full-reload
[webpacker]: https://github.com/rails/webpacker
[vite]: http://vitejs.dev/
[Tailwind CSS]: https://tailwindcss.com/

Unlike the [original demo], this replaces [webpacker] with [Vite Rails],
which provides a substantially faster development experience.

It also leverages [<kbd>js_from_routes</kbd>][js_from_routes] to auto-generate API methods to effortlessly integrate with the Rails backend, which works nicely in combination with <kbd>[vite-plugin-full-reload]</kbd>

Styles are powered by [Tailwind CSS], configured CSS-first (no `tailwind.config.js`) via the official `@tailwindcss/vite` plugin.

## Demo 🚀

To learn more about how to move from webpacker to [Vite Rails], check [this pull request](https://github.com/ElMassimo/pingcrm-vite/pull/1).

To learn more about how [<kbd>js_from_routes</kbd>][js_from_routes] can help you simplify your code, check [this pull request](https://github.com/ElMassimo/pingcrm-vite/pull/2).

Visit [the live demo](https://pingcrm-vite.herokuapp.com/). Login with:

- **Username:** johndoe@example.com
- **Password:** secret

<img width="1299" alt="Screen Shot 2021-02-05 at 16 34 59" src="https://user-images.githubusercontent.com/1158253/107080663-5ca35a80-67d0-11eb-90aa-4a2e1db539c5.png">

## Installation 💿

Clone the repo locally:

```
git clone https://github.com/ElMassimo/pingcrm-vite.git
```

Setup (install dependencies, create and seed database):

```
cd pingcrm-vite
bin/setup
```

Start it:

```
foreman start
```

You're ready to go! Visit PingCRM in your browser (http://localhost:3000), and login with:

- **Username:** johndoe@example.com
- **Password:** secret


## Running tests

To run the PingCRM tests, run:

```
rails test:system
```


## Requirements

- Ruby 4.0 (managed with [mise])
- Node 24 (managed with [mise])
- Ruby on Rails 8
- PostgreSQL

[mise]: https://mise.jdx.dev/


## Credits

* Original work by Jonathan Reinink (@reinink) and contributors
* Port to Ruby on Rails by Georg Ledermann (@ledermann)
* Port from Webpacker to Vite Rails (@ElMassimo)
