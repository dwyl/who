<div align="center">

# Build Log 👩🏻‍💻

[![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/dwyl/who/ci.yml?label=build&style=flat-square&branch=main)](https://github.com/dwyl/who/actions/workflows/ci.yml)
[![codecov.io](https://img.shields.io/codecov/c/github/dwyl/who/main.svg?style=flat-square)](http://codecov.io/github/dwyl/who?branch=main)
[![Hex.pm](https://img.shields.io/hexpm/v/phoenix?color=brightgreen&style=flat-square)](https://hex.pm/packages/phoenix)
[![contributions welcome](https://img.shields.io/badge/feedback-welcome-brightgreen.svg?style=flat-square)](https://github.com/dwyl/who/issues)
[![HitCount](https://hits.dwyl.com/dwyl/who-buildit.svg)](https://hits.dwyl.com/dwyl/who-buildit)

This is a log
of the steps taken
to build the **`WHO`** App. 🚀 <br />
It took us _hours_
to write it,
but you can
[_**speedrun**_](https://en.wikipedia.org/wiki/Speedrun)
it in **10 minutes**. 🏁

</div>

> **Note**: we have referenced sections
> in our more extensive tutorials/examples
> to keep this doc
> [DRY](https://en.wikipedia.org/wiki/Don't_repeat_yourself). <br />
> You don't have to follow every step in
> the other tutorials/examples,
> but they are linked in case you get stuck.

In this log we have written the
"[CRUD](https://en.wikipedia.org/wiki/Create,_read,_update_and_delete)"
functions first
and _then_ built the interface. <br />
We were able to do this because we had a good idea
of which functions we were going to need. <br />
If you are reading through this
and scratching your head
wondering where a particular function will be used,
simply scroll down to the interface section
where (_hopefully_) it will all be clear.

> **Note**: if anything is _still_ unclear,
> please open an issue:
> [dwyl/who/issues](https://github.com/dwyl/who/issues)


- [Build Log 👩🏻‍💻](#build-log-)
- [0. Prerequisites: _Before_ You Start](#0-prerequisites-before-you-start)
- [1. Create a New `Phoenix` App](#1-create-a-new-phoenix-app)
  - [1.1 Run the `Phoenix` App](#11-run-the-phoenix-app)
  - [1.2 Run the tests](#12-run-the-tests)
    - [Test Coverage? ](#test-coverage-)
  - [1.3 Setup `Tailwind`](#13-setup-tailwind)
  - [1.4 Setup `LiveView`](#14-setup-liveview)
  - [1.5 Update `router.ex`](#15-update-routerex)
  - [1.6 Update Tests](#16-update-tests)
  - [1.7 Delete Page-related Files](#17-delete-page-related-files)
  - [Run Tests with Coverage](#run-tests-with-coverage)
- [2. Create Schemas to Store Data](#2-create-schemas-to-store-data)
  - [2.1 Run Tests!](#21-run-tests)
  - [2.2 Write Tests for Schema/Scaffold Code](#22-write-tests-for-schemascaffold-code)
    - [2.2.1 User Tests](#221-user-tests)
    - [2.2.2 Repository Tests](#222-repository-tests)
    - [2.2.3 Re-run the Tests](#223-re-run-the-tests)
- [3. Setup `GitHub` API](#3-setup-github-api)
  - [3.1 Make the `user` Tests Pass](#31-make-the-user-tests-pass)
- [4. Log All `GitHub` API Request](#4-log-all-github-api-request)
  - [4.1 Limit API Requests](#41-limit-api-requests)
- [5. Org \<-\> Users](#5-org---users)
- [X. Add Authentication](#x-add-authentication)
  - [X.1 Add `auth_plug` to `deps`](#x1-add-auth_plug-to-deps)
  - [X.2 Get your `AUTH_API_KEY`](#x2-get-your-auth_api_key)
  - [X.3 Create Auth Controller](#x3-create-auth-controller)
- [Y. Create `LiveView` Functions](#y-create-liveview-functions)
  - [7.1 Write `LiveView` Tests](#71-write-liveview-tests)
  - [7.2 Implement the `LiveView` functions](#72-implement-the-liveview-functions)
- [8. Implement the `LiveView` UI Template](#8-implement-the-liveview-ui-template)
  - [8.1 Update the `root` layout/template](#81-update-the-root-layouttemplate)
  - [8.2 Create the `icons` template](#82-create-the-icons-template)
- [9. Update the `LiveView` Template](#9-update-the-liveview-template)
- [10. Filter Items](#10-filter-items)
- [11. Tags](#11-tags)
  - [11.1 Migrations](#111-migrations)
  - [11.2 Schemas](#112-schemas)
  - [11.3 Test tags with Iex](#113-test-tags-with-iex)
  - [11.4 Testing Schemas](#114-testing-schemas)
  - [11.4  Items-Tags association](#114--items-tags-association)
- [12. Run the _Finished_ MVP App!](#12-run-the-finished-mvp-app)
  - [12.1 Run the Tests](#121-run-the-tests)
  - [12.2 Run The App](#122-run-the-app)
- [Thanks!](#thanks)

# 0. Prerequisites: _Before_ You Start

_Before_ you dive in,
make sure you have `Phoenix` and `Postgres` installed,
see how at:
[dwyl/phoenix#how](https://github.com/dwyl/phoenix-chat-example?tab=readme-ov-file#how)

With everything installed & running, let's get building! 👷🏻‍♀️

# 1. Create a New `Phoenix` App

Open your terminal and
**create** a **new `Phoenix` app**
with the following command:

```sh
mix phx.new app --no-mailer --no-dashboard --no-gettext
```

When asked to install the dependencies,
type `Y` and `[Enter]` (_to install everything_).

The `Who` App won't
send emails,
display dashboards
or translate to other languages
(sorry). <br />
We can add `i18n` _later_.
We're excluding for now
to reduce complexity/dependencies.

## 1.1 Run the `Phoenix` App

Run the `Phoenix` app with the command:

```sh
mix phx.server
```

You should see output similar to the following in your terminal:
```sh
Generated app app
[info] Running AppWeb.Endpoint with cowboy 2.9.0 at 127.0.0.1:4000 (http)
[info] Access AppWeb.Endpoint at http://localhost:4000
[debug] Downloading esbuild from https://registry.npmjs.org/esbuild-darwin-64/-/esbuild-darwin-64-0.14.29.tgz
[watch] build finished, watching for changes...
```

That's a good sign, `esbuild` was downloaded
and the assets were compiled successfully.

Visit 
[`localhost:4000`](http://localhost:4000) 
from your browser.

You should see something similar to the following 
(default `Phoenix` homepage):

![phoenix-default-homepage](https://user-images.githubusercontent.com/194400/174807257-34120dc5-723e-4b2c-9e8e-4b6f3aefca14.png)

## 1.2 Run the tests

Run the tests with the command:

```sh
mix test
```

> **Note**: we recommend keeping _two_ terminal tabs/windows running; <br />
one for the server `mix phx.server` and the other for the **tests**. <br />
That way you can also see the UI as you progress.

You should see output similar to:

```sh
...

Finished in 0.1 seconds (0.07s async, 0.07s sync)
3 tests, 0 failures
```

That tells us everything is working as expected. 🚀

### Test Coverage? [![codecov.io](https://img.shields.io/codecov/c/github/dwyl/who/main.svg?style=flat-square)](http://codecov.io/github/dwyl/who?branch=main)

If you prefer to see **test coverage** - we certainly do -
then you will need to add a few lines to the
[`mix.exs`](https://github.com/dwyl/who/blob/main/mix.exs)
file and create a
[`coveralls.json`](https://github.com/dwyl/who/blob/main/coveralls.json)
file to exclude `Phoenix` files from `excoveralls` checking.
Add alias (shortcuts) in `mix.exs` `defp aliases do` list.

e.g: `mix c` runs `mix coveralls.html`
see: [**`commits/d6ab5ef`**](https://github.com/dwyl/app-mvp/pull/90/commits/d6ab5ef7c2be5dcad7d060e782393ae29c94a526) ...

This is just standard `Phoenix` project setup for us,
so we don't duplicate any of the steps here. <br />
For more detail, please see:
[Automated Testing](https://github.com/dwyl/phoenix-chat-example#testing-our-app-automated-testing)
in the 
[dwyl/phoenix-chat-example](https://github.com/dwyl/phoenix-chat-example#testing-our-app-automated-testing)
and specifically
[What is _not_ tested?](https://github.com/dwyl/phoenix-chat-example#13-what-is-not-tested)

With that setup, run:

```sh
mix c
```

You should see output similar to the following:

<img alt="Who tests passing coverage 100%" src="https://github.com/dwyl/who/assets/194400/a82c55f2-d57b-4c97-a781-3b529855ef68">

## 1.3 Setup `Tailwind`

As we're using **`Tailwind CSS`**
for the **UI** in this project
we need to enable it.

We are not duplicating the instructions here,
please refer to:
[Tailwind in Phoenix](https://github.com/dwyl/learn-tailwind#part-2-tailwind-in-phoenix).
Should only take **`~1 minute`**.

By the end of this step you should have **`Tailwind`** working.
When you visit
[`localhost:4000`](http://localhost:4000)
in your browser,
you should see:

![hello world tailwind phoenix](https://user-images.githubusercontent.com/194400/174838767-20bf201e-3179-4ff9-8d5d-751295d1d069.png)

If you got stuck in this section,
please retrace the steps
and open an issue:
[learn-tailwind/issues](https://github.com/dwyl/learn-tailwind/issues)

## 1.4 Setup `LiveView`

Create the `lib/app_web/live` directory
and the controller at `lib/app_web/live/app_live.ex`:

```elixir
defmodule AppWeb.AppLive do
  use AppWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end
end
```

Create the `lib/app_web/views/app_view.ex` file:

```elixir
defmodule AppWeb.AppView do
  use AppWeb, :view
end
```

Next, create the
**`lib/app_web/live/app_live.html.heex`**
file
and add the following line of `HTML`:

```html
<h1 class="text-3xl text-white py-3 text-center 
  bg-gradient-to-r from-green-400 to-blue-500 rounded-lg shadow-lg">
  LiveView App Page with Tailwind!
</h1>
```

Finally, to make the **root layout** simpler, 
open the
`lib/app_web/templates/layout/root.html.heex`
file and
update the contents of the `<body>` to:

```html
<body>
  <header>
    <section class="container">
      <h1>App MVP Phoenix</h1>
    </section>
  </header>
  <%= @inner_content %>
</body>
```

## 1.5 Update `router.ex`

Now that you've created the necessary files,
open the router
`lib/app_web/router.ex`
replace the default route `PageController` controller:

```elixir
get "/", PageController, :index
```

with `AppLive` controller:


```elixir
scope "/", AppWeb do
  pipe_through :browser

  live "/", AppLive
end
```

Now if you refresh the page 
you should see the following:

![liveveiw-page-with-tailwind-style](https://user-images.githubusercontent.com/194400/194404823-4daebd7f-a32f-45c1-8c50-7db93a9478c0.png)

## 1.6 Update Tests

At this point we have made a few changes 
that mean our automated test suite will no longer pass ... <br />
Run the tests in your terminal:

```sh
mix test
```

You should see the tests fail:

```sh
..

  1) test GET / (AppWeb.PageControllerTest)
     test/app_web/controllers/page_controller_test.exs:4
     Assertion with =~ failed
     code:  assert html_response(conn, 200) =~ "Hello TailWorld!"
     left:  "<!DOCTYPE html>\n<html lang=\"en\">\n  <head>\n    <meta charset=\"utf-8\">\n    <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">
     <main class=\"container\">
     <h1 class=\"text-6xl text-center\">LiveView App Page!</h1>\n</main></div>
     </body>\n</html>"
     right: "Hello TailWorld!"
     stacktrace:
       test/app_web/controllers/page_controller_test.exs:6: (test)

Finished in 0.1 seconds (0.06s async, 0.1s sync)
3 tests, 1 failure
```

Create a new directory:
`test/app_web/live`

Then create the file:
`test/app_web/live/app_live_test.exs`

With the following content:

```elixir
defmodule AppWeb.AppLiveTest do
  use AppWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "LiveView App Page"
  end
end
```

Save the file
and re-run the tests: `mix test`

You should see output similar to the following:

```sh
Generated app app
The database for App.Repo has been dropped
...

Finished in 0.1 seconds (0.08s async, 0.1s sync)
3 tests, 0 failures

Randomized with seed 796477
```

## 1.7 Delete Page-related Files

Since we won't be using the `page` in our App,
we can delete the default files created by `Phoenix`:

```sh
lib/app_web/views/page_view.ex
lib/app_web/controllers/page_controller.ex
lib/app_web/templates/page/index.html.heex
test/app_web/controllers/page_controller_test.exs
```

With those files deleted,
our **`Phoenix + LiveView`** project 
is now fully setup
and ready to start _building_!

## Run Tests with Coverage

```sh
mix c
```

You should see output similar to the following:

```sh
Compiling 1 file (.ex)
...

Finished in 0.1 seconds (0.04s async, 0.08s sync)
3 tests, 0 failures

Randomized with seed 538897
----------------
COV    FILE                                        LINES RELEVANT   MISSED
100.0% lib/app_web/live/app_live.ex                    7        1        0
100.0% lib/app_web/router.ex                          27        2        0
100.0% lib/app_web/views/error_view.ex                16        1        0
[TOTAL] 100.0%
----------------
```

# 2. Create Schemas to Store Data

This app stores data in **five** schemas:

1. `users` - https://docs.github.com/en/rest/users/users - the GitHub
   [**`users`**](https://dwyl.github.io/book/auth/07-notes-on-naming.html)
   that _use_ the platform.
2. `orgs` - [https://docs.github.com/en/rest/orgs/orgs](https://docs.github.com/en/rest/orgs/orgs?#get-an-organization) - organizations which can have `users` as members and `repositories`.
3. `repositories` - https://docs.github.com/en/rest/repos/repos -
   the repositories of code on GitHub.
4. `stars` - [https://docs.github.com/en/rest/activity/starring](https://docs.github.com/en/rest/activity/starring?apiVersion=2022-11-28#list-stargazers) -
   the `stars` (on `repositories`) associated with each `user`.
5. `follows` - https://docs.github.com/en/rest/users/followers -
   List the `people` a `user` follows.

For each of these schemas we are storing
a _subset_ of the data;
only what we need right now. <br />
We can always add more
("[backfill](https://stackoverflow.com/questions/70871818/what-is-backfilling-in-data)")
_later_ as needed.

Create database schemas
to store the data
with the following
[**`mix phx.gen.schema`**](https://hexdocs.pm/phoenix/Mix.Tasks.Phx.Gen.Schema.html)
commands:

```sh
mix phx.gen.schema User users login:string avatar_url:string name:string company:string bio:string blog:string location:string email:string created_at:string two_factor_authentication:boolean followers:integer following:integer

mix phx.gen.schema Org orgs login:string avatar_url:string name:string company:string public_repos:integer location:string description:string followers:integer

mix phx.gen.schema Repository repositories name:string full_name:string owner_id:integer owner_name:string description:string fork:boolean forks_count:integer watchers_count:integer stargazers_count:integer topics:string open_issues_count:integer created_at:string pushed_at:string

mix phx.gen.schema Star stars repo_id:integer user_id:integer stop:utc_datetime

mix phx.gen.schema Follow follows follower_id:integer following_id:integer stop:utc_datetime
```

At the end of this step,
we have the following database
[Entity Relationship Diagram](https://en.wikipedia.org/wiki/Entity%E2%80%93relationship_model)
(ERD):

![erd](https://user-images.githubusercontent.com/194400/194425189-e44d6161-c8df-4a0d-9d86-bc1045785c95.png)

We created **5 database tables**;
`users`, `orgs`, `follows`, `repositories` and `stars`.
At present the two tables are unrelated 
but eventually `repository.owner_id` will refer to `user.id`
and we will be creating other schemas below.

<br />

## 2.1 Run Tests!

Once we've created the required schemas,
several new files are created.
If we run the tests with coverage:

```sh
mix c
```

We note that the test coverage
has dropped considerably:

```sh
Finished in 0.1 seconds (0.07s async, 0.09s sync)
3 tests, 0 failures

Randomized with seed 18453
----------------
COV    FILE                                        LINES RELEVANT   MISSED
  0.0% lib/app/repository.ex                          28        2        2
  0.0% lib/app/user.ex                                28        2        2
100.0% lib/app_web/live/app_live.ex                    7        1        0
100.0% lib/app_web/router.ex                          27        2        0
100.0% lib/app_web/views/error_view.ex                16        1        0
[TOTAL]  50.0%
----------------
```

Specifically the files:
`lib/app/repository.ex`
and 
`lib/app/user.ex`
have **_zero_ test coverage**.

We will address this test coverage shortfall in the next section.
Yes, we _know_ this is _not_
[**TDD**](https://github.com/dwyl/learn-tdd#what-is-tdd)
because we aren't writing the tests _first_.
But by creating database schemas,
we have a scaffold
for the next stage.
See:
https://en.wikipedia.org/wiki/Scaffold_(programming)

<br />

## 2.2 Write Tests for Schema/Scaffold Code

The **`mix phx.gen.schema`** command
doesn't create the test files for the schemas.
We can create these quick.

### 2.2.1 User Tests

Create a new file with the path:
`test/app/user_test.exs`

Open the file and add the following test:

```elixir
defmodule App.UserTest do
  use App.DataCase

  test "App.User.create/1" do
    user = %{
      avatar_url: "https://avatars.githubusercontent.com/u/4185328?v=4",
      bio: "Co-founder @dwyl",
      blog: "https://www.twitter.com/iteles",
      company: "@dwyl",
      created_at: "2013-04-17T21:10:06Z",
      email: nil,
      followers: 378,
      following: 79,
      hireable: true,
      html_url: "https://github.com/iteles",
      id: 4185328,
      location: "London, UK",
      login: "iteles",
      name: "Ines TC",
      organizations_url: "https://api.github.com/users/iteles/orgs",
      public_gists: 0,
      public_repos: 31
    }
    assert {:ok, inserted_user} = App.User.create(user)
    assert inserted_user.name == user.name
  end
end
```

If you run this test now:

```sh
mix test test/app/user_test.exs
```

it will _fail_ because the 
`App.User.create/1` function
does not yet exist.

Open the 
`lib/app/user.ex` file 
and add the following function defintion:

```elixir
  @doc """
  Creates a `user`.
  """
  def create(attrs) do
    %User{}
    |> changeset(attrs)
    |> Repo.insert()
  end
```

Now when you re-run the test you should see it pass:

```sh
mix test test/app/user_test.exs
.

Finished in 0.05 seconds (0.00s async, 0.05s sync)
1 test, 0 failures
```

### 2.2.2 Repository Tests

Create a file with the path: 
`test/app/repository_test.exs`

Add the following test code to the file:

```elixir
defmodule App.RepositoryTest do
  use App.DataCase

  test "App.Repository.create/1" do
    repo = %{
      created_at: "2014-03-02T13:20:04Z",
      description: "This your first repo!",
      fork: false,
      forks_count: 110,
      full_name: "dwyl/start-here",
      id: 17338019,
      name: "start-here",
      open_issues_count: 98,
      pushed_at: "2022-08-10T07:41:05Z",
      stargazers_count: 1604,
      topics: Enum.join(["beginner", "beginner-friendly", "how-to", "howto", "learn",
       "starter-kit"], ","),
      watchers_count: 1604
    }
    assert {:ok, inserted_repo} = App.Repository.create(repo)
    assert inserted_repo.name == repo.name
  end
end
```

If you run this test with the command:

```sh
mix t test/app/repository_test.exs
```

You will see it _fail_ because the 
`App.Repository.create/1` function 
does not yet exist.

Open the
`lib/app/repository.ex`
file and add the following function to the bottom:

```elixir
@doc """
Creates a `repository`.
"""
def create(attrs) do
  %Repository{}
  |> changeset(attrs)
  |> Repo.insert()
end
```

If you get stuck, you can always refer to the
file in the finished project:
[`/lib/app/repository.ex`](https://github.com/dwyl/who/blob/56e3445a37fff07f4e7e8561083d7ec77296ed3f/lib/app/repository.ex)

### 2.2.3 Re-run the Tests

At this point,
if you re-run _all_ the tests with coverage:

```sh
mix c
```

```sh
Finished in 1.0 seconds (0.09s async, 0.9s sync)
7 tests, 0 failures

Randomized with seed 406814
----------------
COV    FILE                                        LINES RELEVANT   MISSED
100.0% lib/app/repository.ex                          40        3        0
100.0% lib/app/user.ex                                42        3        0
100.0% lib/app_web/live/app_live.ex                    7        1        0
100.0% lib/app_web/router.ex                          27        2        0
100.0% lib/app_web/views/error_view.ex                16        1        0
[TOTAL] 100.0%
----------------
```

We have our starting point for the project,
let's write some code!

<br />

# 3. Setup `GitHub` API

We're going to make _many_ requests
to the **`GitHub` REST API`**.
So we need an effective way of doing that.

Create the directory `test/app`
and file:
`test/app/github_test.exs`
with the following code:

```elixir
defmodule App.GitHubTest do
  use ExUnit.Case
  alias App.GitHub

  test "App.GitHub.user/1" do
    username = "iteles"
    user = GitHub.user(username)
    assert user.public_repos > 30
  end
end

```

The first test is very basic;
just fetches a `user` from the `GitHub` API
and confirms they have more than 30 `public_repos`. 

If you run these tests:

```sh
mix test test/app/github_test.exs
```

You will see all the testes _fail_.
This is expected as the code is not there yet!

## 3.1 Make the `user` Tests Pass

Open the
`lib/app/github.ex`
file and replace the contents
with the following code:

```elixir
defmodule App.GitHub do
  @moduledoc """
  Handles all interactions with the GitHub REST API
  via: github.com/edgurgel/tentacat Elixir GitHub Lib.
  """
  require Logger

  @access_token Application.compile_env(:tentacat, :access_token)
  @client Tentacat.Client.new(%{access_token: @access_token})

  @doc """
  `user/1` Returns the GitHub user profile data.
  """
  def user(username) do
    Logger.info "Fetching user #{username}"
    {_status, data, _res} = Tentacat.Users.find(@client, username)
    data
  end
end
```

Once you have saved the file, re-run the tests.
They should now pass.

> **Note**: using the `GitHub` API assumes you already
> have a personal access token defined
> as an environment variable `GH_PERSONAL_ACCESS_TOKEN`
> if you don't please see:
> [dwyl/who#get-your-github-personal-access-token](https://github.com/dwyl/who?tab=readme-ov-file#get-your-github-personal-access-token)

# 4. Log All `GitHub` API Request

As noted in
[who#226](https://github.com/dwyl/who/issues/226)
the `GitHub` API is rate-limited to
`5,000 requests per hour`.
We would immediately exhaust this limit in a minute
and be **blocked** with a 
[`429 Error`](https://www.rfc-editor.org/rfc/rfc6585#section-4) 🚫
if we make all the requests we need in one go.
So instead we need to _log_ all the requests
so that we know not to exceed the `5k/h` limit.

Create the `Request Log` (`Reqlog`) schema with the following command:

```sh
mix phx.gen.schema Reqlog reqlogs req:string param:string
```

The output is:

```sh
* creating lib/app/reqlog.ex
* creating priv/repo/migrations/20250127180724_create_reqlogs.exs
```

But for whatever reason it doesn't automatically the test file.
Create it manually with:

```sh
vi test/app/reqlog_test.exs
```

And _paste_ the following code:

```elixir
defmodule App.ReqlogTest do
  use App.DataCase

  test "App.Reqlog.create/1" do
    owner = "dwyl"
    reponame = "mvp"
    record = %{
      created_at: "2014-03-02T13:20:04Z",
      req: "repository",
      param: "#{owner}/#{reponame}"
    }
    assert {:ok, inserted} = App.Reqlog.create(record)
    assert inserted.req == record.req
  end

  test "App.Reqlog.log/2" do
    owner = "dwyl"
    reponame = "mvp"

    assert {:ok, inserted} = App.Reqlog.log("repo", "#{owner}/#{reponame}")
    assert inserted.req == "repo"
    assert inserted.param == "#{owner}/#{reponame}"
  end
end
```

Running the test will fail:

```sh
mix test test/app/reqlog_test.exs
```

Open the `lib/app/reqlog.ex` file
and add the following code:

```elixir
  @doc """
  Creates a `reqlog` (request log) record.
  """
  def create(attrs) do
    %Reqlog{}
    |> changeset(attrs)
    |> Repo.insert()
  end

  def log(req, param) do
    Logger.info "Fetching #{req} #{param}"
    create(%{req: req, param: param})
  end
```

At the top of the file under the `defmodule` add these two lines:

```sh
  alias App.{Repo}
  alias __MODULE__
  require Logger
```

One allows us to use `Repo.insert/1`
`alias __MODULE__`  defines an alias for our Elixir module.
`require Logger` loads the [`Logger`](https://hexdocs.pm/logger).

Ref:
https://alphahydrae.com/2021/03/how-to-make-an-elixir-module-alias-itself/

With that code in-place, we can _use_ it in our `GitHub` file.

Remember to add the line:

```elixir
  use App.DataCase
```

to the top of the file `test/app/github_test.exs`
to ensure that the `GitHub` API requests get logged during testing.

In the `lib/app/github.ex` file,
add the following line to the top:

```elixir
import App.Reqlog, only: [log: 2]
```

Then replace the line:

```elixir
Logger.info "Fetching repository #{owner}/#{reponame}"
```

with:

```elixir
log("repository", "#{owner}/#{reponame}")
```

Replace any other instances of `Logger.info` with `log/2`.

## 4.1 Limit API Requests

Given that `GitHub` has a hard limit of
**`5,000 requests per hour`**:
https://docs.github.com/en/rest/using-the-rest-api/rate-limits-for-the-rest-api

<img width="927" alt="Image" src="https://github.com/user-attachments/assets/f33793ce-049d-425e-9b04-33d94b7ace0f" />

We need to stay within this limit to avoid being blocked.

Rather than duplicate all the code here,
we've left a bunch of comments in the file:

[`/lib/app/api_manager.ex`](https://github.com/dwyl/who/blob/02096766d9efc88fe8fb645aa59de69b3991f970/lib/app/api_manager.ex)

It's enabled in:
[/lib/app/application.ex#L21](https://github.com/dwyl/who/blob/02096766d9efc88fe8fb645aa59de69b3991f970/lib/app/application.ex#L21)

Hopefully it's self-explanatory.
But if not, please comment on:
[**who#226**](https://github.com/dwyl/who/issues/226)
💬

# 5. Org <-> Users

We need to know the `users` who are `members` of an `org`.
Create the schema:

```elixir
mix phx.gen.schema Orgmember orgmembers org_id:integer user_id:integer stop:utc_datetime
```

That will output:

```sh
* creating lib/app/orgmember.ex
* creating priv/repo/migrations/20250131111017_create_orgmembers.exs

Remember to update your repository by running migrations:

    $ mix ecto.migrate
```



# X. Add Authentication

This section borrows heavily from:
[dwyl/phoenix-liveview-chat-example](https://github.com/dwyl/phoenix-liveview-chat-example#12-authentication)

## X.1 Add `auth_plug` to `deps`

Open the `mix.exs` file and add `auth_plug` to the `deps` section:

```elixir
{:auth_plug, "~> 1.4.14"},
```

Once the file is saved,
run:

```sh
mix deps.get
```

## X.2 Get your `AUTH_API_KEY`

Follow the steps in the 
[docs](https://github.com/dwyl/auth_plug#2-get-your-auth_api_key-)
to get your `AUTH_API_KEY` environment variable. (1 minute)


## X.3 Create Auth Controller

Create a new file with the path:
`lib/app_web/controllers/auth_controller.ex`
and add the following code:

```elixir
defmodule AppWeb.AuthController do
  use AppWeb, :controller
  import Phoenix.LiveView, only: [assign_new: 3]

  def on_mount(:default, _params, %{"jwt" => jwt} = _session, socket) do

    claims = jwt
    |> AuthPlug.Token.verify_jwt!()
    |> AuthPlug.Helpers.strip_struct_metadata()
    |> Useful.atomize_map_keys()

    socket =
      socket
      |> assign_new(:person, fn -> claims end)
      |> assign_new(:loggedin, fn -> true end)

    {:cont, socket}
  end

  def on_mount(:default, _params, _session, socket) do
    socket = assign_new(socket, :loggedin, fn -> false end)
    {:cont, socket}
  end

  def login(conn, _params) do
    redirect(conn, external: AuthPlug.get_auth_url(conn, "/"))
  end

  def logout(conn, _params) do
    conn
    |> AuthPlug.logout()
    |> put_status(302)
    |> redirect(to: "/")
  end
end
```

# Y. Create `LiveView` Functions

_Finally_ we have all the "CRUD" functions we're going to need
we can focus on the `LiveView` code that will be the actual UI/UX!

## 7.1 Write `LiveView` Tests

Opent the 
`test/app_web/live/app_live_test.exs`
file and replace the contents with the following test code:

```elixir
defmodule AppWeb.AppLiveTest do
  use AppWeb.ConnCase
  alias App.{Item, Timer}
  import Phoenix.LiveViewTest

  test "disconnected and connected render", %{conn: conn} do
    {:ok, page_live, disconnected_html} = live(conn, "/")
    assert disconnected_html =~ "done"
    assert render(page_live) =~ "done"
  end

  test "connect and create an item", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/")

    assert render_submit(view, :create,
      %{text: "Learn Elixir", person_id: 1}) =~ "Learn Elixir"
  end

  test "toggle an item", %{conn: conn} do
    {:ok, item} =
      Item.create_item(%{text: "Learn Elixir", status: 2, person_id: 0})
    {:ok, _item2} =
      Item.create_item(%{text: "Learn Elixir", status: 4, person_id: 0})

    assert item.status == 2

    started = NaiveDateTime.utc_now()
    {:ok, _timer} =
      Timer.start(%{item_id: item.id, start: started})

    # See: https://github.com/dwyl/useful/issues/17#issuecomment-1186070198
    # assert Useful.typeof(:timer_id) == "atom"
    assert Item.items_with_timers(1) > 0

    {:ok, view, _html} = live(conn, "/")

    assert render_click(view, :toggle,
      %{"id" => item.id, "value" => "on"}) =~ "line-through"

    updated_item = Item.get_item!(item.id)
    assert updated_item.status == 4
  end

  test "(soft) delete an item", %{conn: conn} do
    {:ok, item} = Item.create_item(%{text: "Learn Elixir", person_id: 0, status: 2})

    assert item.status == 2

    {:ok, view, _html} = live(conn, "/")
    assert render_click(view, :delete, %{"id" => item.id}) =~ "done"

    updated_item = Item.get_item!(item.id)
    assert updated_item.status == 6
  end

  test "start a timer", %{conn: conn} do
    {:ok, item} = Item.create_item(%{text: "Get Fancy!", person_id: 0, status: 2})

    assert item.status == 2

    {:ok, view, _html} = live(conn, "/")
    assert render_click(view, :start, %{"id" => item.id}) =~ "stop"
  end

  test "stop a timer", %{conn: conn} do
    {:ok, item} = Item.create_item(%{text: "Get Fancy!", person_id: 0, status: 2})

    assert item.status == 2
    started = NaiveDateTime.utc_now()
    {:ok, timer} = Timer.start(%{item_id: item.id, start: started})

    {:ok, view, _html} = live(conn, "/")

    assert render_click(view, :stop,
      %{"id" => item.id, "timerid" => timer.id}) =~ "done"
  end

  # This test is just to ensure coverage of the handle_info/2 function
  # It's not required but we like to have 100% coverage.
  # https://stackoverflow.com/a/60852290/1148249
  test "handle_info/2 start|stop", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/")

    {:ok, item} = Item.create_item(%{text: "Always Learning", person_id: 0, status: 2})
    started = NaiveDateTime.utc_now()
    {:ok, _timer} = Timer.start(%{item_id: item.id, start: started})

    send(view.pid, %{
      event: "start|stop",
      payload: %{items: Item.items_with_timers(1)}
    })

    assert render(view) =~ item.text
  end

  test "handle_info/2 update", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/")

    {:ok, item} = Item.create_item(%{text: "Always Learning", person_id: 0, status: 2})

    send(view.pid, %{
      event: "update",
      payload: %{items: Item.items_with_timers(1)}
    })

    assert render(view) =~ item.text
  end

  test "handle_info/2 delete", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/")

    {:ok, item} = Item.create_item(%{text: "Always Learning", person_id: 0, status: 6})

    send(view.pid, %{
      event: "delete",
      payload: %{items: Item.items_with_timers(1)}
    })

    refute render(view) =~ item.text
  end

  test "edit-item", %{conn: conn} do
    {:ok, item} = Item.create_item(%{text: "Learn Elixir", person_id: 0, status: 2})

    {:ok, view, _html} = live(conn, "/")

    assert render_click(view, "edit-item", %{"id" => Integer.to_string(item.id)}) =~
             "<form phx-submit=\"update-item\" id=\"form-update\""
  end

  test "update an item", %{conn: conn} do
    {:ok, item} = Item.create_item(%{text: "Learn Elixir", person_id: 0, status: 2})

    {:ok, view, _html} = live(conn, "/")

    assert render_submit(view, "update-item", %{"id" => item.id, "text" => "Learn more Elixir"}) =~
             "Learn more Elixir"

    updated_item = Item.get_item!(item.id)
    assert updated_item.text == "Learn more Elixir"
  end

  test "timer_text(start, stop)" do
    timer = %{
      start: ~N[2022-07-17 09:01:42.000000],
      stop: ~N[2022-07-17 13:22:24.000000]
    }

    assert AppWeb.AppLive.timer_text(timer) == "04:20:42"
  end

  test "get / with valid JWT", %{conn: conn} do
    data = %{email: "test@dwyl.com", givenName: "Alex", picture: "this", auth_provider: "GitHub", id: 2}
    jwt = AuthPlug.Token.generate_jwt!(data)

    {:ok, view, _html} = live(conn, "/?jwt=#{jwt}")
    assert render(view)
  end

  test "Logout link displayed when loggedin", %{conn: conn} do
    data = %{email: "test@dwyl.com", givenName: "Alex", picture: "this", auth_provider: "GitHub", id: 2}
    jwt = AuthPlug.Token.generate_jwt!(data)

    conn = get(conn, "/?jwt=#{jwt}")
    assert html_response(conn, 200) =~ "logout"
  end

  test "get /logout with valid JWT", %{conn: conn} do
    data = %{
      email: "test@dwyl.com",
      givenName: "Alex",
      picture: "this",
      auth_provider: "GitHub",
      sid: 1,
      id: 2
    }

    jwt = AuthPlug.Token.generate_jwt!(data)

    conn =
      conn
      |> put_req_header("authorization", jwt)
      |> get("/logout")

    assert "/" = redirected_to(conn, 302)
  end

  test "test login link redirect to auth.dwyl.com", %{conn: conn} do
    conn = get(conn, "/login")
    assert redirected_to(conn, 302) =~ "auth.dwyl.com"
  end
end
```

These tests are written in the order we created them.
Feel free to comment out all but one at a time
to implement the functions gradually.


## 7.2 Implement the `LiveView` functions

Open the 
`lib/app_web/live/app_live.ex`
file and replace the contents with the following code:

```elixir
defmodule AppWeb.AppLive do
  use AppWeb, :live_view
  alias App.{Item, Timer}
  # run authentication on mount
  on_mount AppWeb.AuthController
  alias Phoenix.Socket.Broadcast

  @topic "live"

  defp get_person_id(assigns) do
    if Map.has_key?(assigns, :person) do
      assigns.person.id
    else
      0
    end
  end

  @impl true
  def mount(_params, _session, socket) do
    # subscribe to the channel
    if connected?(socket), do: AppWeb.Endpoint.subscribe(@topic)

    person_id = get_person_id(socket.assigns)
    items = Item.items_with_timers(person_id)
    {:ok, assign(socket, items: items, editing: nil, filter: "active")}
  end

  @impl true
  def handle_event("create", %{"text" => text}, socket) do
    person_id = get_person_id(socket.assigns)
    Item.create_item(%{text: text, person_id: person_id, status: 2})

    AppWeb.Endpoint.broadcast(@topic, "update", :create)
    {:noreply, socket}
  end

  @impl true
  def handle_event("toggle", data, socket) do
    # Toggle the status of the item between 3 (:active) and 4 (:done)
    status = if Map.has_key?(data, "value"), do: 4, else: 3

    # need to restrict getting items to the people who own or have rights to access them!
    item = Item.get_item!(Map.get(data, "id"))
    Item.update_item(item, %{status: status})
    Timer.stop_timer_for_item_id(item.id)

    AppWeb.Endpoint.broadcast(@topic, "update", :toggle)
    {:noreply, socket}
  end

  @impl true
  def handle_event("delete", %{"id" => item_id}, socket) do
    Item.delete_item(item_id)
    AppWeb.Endpoint.broadcast(@topic, "update", :delete)
    {:noreply, socket}
  end

  @impl true
  def handle_event("start", data, socket) do
    item = Item.get_item!(Map.get(data, "id"))
    person_id = get_person_id(socket.assigns)

    {:ok, _timer} =
      Timer.start(%{
        item_id: item.id,
        person_id: person_id,
        start: NaiveDateTime.utc_now()
      })

    AppWeb.Endpoint.broadcast(@topic, "update", :start)
    {:noreply, socket}
  end

  @impl true
  def handle_event("stop", data, socket) do
    timer_id = Map.get(data, "timerid")
    {:ok, _timer} = Timer.stop(%{id: timer_id})

    AppWeb.Endpoint.broadcast(@topic, "update", :stop)
    {:noreply, socket}
  end

  @impl true
  def handle_event("edit-item", data, socket) do
    {:noreply, assign(socket, editing: String.to_integer(data["id"]))}
  end

  @impl true
  def handle_event("update-item", %{"id" => item_id, "text" => text}, socket) do
    current_item = Item.get_item!(item_id)
    Item.update_item(current_item, %{text: text})

    AppWeb.Endpoint.broadcast(@topic, "update", :update)
    {:noreply, assign(socket, editing: nil)}
  end

  @impl true
  def handle_info(%Broadcast{event: "update", payload: _message}, socket) do
    person_id = get_person_id(socket.assigns)
    items = Item.items_with_timers(person_id)

    {:noreply, assign(socket, items: items)}
  end

  # only show certain UI elements (buttons) if there are items:
  def has_items?(items), do: length(items) > 1

  # 2: uncategorised (when item are created), 3: active
  def active?(item), do: item.status == 2 || item.status == 3
  def done?(item), do: item.status == 4
  def archived?(item), do: item.status == 6

  # Check if an item has an active timer
  def started?(item) do
    not is_nil(item.start) and is_nil(item.stop)
  end

  # An item without an end should be counting
  def timer_stopped?(item) do
    not is_nil(item.stop)
  end

  def timers_any?(item) do
    not is_nil(item.timer_id)
  end

  # Convert Elixir NaiveDateTime to JS (Unix) Timestamp
  def timestamp(naive_datetime) do
    DateTime.from_naive!(naive_datetime, "Etc/UTC")
    |> DateTime.to_unix(:millisecond)
  end

  # Elixir implementation of `timer_text/2`
  def leftPad(val) do
    if val < 10, do: "0#{to_string(val)}", else: val
  end

  def timer_text(item) do
    if is_nil(item) or is_nil(item.start) or is_nil(item.stop) do
      ""
    else
      diff = timestamp(item.stop) - timestamp(item.start)

      # seconds
      s =
        if diff > 1000 do
          s = (diff / 1000) |> trunc()
          s = if s > 60, do: Integer.mod(s, 60), else: s
          leftPad(s)
        else
          "00"
        end

      # minutes
      m =
        if diff > 60000 do
          m = (diff / 60000) |> trunc()
          m = if m > 60, do: Integer.mod(m, 60), else: m
          leftPad(m)
        else
          "00"
        end

      # hours
      h =
        if diff > 3_600_000 do
          h = (diff / 3_600_000) |> trunc()
          leftPad(h)
        else
          "00"
        end

      "#{h}:#{m}:#{s}"
    end
  end

  # Filter element by status (active, archived & done; default: all)
  # see https://hexdocs.pm/phoenix_live_view/live-navigation.html
  @impl true
  def handle_params(params, _uri, socket) do
    # person_id = get_person_id(socket.assigns)
    # items = Item.items_with_timers(person_id)
    filter = params["filter_by"] || socket.assigns.filter

    {:noreply, assign(socket, filter: filter)}
  end

  defp filter_items(items, filter) do
    case filter do
      "active" ->
        Enum.filter(items, &active?(&1))

      "done" ->
        Enum.filter(items, &done?(&1))

      "archived" ->
        Enum.filter(items, &archived?(&1))

      _ ->
        items
    end
  end

  def class_footer_link(filter_name, filter_selected) do
    if filter_name == filter_selected do
      "px-2 py-2 h-9 mr-1 bg-teal-500 text-white rounded-md"
    else
      """
      py-2 px-4 bg-transparent font-semibold
      border rounded border-teal-500 text-teal-500
      hover:text-white hover:bg-teal-500 hover:border-transparent
      """
    end
  end
end
```

Again, a bunch of code here.
Please work through each function 
to understand what is going on.


# 8. Implement the `LiveView` UI Template

_Finally_ we have all the `LiveView` functions,

## 8.1 Update the `root` layout/template

Open the
`lib/app_web/templates/layout/root.html.heex`
file and replace the contents with the following:

```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="csrf-token" content={csrf_token_value()}>
    <%= live_title_tag assigns[:page_title] || "dwyl mvp"%>
    <%= render "icons.html" %>
    <link phx-track-static rel="stylesheet" href={Routes.static_path(@conn, "/assets/app.css")}/> 
    <script defer phx-track-static type="text/javascript" 
      src={Routes.static_path(@conn, "/assets/app.js")}></script>
    <!-- see: https://github.com/dwyl/learn-alpine.js -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/alpinejs/3.10.2/cdn.js" defer></script>
  </head>
  <body>
    <nav class="px-2 sm:px-4 py-2 bg-gray-900 w-full min-h-[12%]">
      <div class="container flex flex-wrap justify-between items-center mx-auto">

        <%= if @loggedin do %>
          <img src={@person.picture} class="mr-3 h-6 sm:h-9 rounded-full" alt="avatar image">
        <% else %>
          <h1 class="text-white">Hi Friend!</h1>
        <% end %>

        <!-- always display logo -->
        <a href="/" class="flex items-center">
            <img src="https://dwyl.com/img/favicon-32x32.png" class="mr-3 h-6 sm:h-9" alt="dwyl logo">
        </a>

        <%= if @loggedin do %>
          <button
            class="bg-teal-600 text-white rounded-md px-3 py-1 text-sm align-middle float-right">
            <%= link "logout", to: "/logout" %>
          </button>

        <% else %>
        <button class="bg-teal-500 text-white rounded-md -pt-1 px-3 py-1 text-sm align-middle float-right">
          <%= link "Login", to: "/login" %>
        </button>
        <% end %>

      </div>
    </nav>
    <%= @inner_content %>
  </body>
</html>
```

## 8.2 Create the `icons` template

To make the App more Mobile-friendly,
we define a bunch of iOS/Android related icons.

Create a new file with the path 
`lib/app_web/templates/layout/icons.html.heex`
and add the following code to it:

```html
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="dwyl is a worldwide community of people using technology to solve real problems.">
<meta name="robots" content="noarchive">
<link rel="shortcut-icon" href="https://dwyl.com/img/favicon.ico">
<link rel="apple-touch-icon" sizes="57x57" href="https://dwyl.com/img/apple-icon-57x57.png">
<link rel="apple-touch-icon" sizes="60x60" href="https://dwyl.com/img/apple-icon-60x60.png">
<link rel="apple-touch-icon" sizes="72x72" href="https://dwyl.com/img/apple-icon-72x72.png">
<link rel="apple-touch-icon" sizes="76x76" href="https://dwyl.com/img/apple-icon-76x76.png">
<link rel="apple-touch-icon" sizes="114x114" href="https://dwyl.com/img/apple-icon-114x114.png">
<link rel="apple-touch-icon" sizes="120x120" href="https://dwyl.com/img/apple-icon-120x120.png">
<link rel="apple-touch-icon" sizes="144x144" href="https://dwyl.com/img/apple-icon-144x144.png">
<link rel="apple-touch-icon" sizes="152x152" href="https://dwyl.com/img/apple-icon-152x152.png">
<link rel="apple-touch-icon" sizes="180x180" href="https://dwyl.com/img/apple-icon-180x180.png">
<link rel="icon" type="image/png" sizes="192x192" href="https://dwyl.com/img/android-icon-192x192.png">
<link rel="icon" type="image/png" sizes="32x32" href="https://dwyl.com/img/favicon-32x32.png">
<link rel="icon" type="image/png" sizes="96x96" href="https://dwyl.com/img/favicon-96x96.png">
<link rel="icon" type="image/png" sizes="16x16" href="https://dwyl.com/img/favicon-16x16.png">
<link rel="manifest" href="https://dwyl.com/img/manifest.json">
<meta name="msapplication-TileColor" content="#ffffff">
<meta name="msapplication-TileImage" content="https://dwyl.com/img/ms-icon-144x144.png">
```

This is static and very repetitive, 
hence creating a partial to hide it from the root layout.

Finally ...


# 9. Update the `LiveView` Template

Open the `app_live.html.heex` 
file and replace the contents 
with the following template code:

```html
<div class="h-90 w-full font-sans">
  <form phx-submit="create" class="w-full lg:w-3/4 lg:max-w-lg text-center mx-auto">

    <!-- textarea so that we can have multi-line capturing 
      help wanted auto re-sizing: https://github.com/dwyl/learn-alpine.js/issues/3 -->
    <textarea 
      class="w-full py-1 px-1 text-slate-800 text-3xl
        bg-white bg-clip-padding
        resize-none
        max-h-80
        transition ease-in-out
        border border-b border-slate-200
        focus:border-none focus:outline-none"
      name="text" 
      placeholder="What needs to be done?" 
      autofocus="" 
      required="required" 
      x-data="{resize() {
           $el.style.height = '80px';
           $el.style.height = $el.scrollHeight + 'px';
        }
      }"
      x-init="resize"
      x-on:input="resize"
    ></textarea>

    <!-- Want to help "DRY" this? see: https://github.com/dwyl/app-mvp-phoenix/issues/105 -->
    <!-- https://tailwindcss.com/docs/justify-content#end -->
    <div class="flex justify-end mr-1">
      <button class="inline-flex items-center px-2 py-1 mt-1 h-9
        bg-green-500 hover:bg-green-600 text-white rounded-md">
        <svg xmlns="http://www.w3.org/2000/svg" 
          class="h-5 w-5 mr-2" fill="none" 
          viewBox="0 0 24 24" stroke="currentColor">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" 
            d="M15 13l-3 3m0 0l-3-3m3 3V8m0 13a9 9 0 110-18 9 9 0 010 18z"
          />
        </svg>
        Save
      </button>
    </div>

  </form>

  <!-- List of items with inline buttons and controls -->
  <ul class="w-full">
    <%= for item <- @items do %>
    <li data-id={item.id} class="mt-2 flex w-full border-t border-slate-200 py-2">

      <!-- if item is "done" (status: 4) strike-through and show "Archive" button -->
      <%= if done?(item) do %>
        <input type="checkbox" phx-value-id={item.id} phx-click="toggle"
          class="flex-none p-4 m-2 form-checkbox text-slate-400" 
          checked />
        <label class="w-full text-slate-400  m-2 line-through">
          <%= item.text %>
        </label>

        <div class="flex flex-col">
        <div class="flex flex-col justify-end mr-1">
          <!-- "Archive" button with icon see: https://github.com/dwyl/app-mvp-phoenix/issues/101 -->
          <button class="inline-flex items-center px-2 py-1 mr-2 h-9
          bg-gray-200 hover:bg-gray-300 text-gray-800 rounded-md"
            phx-click="delete" phx-value-id={item.id}>
            <svg xmlns="http://www.w3.org/2000/svg" 
              class="h-5 w-5 mr-2" fill="none" 
              viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" 
                d="M5 8h14M5 8a2 2 0 110-4h14a2 2 0 110 4M5 8v10a2 2 0 002 2h10a2 2 0 002-2V8m-9 4h4" />
            </svg>
            Archive
          </button>
          <p> 
            <span class="text-sm font-mono font-semibold flex flex-col justify-end text-right mr-2 mt-1"> 
              <%= timer_text(item) %> 
            </span>
          </p>
        </div>
      </div>

      <!-- else render the buttons for start|stop timer -->
      <% else %>
        <!-- Show checkbox so the item can be marked as "done" -->
        <input type="checkbox" phx-value-id={item.id} phx-click="toggle"
          class="flex-none p-4 m-2 form-checkbox hover:text-slate-600" />

        <!-- Editing renders the textarea and "save" button - near identical (duplicate) code from above
          Help wanted DRY-ing this ... see: https://github.com/dwyl/app-mvp-phoenix/issues/105 -->
        <%= if item.id == @editing do %>
          <form phx-submit="update-item" id="form-update" class="w-full mr-2">
            <textarea 
              id="editing"
              class="w-full flex-auto text-slate-800
                bg-white bg-clip-padding
                transition ease-in-out
                border border-b border-slate-200
                focus:border-none focus:outline-none"
              name="text" 
              placeholder="What is on your mind?" 
              autofocus 
              required="required" 
              value={item.text}
            ><%= item.text %></textarea>

            <input type="hidden" name="id" value={item.id}/>

            <div class="flex justify-end mr-1">
              <button class="inline-flex items-center px-2 py-1 mt-1 h-9
                bg-green-500 hover:bg-green-600 text-white rounded-md">
                <svg xmlns="http://www.w3.org/2000/svg" 
                  class="h-5 w-5 mr-2" fill="none" 
                  viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" 
                    d="M15 13l-3 3m0 0l-3-3m3 3V8m0 13a9 9 0 110-18 9 9 0 010 18z"
                  />
                </svg>
                Save
              </button>
            </div>

          </form>
        <% else  %>
          <!-- Render item.text as click-able label -->
          <label class="w-full flex-auto text-slate-800 m-2"
            phx-click="edit-item" phx-value-id={item.id}>
            <%= item.text %>
          </label>
        <% end %>

       <%= if timers_any?(item) do %>
          <!-- always display the time elapsed in the UI https://github.com/dwyl/app-mvp-phoenix/issues/106 -->
          <%= if timer_stopped?(item) do %>
            <div class="flex flex-col">
              <div class="flex flex-col justify-end mr-1">
                <!-- render "continue" button -->
                <button phx-click="start" phx-value-id={item.id}
                  class="inline-flex items-center px-2 py-2 h-9 mr-1
                  bg-teal-600 hover:bg-teal-800 text-white rounded-md">
                  <svg xmlns="http://www.w3.org/2000/svg" 
                    class="h-5 w-5 mr-1" fill="none" 
                    viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" 
                      d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"
                    />
                  </svg>
                  Resume
                </button>
                <p> 
                  <span class="text-sm font-mono font-semibold flex flex-col justify-end text-right mr-2 mt-1"> 
                    <%= timer_text(item) %> 
                  </span>
                </p>
              </div>
            </div>
          <% else %>
            <%= if started?(item) do %>
              <!-- render the counting timer with Apline.js! see: github.com/dwyl/learn-alpine.js -->
              <div class="flex flex-col"
                x-data="{
                  start: parseInt($refs.timer_start.innerHTML, 10),
                  current: null, 
                  stop: null, 
                  interval: null
                }"
                x-init="
                  start = parseInt($refs.timer_start.innerHTML, 10);
                  current = start;
                  interval = setInterval(() => { current = Date.now() }, 500)
                "
                >
                <!-- this is how we pass the start|stop time from Elixir (server) to Alping (client) -->
                <span x-ref="timer_start" class="hidden"><%= timestamp(item.start) %></span>

                <div class="flex flex-col justify-end mr-1">
                  <button phx-click="stop" phx-value-id={item.id} phx-value-timerid={item.timer_id}
                    class="inline-flex items-center px-2 py-2 h-9 mr-1
                    bg-red-500 hover:bg-red-700 text-white rounded-md">
                    <svg xmlns="http://www.w3.org/2000/svg" 
                      class="h-5 w-5 mr-1" fill="none" 
                      viewBox="0 0 24 24" stroke="currentColor">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" 
                        d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"
                      />
                    </svg>
                    Stop
                  </button>

                  <p><span x-text="timer_text(start, current || stop)"
                    class="text-sm font-mono font-semibold text-right mr-1">00:00:00</span></p>
                </div>
              </div>           
            <% end %> <!-- end if started?(item) -->
          <% end %>
        <% else %>
          <!-- render start button -->
          <button phx-click="start" phx-value-id={item.id}
            class="inline-flex items-center px-2 py-2 h-9 mr-1
            bg-teal-500 hover:bg-teal-700 text-white rounded-md">
            <svg xmlns="http://www.w3.org/2000/svg" 
              class="h-5 w-5 mr-1" fill="none" 
              viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" 
                d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"
              />
            </svg>
            Start
          </button>
        <% end %><!-- end timers_any?(item) -->
      <% end %>
            
    </li>
    <% end %><!-- end for item <- @items -->
  </ul>
</div>

<script>
// Render the *counting* timer using JavaScript
// (Stopped timers are rendered by Elixir)

function leftPad(val) {
  return val < 10 ? '0' + String(val) : val;
}

function timer_text(start, current) {
  console.log("timer_text(start, current)", start, current)
  let h="00", m="00", s="00";
  const diff = current - start;
  // seconds
  if(diff > 1000) {
    s = Math.floor(diff / 1000);
    s = s > 60 ? s % 60 : s;
    s = leftPad(s);
  }
  // minutes
  if(diff > 60000) {
    m = Math.floor(diff/60000);
    m = m > 60 ? m % 60 : m;
    m = leftPad(m)
  }
  // hours
  if(diff > 3600000) {
    h = Math.floor(diff/3600000);
    h = leftPad(h)
  }

  return h + ':' + m + ':' + s;
}
</script>
```

The bulk of the App is containted in this one template file. <br />
Work your way through it and if anything is unclear,
let us know!

# 10. Filter Items

On this section we want to add LiveView links to filter items by status.
We first update the template to add the following footer:


```html
<%= if has_items?(@items) do %>
<footer>
  <div class="flex flex-row justify-center p-2 border-t">
    <div class="px-8 py-2"><%= live_patch "All", to: Routes.live_path(@socket, AppWeb.AppLive, %{filter_by: "all"}), class: class_footer_link("all", @filter)  %></div> 
    <div class="px-8 py-2"><%= live_patch "Active", to: Routes.live_path(@socket, AppWeb.AppLive, %{filter_by: "active"}), class: class_footer_link("active",@filter)  %></div> 
    <div class="px-8 py-2"><%= live_patch "Done", to: Routes.live_path(@socket, AppWeb.AppLive, %{filter_by: "done"} ), class: class_footer_link("done", @filter) %></div> 
    <div class="px-8 py-2"><%= live_patch "Archived", to: Routes.live_path(@socket, AppWeb.AppLive, %{filter_by: "archived"} ), class: class_footer_link("archived", @filter) %></div> 
  </div>
</footer>
<% end %>
<script>
...
```


We are creating four `live_patch` links: "All", "Active", "Done" and "Archived".
When a linked is clicked `LiveView` will search for the `handle_params` function
in our `AppWeb.AppLive` module. Let's add this function:

```elixir
  # only show certain UI elements (buttons) if there are items:
  def has_items?(items), do: length(items) > 1


  @impl true
  def handle_params(params, _uri, socket) do
    person_id = get_person_id(socket.assigns)
    filter = params["filter_by"] || socket.assigns.filter

    items =
      Item.items_with_timers(person_id)
      |> filter_items(filter)

    {:noreply, assign(socket, items: items, filter: filter)}
  end

  defp filter_items(items, filter) do
    case filter do
      "active" ->
        Enum.filter(items, &active?(&1))

      "done" ->
        Enum.filter(items, &done?(&1))

      "archived" ->
        Enum.filter(items, &archived?(&1))

      _ ->
        items
    end
  end
```

For each of the possible filters the function assigns to the socket the filterd
list of items. Similar to our `done?` function we have created the `active?` and
`archived?` functions which check the status value of an item:

```elixir
  def active?(item), do: item.status == 2 || items.status == 3
  def done?(item), do: item.status == 4
  def archived?(item), do: item.status == 6
```

Now that we have the new filtered list of items assigned to the socket, we need
to make sure `archived` items are displayed. Let's update our template with:

```html
  <!-- List of items with inline buttons and controls -->
  <ul class="w-full">
    <%= for item <- @items do %>
    <li data-id={item.id} class="mt-2 flex w-full border-t border-slate-200 py-2">

      <%= if archived?(item) do %>
        <input type="checkbox" phx-value-id={item.id} phx-click="toggle"
          class="flex-none p-4 m-2 form-checkbox text-slate-400 cursor-not-allowed" 
          checked disabled />
        <label class="w-full text-slate-400  m-2 line-through">
          <%= item.text %>
        </label>

        <div class="flex flex-col">
        <div class="flex flex-col justify-end mr-1">
          <button disabled class="cursor-not-allowed inline-flex items-center px-2 py-1 mr-2 h-9
          bg-gray-200 text-gray-800 rounded-md">
            <svg xmlns="http://www.w3.org/2000/svg" 
              class="h-5 w-5 mr-2" fill="none" 
              viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" 
                d="M5 8h14M5 8a2 2 0 110-4h14a2 2 0 110 4M5 8v10a2 2 0 002 2h10a2 2 0 002-2V8m-9 4h4" />
            </svg>
            Archived
          </button>
        </div>
      </div>


      <% else %>
      <!-- if item is "done" (status: 4) strike-through and show "Archive" button -->
      <%= if done?(item) do %>
      ...
```

For each items we first check if the status is `archived`.
If it is we then displayed the checkbox checked and disabled and we also displayed
an `arhived` disabled button to make it obvious the item is archived.


Finally we can add the following test to make sure our filtering feature is working
as we expect:

```elixir
  test "filter items", %{conn: conn} do
    {:ok, item} =
      Item.create_item(%{text: "Item to do", person_id: 0, status: 2})

    {:ok, item_done} =
      Item.create_item(%{text: "Item done", person_id: 0, status: 4})

    {:ok, item_archived} =
      Item.create_item(%{text: "Item archived", person_id: 0, status: 6})

    {:ok, view, _html} = live(conn, "/?filter_by=all")
    assert render(view) =~ "Item to do"
    assert render(view) =~ "Item done"
    assert render(view) =~ "Item archived"

    {:ok, view, _html} = live(conn, "/?filter_by=active")
    assert render(view) =~ "Item to do"
    refute render(view) =~ "Item done"
    refute render(view) =~ "Item archived"

    {:ok, view, _html} = live(conn, "/?filter_by=done")
    refute render(view) =~ "Item to do"
    assert render(view) =~ "Item done"
    refute render(view) =~ "Item archived"

    {:ok, view, _html} = live(conn, "/?filter_by=archived")
    refute render(view) =~ "Item to do"
    refute render(view) =~ "Item done"
    assert render(view) =~ "Item archived"
  end
```

We are creating 3 items and testing depeding on the filter selected that the 
items are properly displayed and removed from the view.

See also the [Live Navigation](https://hexdocs.pm/phoenix_live_view/live-navigation.html)
Phoenix documentation for using `live_patch`

# 11. Tags

In this section we're going to add tags to items.
Tags belong to a person (ie. different users can create the same tag name).
A person can't create tag duplicates (case insensitive).


## 11.1 Migrations

We first want to create a new `tags` table in our database.
We can use the `mix ecto.gen.migration add_tags` command to create a new
migration and then create manually a `App.Tag` schema, or we can directly use
the [mix phx.gen.schema](https://hexdocs.pm/phoenix/Mix.Tasks.Phx.Gen.Schema.html)
command to create the schema and the migration in one step:

```sh
mix phx.gen.schema Tag tags person_id:integer text:string
```

You should see a similar response:

```sh
* creating lib/app/tags.ex
* creating priv/repo/migrations/20220922084231_create_tags.exs

Remember to update your repository by running migrations:

    $ mix ecto.migrate
```


We can repeat this process to create a `items_tags` table and `ItemTag`
schema. This [join table](https://en.wikipedia.org/wiki/Associative_entity)
is used to link items and tags together.

```sh
mix phx.gen.schema ItemTag items_tags item_id:references:items tag_id:references:tags
```

We are using the [references](https://hexdocs.pm/phoenix/Mix.Tasks.Phx.Gen.Schema.html#module-attributes)
attribute to link the `item_id` field to the `items` table and `tag_id` to `tags`.

Before running our migrations file, we need to add a few changes to them.


In our `create_tags` migration, update the file to:

```elixir
  def change do
    create table(:tags) do
      add(:person_id, :integer)
      add(:text, :string)

      timestamps()
    end

    create(unique_index(:tags, ["lower(text)", :person_id], name: tags_text_person_id_index))
  end
```

We have added a unique index on the fields `text` and `person_id`.
We have specified the name `tags_text_person_id_index` to the index to make
sure later on to use it in the `Tag` changeset.
This means a person can't create duplicated tags.
The `"lower(text)"` function also makes sure the tags are case insensitive,
for example if a tag `UI` has been created, the person then won't be able to create
the `ui` tag.


Another solution for case insensitive with Postgres is to use the
`citext` extension. Update the migration with:

```elixir

  def change do
    execute "CREATE EXTENSION IF NOT EXISTS citext"

    create table(:tags) do
      add(:person_id, :integer)
      add(:text, :citext)

      timestamps()
    end

    create(unique_index(:tags, [:text, :person_id], name: tags_text_person_id_index))
  end
```

And that's all, Postgres will take care of checking the text value case-sensitivity
for us.



see also for some information about `lower` and `citext`:
- https://hexdocs.pm/ecto/Ecto.Changeset.html#unique_constraint/3-case-sensitivity
- https://elixirforum.com/t/case-insensitive-column-in-ecto/2062/5
- https://www.postgresql.org/docs/current/citext.html
- https://nandovieira.com/using-insensitive-case-columns-in-postgresql-with-citext



In our `create_items_tags` migration, update the file with:

```elixir
  def change do
    create table(:items_tags, primary_key: false) do
      add(:item_id, references(:items, on_delete: :delete_all))
      add(:tag_id, references(:tags, on_delete: :delete_all))

      timestamps()
    end

    create(unique_index(:items_tags, [:item_id, :tag_id]))
  end
```

- We have added the `primary_key: false` option. This to avoid having the `id`
column created automatically by the migration.

- We've updated the `on_delete` option to `delete_all`. This means that if an
item or a tag is deleted, we then remove the rows linked to this item/tag 
in the join table `items_tags`. However if for example an item is deleted the
references in the join table will be removed but the tags linked to the deleted
item won't be removed.

The [`on_delete` values](https://hexdocs.pm/ecto_sql/Ecto.Migration.html#references/2-options)
can be 
- `:nothing` (default), Postgres raises an error if the deleted data is still linked in
the join table
- `:delete_all`, delete the data and the references in the join table
- `:nilify_all`, delete the data and change the id to nil in the join table
- `:restrict`, similar to `:nothing`, see https://stackoverflow.com/questions/60043008/when-to-use-nothing-or-restrict-for-on-delete-with-ecto


- Finally we create a unique index on the `item_id` and `tag_id` fields to make
sure that the same tag can't be added multiple times to an item.


We can now run our migrations with `mix ecto.migrate`:

```sh
Compiling 2 files (.ex)
Generated app app

10:16:42.276 [info]  == Running 20220922091606 App.Repo.Migrations.CreateTags.change/0 forward

10:16:42.279 [info]  create table tags

10:16:42.284 [info]  == Migrated 20220922091606 in 0.0s

10:16:42.307 [info]  == Running 20220922091636 App.Repo.Migrations.CreateItemsTags.change/0 forward

10:16:42.307 [info]  create table items_tags

10:16:42.313 [info]  create index items_tags_item_id_index

10:16:42.315 [info]  create index items_tags_tag_id_index

10:16:42.316 [info]  == Migrated 20220922091636 in 0.0s
```

## 11.2 Schemas

Now that our database is setup for tags, we can update our schemas.


In `lib/app/tag.ex`, update the file to:


```elixir
defmodule App.Tag do
  use Ecto.Schema
  import Ecto.Changeset
  alias App.{Item, ItemTag}

  schema "tags" do
    field :text, :string
    field :person_id, :integer

    many_to_many(:items, Item, join_through: ItemTag)
    timestamps()
  end

  @doc false
  def changeset(tag, attrs) do
    tag
    |> cast(attrs, [:person_id, :text])
    |> validate_required([:person_id, :text])
    |> unique_constraint([:person_id, :text], name: :tags_text_person_id_index)
  end
end

```

We have added the [many_to_many](https://hexdocs.pm/ecto/Ecto.Schema.html#many_to_many/3) function.
We've also added in the `changeset` the [unique_constraint](https://hexdocs.pm/ecto/Ecto.Changeset.html#unique_constraint/3)
for the `person_id` and `text` values.
We have defined the name of the unique constraint to match the one defined 
in our migration.


In `lib/app/item.ex`, add also the `many_to_many` function to the schema

```elixir
  schema "items" do
    field :person_id, :integer
    field :status, :integer
    field :text, :string

    many_to_many(:tags, Tag, join_through: ItemTag)

    timestamps()
  end
```

Finally  in `lib/app/item_tag.ex`:

```elixir
  @primary_key false
  schema "items_tags" do
    belongs_to(:item, Item)
    belongs_to(:tag, Tag)

    timestamps()
  end
```

Because we have define our `items_tags` migration to not use the default `id`
for the primary we want to reflect this change on the schema by using the
[primary_key false](https://hexdocs.pm/ecto/Ecto.Schema.html#module-schema-attributes) 
schema attribute.

If we don't add this attribute if we attempt
to insert or to get one of the `item_tag` value from the database,
the query will fail as the schema will try to retrieve the non existent `id` column.


We also use the `belongs_to` function to define the association with the `Item` and
`Tag` schemas.


## 11.3 Test tags with Iex

Let's use `iex` to create some items and tags and to check our constraints
are working on the tags

To make our life easier when using `iex` we're going to first create a `.iex.exs`
file containing any aliases you want to have when starting a session:


```elixir
alias App.{Repo, Item, Tag, ItemTag}
```

So when running the Phoenix application `iex -S mix` you will have access
directly to `Repo`, `Item`, `Tag` and `ItemTag`!
see also: https://alchemist.camp/episodes/iex-exs



now run `iex -S mix` and let's create a few items and tags:

```sh
item1 = Repo.insert!(%Item{person_id: 1, text: "item1"})
item2 = Repo.insert!(%Item{person_id: 1, text: "item2"})

tag1 = Repo.insert!(%Tag{person_id: 1, text: "Tag1"})
tag2 = Repo.insert!(%Tag{person_id: 1, text: "Tag2"})
```

We've created two items and two tags, now if we attempt to create "tag1" with the
same person id:

```sh
Repo.insert!(%Tag{person_id: 1, text: "tag1"})

** (Ecto.ConstraintError) constraint error when attempting to insert struct:

    * tags_text_person_id_index (unique_constraint)
```

We can see that the `citext` type is working as "Tag1" and "tag1" can't coexist.

However if we change the person id we can still create the tag:

```sh
Repo.insert!(%Tag{person_id: 2, text: "tag1"})
[debug] QUERY OK db=5.8ms queue=0.1ms idle=1767.0ms
```

We can manually link the tag and the item:

```sh
Repo.insert!{%ItemTag{item_id: item1.id, tag_id: tag1.id})
Repo.delete(item1)
Repo.all(ItemTag)
```

We are creating a link then we delete the item and finally we verify the list
of `ItemTag` is empty. However if we check the list of tags we can see the tag
with id 1 still exist

Finally we can check that we can't add duplicate tags to an item:

```sh
Repo.insert!{%ItemTag{item_id: item2.id, tag_id: tag2.id})
Repo.insert!{%ItemTag{item_id: item2.id, tag_id: tag2.id})
** (Ecto.ConstraintError) constraint error when attempting to insert struct:

    * items_tags_item_id_tag_id_index (unique_constraint)
```


Typing all of this in iex is a slow and if we want to add data to our database
we can use the `priv/repo/seeds.exs` file:

```elixir
alias App.{Repo, Item, Tag, ItemTag}

# reset
Repo.delete_all(Item)
Repo.delete_all(Tag)

item1 = Repo.insert!(%Item{person_id: 1, text: "task1"})
item2 = Repo.insert!(%Item{person_id: 1, text: "task2"})

tag1 = Repo.insert!(%Tag{person_id: 1, text: "tag1"})
tag2 = Repo.insert!(%Tag{person_id: 1, text: "tag2"})

Repo.insert!(%ItemTag{item_id: item1.id, tag_id: tag1.id})
Repo.insert!(%ItemTag{item_id: item1.id, tag_id: tag2.id})
Repo.insert!(%ItemTag{item_id: item2.id, tag_id: tag2.id})
```

Then running `mix run priv/repo/seeds.exs` command will populate our database
with our items and tags.

## 11.4 Testing Schemas

We have just tested manually our schemas using Iex, we can also write tests,
for example we can test the changeset for `Tag`:

```elixir
  describe "Test constraints and requirements for Tag schema" do
    test "valid tag changeset" do
      changeset = Tag.changeset(%Tag{}, %{person_id: 1, text: "tag1"})
      assert changeset.valid?
    end

    test "invalid tag changeset when person_id value missing" do
      changeset = Tag.changeset(%Tag{}, %{text: "tag1"})
      refute changeset.valid?
    end

    test "invalid tag changeset when text value missing" do
      changeset = Tag.changeset(%Tag{}, %{person_id: 1})
      refute changeset.valid?
    end
  end
```


see https://hexdocs.pm/phoenix/1.3.2/testing_schemas.html for more inforamtion
about testing schemas.

## 11.4  Items-Tags association

We want to create the tags at the same time as the item is created.
The tags are represented as string where tag values are separated by comma:
"tag1, tag2, ..."

So we need first to parse the tags string value, create any new tags in Postgres,
then associate the list of tags to the item.

We'll first update our `Item` schema to add the `on_replace` option to the 
`many_to_many` function:

```elixir
many_to_many(:tags, Tag, join_through: ItemTag, on_replace: :delete)
```

The `:delete` value will remove any associations between the item and the tags that
have been removed, see https://hexdocs.pm/ecto/Ecto.Schema.html#many_to_many/3.


We now create a new changeset:


```elixir
  def changeset_with_tags(item, attrs) do
    changeset(item, attrs)
    |> put_assoc(:tags, Tag.parse_and_create_tags(attrs))
  end
```

The `put_assoc` creates the association between the item and the list of tags.

The `Tag.parse_and_create_tags` function is defined as:

```elixir
  def parse_and_create_tags(attrs) do
    (attrs[:tags] || "")
    |> String.split(",")
    |> Enum.map(&String.trim/1)
    |> Enum.reject(&(&1 == ""))
    |> create_tags(attrs[:person_id])
  end
  
  def create_tag(attrs) do
    %Tag{}
    |> changeset(attrs)
    |> Repo.insert()
  end
```

The function makes to parse the tags properly by removing any unwanted value
(ex: empty strings) then it called `create_tags`:

```elixir
  @spec create_tags(tag_name :: list(String.t()), person_id: integer) :: map()
  def create_tags([], _person_id), do: []

  def create_tags(tag_names, person_id) do
    timestamp =
      NaiveDateTime.utc_now()
      |> NaiveDateTime.truncate(:second)

    placeholders = %{timestamp: timestamp}

    maps =
      Enum.map(
        tag_names,
        &%{
          text: &1,
          person_id: person_id,
          inserted_at: {:placeholder, :timestamp},
          updated_at: {:placeholder, :timestamp}
        }
      )

    Repo.insert_all(
      Tag,
      maps,
      placeholders: placeholders,
      on_conflict: :nothing
    )

    Repo.all(
      from t in Tag, where: t.text in ^tag_names and t.person_id == ^person_id
    )
  end
```

This function uses `Repo.insert_all` to only send one request to insert all the tags.
We need to "build" the tags timestamp as `insert_all` doesn't do this automatically
unline `Repo.insert`.

The other important information is the `on_conlict` option defined to `:nothing`
in `insert_all`. This means that if we attempt to create a tag which already
exists in the database then we tell Ecto to not raise any error: insert only non
existing tags.

This function is heavily inspired by: https://hexdocs.pm/ecto/constraints-and-upserts.html



Learn more about Ecto with the guides documention, especially the How to section: 
https://hexdocs.pm/ecto/getting-started.html (taken from: https://dashbit.co/ebooks/the-little-ecto-cookbook)


# 12. Run the _Finished_ MVP App!

With all the code saved, let's run the tests one more time.

## 12.1 Run the Tests

In your terminal window, run: 

```sh
mix c
```

> Note: this alias was defined [above](#test-coverage)

You should see output similar to the following:

```sh
Finished in 0.7 seconds (0.1s async, 0.5s sync)
31 tests, 0 failures

----------------
COV    FILE                                        LINES RELEVANT   MISSED
100.0% lib/app/item.ex                               245       34        0
100.0% lib/app/timer.ex                               97       16        0
100.0% lib/app_web/controllers/auth_controller.       35        9        0
100.0% lib/app_web/live/app_live.ex                  186       57        0
[TOTAL]  100.0%
----------------
```

All tests pass and we have **`100%` Test Coverage**.
This reminds us just how few _relevant_ lines of code there are in the MVP!

## 12.2 Run The App

In your second terminal tab/window, run:

```sh
mix phx.server
```

Open the app 
[`localhost:4000`](http://localhost:4000) 
in two or more web browsers
(so that you can see the realtime sync)
and perform the actions
listed in the `REAMDE.md`.

e.g: 

![mvp-localhost-demo](https://user-images.githubusercontent.com/194400/183337496-429af597-45a2-447f-9061-a494907736d9.gif)



<br />

# Thanks!

Thanks for reading this far.
If you found it interesting,
please let us know by starring the repo on GitHub! ⭐


<br />

[![HitCount](https://hits.dwyl.com/dwyl/who-build.svg)](https://hits.dwyl.com/dwyl/who-build)
