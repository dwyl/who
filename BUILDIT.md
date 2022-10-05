<div align="center">

# Build Log 👩‍💻 

![GitHub Workflow Status](https://img.shields.io/github/workflow/status/dwyl/who/Elixir%20CI?label=build&style=flat-square)

This is a log 
of the steps taken 
to build the **`WHO`** App. 🚀 <br />
It took us _hours_ 
to write it,
but you can 
[***speedrun***](https://en.wikipedia.org/wiki/Speedrun)
it in **10 minutes**. 🏁

</div>

> **Note**: we have referenced sections 
> in our more extensive tutorials/examples
> to keep this doc 
> [DRY](https://en.wikipedia.org/wiki/Don't_repeat_yourself). <br />
> You don't have to follow every step in
> the other tutorials/examples,
> but they are linked in case you get stuck.

In this log we have written the "CRUD" functions first
and _then_ built the UI. <br />
We were able to do this because we had a good idea
of which functions we were going to need. <br />
If you are reading through this
and scratching your head 
wondering where a particular function will be used,
simply scroll down to the UI section
where (_hopefully_) it will all be clear. 

At the end of each step,
remember to run the tests:

```sh
mix test
```

This will help you keep track of where you are
and retrace your steps if something is not working as expected.

We suggest keeping two terminal tabs/windows running
one for the server `mix phx.server` and the other for the tests.
That way you can also see the UI as you progress.

With that in place, let's get building! 



- [Build Log 👩‍💻](#build-log-)
- [1. Create a New `Phoenix` App](#1-create-a-new-phoenix-app)
  - [1.1 Run the `Phoenix` App](#11-run-the-phoenix-app)
  - [1.2 Run the tests:](#12-run-the-tests)
    - [Test Coverage?](#test-coverage)
  - [1.3 Setup `Tailwind`](#13-setup-tailwind)
  - [1.4 Setup `LiveView`](#14-setup-liveview)
  - [1.5 Update `router.ex`](#15-update-routerex)
  - [1.6 Update Tests](#16-update-tests)
  - [1.7 Delete Page-related Files](#17-delete-page-related-files)
  - [Run Tests with Coverage](#run-tests-with-coverage)
- [2. Create Schemas to Store Data](#2-create-schemas-to-store-data)
  - [_Explanation_ of the Schemas](#explanation-of-the-schemas)
    - [`item`](#item)
    - [`timer`](#timer)
  - [2.1 Run Tests!](#21-run-tests)
- [3. Input `items`](#3-input-items)
  - [3.1 Make the `item` Tests Pass](#31-make-the-item-tests-pass)
- [4. Create `Timer`](#4-create-timer)
  - [Make `timer` tests pass](#make-timer-tests-pass)
- [5. `items` with `timers`](#5-items-with-timers)
  - [5.1 Test for `accumulate_item_timers/1`](#51-test-for-accumulate_item_timers1)
  - [5.2 Implement the `accummulate_item_timers/1` function](#52-implement-the-accummulate_item_timers1-function)
  - [5.3 Test for `items_with_timers/1`](#53-test-for-items_with_timers1)
  - [5.4 Implement `items_with_timers/1`](#54-implement-items_with_timers1)
- [6. Add Authentication](#6-add-authentication)
  - [6.1 Add `auth_plug` to `deps`](#61-add-auth_plug-to-deps)
  - [6.2 Get your `AUTH_API_KEY`](#62-get-your-auth_api_key)
  - [6.2 Create Auth Controller](#62-create-auth-controller)
- [7. Create `LiveView` Functions](#7-create-liveview-functions)
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


# 1. Create a New `Phoenix` App

Open your terminal and 
**create** a **new `Phoenix` app**
with the following command:

```sh
mix phx.new app --no-mailer --no-dashboard --no-gettext
```

When asked to install the dependencies,
type `Y` and `[Enter]` (_to install everything_).

The MVP won't
send emails,
display dashboards 
or translate to other languages
(sorry). <br />
_All_ of those things 
will be in the _main_ 
[dwyl/**app**](https://github.com/dwyl/app). <br />
We're excluding them here
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


## 1.2 Run the tests:

To run the tests with 


You should see output similar to:

```sh
...

Finished in 0.1 seconds (0.07s async, 0.07s sync)
3 tests, 0 failures
```

That tells us everything is working as expected. 🚀


### Test Coverage?

If you prefer to see **test coverage** - we certainly do -
then you will need to add a few lines to the 
[`mix.exs`](https://github.com/dwyl/app-mvp/blob/main/mix.exs)
file and
create a 
[`coveralls.json`](https://github.com/dwyl/app-mvp/blob/main/coveralls.json)
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

<img width="653" alt="Phoenix tests passing coverage 100%" src="https://user-images.githubusercontent.com/194400/175767439-4f609357-24c0-4975-a3d4-6ed6057bb321.png">


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
that mean our automated test suite will no longer pass ... 
Run the tests in your command line with the following command:

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

```
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

This app stores data in two schemas:

1. `users` - https://docs.github.com/en/rest/users/users
2. `repos` - https://docs.github.com/en/rest/repos/repos

For each of these schemas we are storing
a subset of the data; only what we need right now.
We can always add more later as needed.


Create database schemas 
to store the data
with the following 
[**`mix phx.gen.schema`**](https://hexdocs.pm/phoenix/Mix.Tasks.Phx.Gen.Schema.html)
commands:

```sh
mix phx.gen.schema User users login:string avatar_url:string name:string company:string bio:string blog:string location:string email:string created_at:string two_factor_authentication:boolean followers:integer following:integer
mix phx.gen.schema Repository repositories name:string full_name:string owner_id:integer description:string fork:boolean forks_count:integer watchers_count:integer stargazers_count:integer topics:string open_issues_count:integer created_at:string pushed_at:string
```



At the end of this step,
we have the following database
[Entity Relationship Diagram](https://en.wikipedia.org/wiki/Entity%E2%80%93relationship_model)
(ERD):



![mvp-erd-items-timers](https://user-images.githubusercontent.com/194400/183075195-c1b50232-5988-47cb-ad18-47dfd4c0bcc3.png)


We created **2 database tables**;
`items`  and `timers`.
Let's run through them.

## _Explanation_ of the Schemas

This is a quick breakdown of the schemas created above:

### `item`

An `item` is the most basic unit of content.
An **`item`** is just a **`String`** of **`text`**.
Later we will be able to 
e.g: a "note", "task", "reminder", etc.
The name **`item`** is **_deliberately_ generic**
as it maintains complete flexibility 
for what we are building later on.

+ `id`: `Int` - the auto-incrementing `id`.
+ `text`: `Binary` (_encrypted_) - the free text you want to capture.
+ `person_id`: `Integer` 
   the "owner" of the `item`)
+ `status`: `Integer`  the `status` of the `item` 
  e.g: **`3`** = 
  [**`active`**](https://github.com/dwyl/statuses/blob/176acda7ea4a177da90011100ad2758bd90415b1/lib/statuses.ex#L24-L28)
+ `inserted_at`: `NaiveDateTime` - created/managed by `Phoenix`
+ `updated_at`: `NaiveDateTime`


<!--
> **Note**: The keen-eyed observer 
(with PostgreSQL experience)
will have noticed that `items.person_id` is an `Integer` (`int4`) data type.
This means we are _limted_ to **`2147483647` people** using the MVP.
See:
[/datatype-numeric.html](https://www.postgresql.org/docs/current/datatype-numeric.html)
We aren't expecting more than 
***2 billion*** people to use the MVP. 😜
-->

### `timer`

A `timer` is associated with an `item`
to track how long it takes to ***complete***.

  + `id`: `Int`
  + `item_id` (Foreign Key `item.id`)
  + `start`: `NaiveDateTime` - start time for the timer
  + `stop`: `NaiveDateTime` - stop time for the timer
  + `inserted_at`: `NaiveDateTime` - record insertion time
  + `updated_at`: `NaiveDateTime`

An `item` can have zero or more `timers`.

Each time an `item` (`task`) is worked on
a **_new_ `timer`** is created/started (_and stopped_).
Meaning a `person` can split the completion 
of an `item` (`task`) across multiple sessions.
That allows us to get a running total
of the amount of time that has
been taken.

<!--
> **Note**: 
> The point of having a distinct `start` and `stop`
instead of just reusing the `inserted_at`
and `updated_at` is simple:
it will allow people to set their timer `start` and/or `stop`
to a different time than the automatic one. 
But they will not be able to update the `inserted_at` or `updated_at`
so we always know when the record was created/updated.
-->



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
Finished in 0.1 seconds (0.08s async, 0.09s sync)
3 tests, 0 failures

----------------
COV    FILE                                        LINES RELEVANT   MISSED
  0.0% lib/app/item.ex                                19        2        2
  0.0% lib/app/timer.ex                               20        2        2
100.0% lib/app_web/live/app_live.ex                   11        2        0
100.0% lib/app_web/router.ex                          18        2        0
100.0% lib/app_web/views/error_view.ex                16        1        0
[TOTAL]  38.5%
----------------
```

Specifically the files:
`lib/app/item.ex`
and 
`lib/app/timer.ex`
have **_zero_ test coverage**. 

We will address this test coverage shortfall in the next section.
Yes, we _know_ this is not 
["TDD"](https://github.com/dwyl/learn-tdd#what-is-tdd)
because we aren't writing the tests _first_.
But by creating database schemas,
we have a scaffold 
for the next stage.
See: https://en.wikipedia.org/wiki/Scaffold_(programming)

<br />

# 3. Input `items`

We're going to 


Create the directory `test/app`
and file:
`test/app/item_test.exs`
with the following code:

```elixir
defmodule App.ItemTest do
  use App.DataCase
  alias App.{Item, Timer}

  describe "items" do
    @valid_attrs %{text: "some text", person_id: 1, status: 2}
    @update_attrs %{text: "some updated text"}
    @invalid_attrs %{text: nil}

    test "get_item!/1 returns the item with given id" do
      {:ok, item} = Item.create_item(@valid_attrs)
      assert Item.get_item!(item.id).text == item.text
    end

    test "create_item/1 with valid data creates a item" do
      assert {:ok, %Item{} = item} = Item.create_item(@valid_attrs)

      assert item.text == "some text"

      inserted_item = List.first(Item.list_items())
      assert inserted_item.text == @valid_attrs.text
    end

    test "create_item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} =
               Item.create_item(@invalid_attrs)
    end

    test "list_items/0 returns a list of items stored in the DB" do
      {:ok, _item1} = Item.create_item(@valid_attrs)
      {:ok, _item2} = Item.create_item(@valid_attrs)

      assert Enum.count(Item.list_items()) == 2
    end

    test "update_item/2 with valid data updates the item" do
      {:ok, item} = Item.create_item(@valid_attrs)

      assert {:ok, %Item{} = item} = Item.update_item(item, @update_attrs)
      assert item.text == "some updated text"
    end
  end
end
```

The first five tests are basic 
[CRUD](https://en.wikipedia.org/wiki/Create,_read,_update_and_delete).

If you run these tests:
```sh
mix test test/app/item_test.exs
```

You will see all the testes _fail_.
This is expected as the code is not there yet!



## 3.1 Make the `item` Tests Pass

Open the 
`lib/app/item.ex` 
file and replace the contents 
with the following code:


```elixir
defmodule App.Item do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
  alias App.Repo
  alias __MODULE__

  schema "items" do
    field :person_id, :integer
    field :status, :integer
    field :text, :string

    timestamps()
  end

  @doc false
  def changeset(item, attrs) do
    item
    |> cast(attrs, [:person_id, :status, :text])
    |> validate_required([:text])
  end

  @doc """
  Creates a item.

  ## Examples

      iex> create_item(%{text: "Learn LiveView"})
      {:ok, %Item{}}

      iex> create_item(%{text: nil})
      {:error, %Ecto.Changeset{}}

  """
  def create_item(attrs) do
    %Item{}
    |> changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Gets a single item.

  Raises `Ecto.NoResultsError` if the Item does not exist.

  ## Examples

      iex> get_item!(123)
      %Item{}

      iex> get_item!(456)
      ** (Ecto.NoResultsError)

  """
  def get_item!(id), do: Repo.get!(Item, id)

  @doc """
  Returns the list of items where the status is different to "deleted"

  ## Examples

      iex> list_items()
      [%Item{}, ...]

  """
  def list_items do
    Item
    |> order_by(desc: :inserted_at)
    |> where([i], is_nil(i.status) or i.status != 6)
    |> Repo.all()
  end

  @doc """
  Updates an `item`.

  ## Examples

      iex> update_item(item, %{field: new_value})
      {:ok, %Item{}}

      iex> update_item(item, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_item(%Item{} = item, attrs) do
    item
    |> Item.changeset(attrs)
    |> Repo.update()
  end

  # soft delete an item:
  def delete_item(id) do
    get_item!(id)
    |> Item.changeset(%{status: 6})
    |> Repo.update()
  end
end
```

Once you have saved the file, re-run the tests.
They should now pass.


# 4. Create `Timer`

Open the `test/app/timer_test.exs` file and add the following tests:

```elixir
defmodule App.TimerTest do
  use App.DataCase
  alias App.{Item, Timer}

  describe "timers" do
    @valid_item_attrs %{text: "some text", person_id: 1}

    test "Timer.start/1 returns timer that has been started" do
      {:ok, item} = Item.create_item(@valid_item_attrs)
      assert Item.get_item!(item.id).text == item.text

      started = NaiveDateTime.utc_now()

      {:ok, timer} =
        Timer.start(%{item_id: item.id, person_id: 1, start: started})

      assert NaiveDateTime.diff(timer.start, started) == 0
    end

    test "Timer.stop/1 stops the timer that had been started" do
      {:ok, item} = Item.create_item(@valid_item_attrs)
      assert Item.get_item!(item.id).text == item.text

      {:ok, started} = 
        NaiveDateTime.new(Date.utc_today, Time.add(Time.utc_now, -1))

      {:ok, timer} =
        Timer.start(%{item_id: item.id, person_id: 1, start: started})

      assert NaiveDateTime.diff(timer.start, started) == 0

      ended = NaiveDateTime.utc_now()
      {:ok, timer} = Timer.stop(%{id: timer.id, stop: ended})
      assert NaiveDateTime.diff(timer.stop, timer.start) == 1
    end

    test "stop_timer_for_item_id(item_id) should stop the active timer (happy path)" do
      {:ok, item} = Item.create_item(@valid_item_attrs)
      {:ok, seven_seconds_ago} = 
        NaiveDateTime.new(Date.utc_today, Time.add(Time.utc_now, -7))
      # Start the timer 7 seconds ago:
      {:ok, timer} =
        Timer.start(%{item_id: item.id, person_id: 1, start: seven_seconds_ago})
      
      # stop the timer based on it's item_id
      Timer.stop_timer_for_item_id(item.id)
      
      stopped_timer = Timer.get_timer!(timer.id)
      assert NaiveDateTime.diff(stopped_timer.start, seven_seconds_ago) == 0
      assert NaiveDateTime.diff(stopped_timer.stop, stopped_timer.start) == 7
    end

    test "stop_timer_for_item_id(item_id) should not explode if there is no timer (unhappy path)" do
      zero_item_id = 0 # random int
      Timer.stop_timer_for_item_id(zero_item_id)
      assert "Don't stop believing!"
    end

    test "stop_timer_for_item_id(item_id) should not melt down if item_id is nil (sad path)" do
      nil_item_id = nil # random int
      Timer.stop_timer_for_item_id(nil_item_id)
      assert "Keep on truckin'"
    end
  end
end
```

## Make `timer` tests pass

Open the `lib/app/timer.ex` file
and replace the contents with the following code:

```elixir
defmodule App.Timer do
  use Ecto.Schema
  import Ecto.Changeset
  # import Ecto.Query
  alias App.Repo
  alias __MODULE__
  require Logger

  schema "timers" do
    field :item_id, :id
    field :start, :naive_datetime
    field :stop, :naive_datetime

    timestamps()
  end

  @doc false
  def changeset(timer, attrs) do
    timer
    |> cast(attrs, [:item_id, :start, :stop])
    |> validate_required([:item_id, :start])
  end

  @doc """
  `get_timer/1` gets a single Timer.

  Raises `Ecto.NoResultsError` if the Timer does not exist.

  ## Examples

      iex> get_timer!(123)
      %Timer{}
  """
  def get_timer!(id), do: Repo.get!(Timer, id)


  @doc """
  `start/1` starts a timer.

  ## Examples

      iex> start(%{item_id: 1, })
      {:ok, %Timer{start: ~N[2022-07-11 04:20:42]}}

  """
  def start(attrs \\ %{}) do
    %Timer{}
    |> changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  `stop/1` stops a timer.

  ## Examples

      iex> stop(%{id: 1})
      {:ok, %Timer{stop: ~N[2022-07-11 05:15:31], etc.}}

  """
  def stop(attrs \\ %{}) do
    get_timer!(attrs.id)
    |> changeset(%{stop: NaiveDateTime.utc_now})
    |> Repo.update()
  end

  @doc """
  `stop_timer_for_item_id/1` stops a timer for the given item_id if there is one.
  Fails silently if there is no timer for the given item_id.

  ## Examples

      iex> stop_timer_for_item_id(42)
      {:ok, %Timer{item_id: 42, stop: ~N[2022-07-11 05:15:31], etc.}}

  """
  def stop_timer_for_item_id(item_id) when is_nil(item_id) do
    Logger.debug("stop_timer_for_item_id/1 called without item_id: #{item_id} fail.")
  end

  def stop_timer_for_item_id(item_id) do
    # get timer by item_id find the latest one that has not been stopped:
    sql = """
    SELECT t.id FROM timers t 
    WHERE t.item_id = $1 
    AND t.stop IS NULL 
    ORDER BY t.id 
    DESC LIMIT 1;
    """
    res = Ecto.Adapters.SQL.query!(Repo, sql, [item_id])
    
    if res.num_rows > 0 do
      # IO.inspect(res.rows)
      timer_id = res.rows |> List.first() |> List.first()
      Logger.debug("Found timer.id: #{timer_id} for item: #{item_id}, attempting to stop.")
      stop(%{id: timer_id})
    else
      Logger.debug("No active timers found for item: #{item_id}")
    end
  end
end
```

The first few functions are simple again.
The more advanced function is `stop_timer_for_item_id/1`.
The _reason_ for the function is,
as it's name suggests,
to stop a `timer` for an `item` by its' `item_id`. 

We have written the function using "raw" `SQL` 
so that it's easier for people who are `new`
to `Phoenix`, and _specifically_ `Ecto` to understand.

# 5. `items` with `timers`

The _interesting_ thing we are UX-testing in the MVP
is the _combination_ of (todo list) `items` and `timers`.

So we need a way of: <br />
**a.** Selecting all the `timers` for a given `item` <br />
**b.** Accumulating the `timers` for the `item` <br />

> **Note**: We would have _loved_ 
to find a single `Ecto` function to do this,
but we didn't.
If you know of one,
please share!


## 5.1 Test for `accumulate_item_timers/1`

This might feel like we are working in reverse,
that's because we _are_!
We are working _back_ from our stated goal
of accumulating all the `timer` for a given `item`
so that we can display a _single_ elapsed time
when an `item` has had more than one timer.

Open the 
`test/app/item_test.exs`
file and add the following block of test code:

```elixir
  describe "accumulate timers for a list of items #103" do
    test "accumulate_item_timers/1 to display cumulative timer" do
      # https://hexdocs.pm/elixir/1.13/NaiveDateTime.html#new/2
      # "Add" -7 seconds: https://hexdocs.pm/elixir/1.13/Time.html#add/3
      {:ok, seven_seconds_ago} =
        NaiveDateTime.new(Date.utc_today, Time.add(Time.utc_now, -7))

      # this is the "shape" of the data that items_with_timers/1 will return:
      items_with_timers = [
        %{
          stop: nil,
          id: 3,
          start: nil,
          text: "This item has no timers",
          timer_id: nil
        },
        %{
          stop: ~N[2022-07-17 11:18:10.000000],
          id: 2,
          start: ~N[2022-07-17 11:18:00.000000],
          text: "Item #2 has one active (no end) and one complete timer should total 17sec",
          timer_id: 3
        },
        %{
          stop: nil,
          id: 2,
          start: seven_seconds_ago,
          text: "Item #2 has one active (no end) and one complete timer should total 17sec",
          timer_id: 4
        },
        %{
          stop: ~N[2022-07-17 11:18:31.000000],
          id: 1,
          start: ~N[2022-07-17 11:18:26.000000],
          text: "Item with 3 complete timers that should add up to 42 seconds elapsed",
          timer_id: 2
        },
        %{
          stop: ~N[2022-07-17 11:18:24.000000],
          id: 1,
          start: ~N[2022-07-17 11:18:18.000000],
          text: "Item with 3 complete timers that should add up to 42 seconds elapsed",
          timer_id: 1
        },
        %{
          stop: ~N[2022-07-17 11:19:42.000000],
          id: 1,
          start: ~N[2022-07-17 11:19:11.000000],
          text: "Item with 3 complete timers that should add up to 42 seconds elapsed",
          timer_id: 5
        }
      ]

      # The *interesting* timer is the *active* one (started seven_seconds_ago) ...
      # The "hard" part to test in accumulating timers are the *active* ones ...
      acc = Item.accumulate_item_timers(items_with_timers)
      item_map = Map.new(acc, fn item -> {item.id, item} end)
      item1 = Map.get(item_map, 1)
      item2 = Map.get(item_map, 2)
      item3 = Map.get(item_map, 3)

      # It's easy to calculate time elapsed for timers that have an stop:
      assert NaiveDateTime.diff(item1.stop, item1.start) == 42
      # This is the fun one that we need to be 17 seconds:
      assert NaiveDateTime.diff(NaiveDateTime.utc_now(), item2.start) == 17
      # The diff will always be 17 seconds because we control the start in the test data above.
      # But we still get the function to calculate it so we know it works.

      # The 3rd item doesn't have any timers, it's the control:
      assert item3.start == nil
    end
  end
```

This is a large test but most of it is the test data (`items_with_timers`) in the format we will be returning from 
`items_with_timers/1` in the next section. 

With that test in place, we can write the function.

## 5.2 Implement the `accummulate_item_timers/1` function

Open the 
`lib/app/item.ex`
file and add the following function:

```elixir
@doc """
  `accumulate_item_timers/1` aggregates the elapsed time
  for all the timers associated with an item
  and then subtracs that time from the start value of the *current* active timer.
  This is done to create the appearance that a single timer is being started/stopped
  when in fact there are multiple timers in the backend.
  For MVP we *could* have just had a single timer ...
  and given the "ugliness" of this code, I wish I had done that!!
  But the "USP" of our product [IMO] is that
  we can track the completion of a task across multiple work sessions.
  And having multiple timers is the *only* way to achieve that.

  If you can think of a better way of achieving the same result,
  please share: https://github.com/dwyl/app-mvp-phoenix/issues/103
  This function *relies* on the list of items being ordered by timer_id ASC
  because it "pops" the last timer and ignores it to avoid double-counting.
  """
  def accumulate_item_timers(items_with_timers) do
    # e.g: %{0 => 0, 1 => 6, 2 => 5, 3 => 24, 4 => 7}
    timer_id_diff_map = map_timer_diff(items_with_timers)

    # e.g: %{1 => [2, 1], 2 => [4, 3], 3 => []}
    item_id_timer_id_map = Map.new(items_with_timers, fn i ->
      { i.id, Enum.map(items_with_timers, fn it ->
          if i.id == it.id, do: it.timer_id, else: nil
        end)
        # stackoverflow.com/questions/46339815/remove-nil-from-list
        |> Enum.reject(&is_nil/1)
      }
    end)

    # this one is "wasteful" but I can't think of how to simplify it ...
    item_id_timer_diff_map = Map.new(items_with_timers, fn item ->
      timer_id_list = Map.get(item_id_timer_id_map, item.id, [0])
      # Remove last item from list before summing to avoid double-counting
      {_, timer_id_list} = List.pop_at(timer_id_list, -1)

      { item.id, Enum.reduce(timer_id_list, 0, fn timer_id, acc ->
          Map.get(timer_id_diff_map, timer_id) + acc
        end)
      }
    end)

    # creates a nested map: %{ item.id: %{id: 1, text: "my item", etc.}}
    Map.new(items_with_timers, fn item ->
      time_elapsed = Map.get(item_id_timer_diff_map, item.id)
      start = if is_nil(item.start), do: nil,
        else: NaiveDateTime.add(item.start, -time_elapsed)

      { item.id, %{item | start: start}}
    end)
    # Return the list of items without duplicates and only the last/active timer:
    |> Map.values()
    # Sort list by item.id descending (ordered by timer_id ASC above) so newest item first:
    |> Enum.sort_by(fn(i) -> i.id end, :desc)
  end
```

There's no getting around this,
the function is huge and not very pretty.
But hopefully the comments clarify it.

If anything is unclear, we're very happy to expand/explain.
We're also _very_ happy for anyone `else` to refactor it!
[Please open an issue](https://github.com/dwyl/app-mvp/issues/) 
so we can discuss. 🙏

## 5.3 Test for `items_with_timers/1`

Open the 
`test/app/item_test.exs`
file and the following test to the bottom:

```elixir
    test "Item.items_with_timers/1 returns a list of items with timers" do
      {:ok, item1} = Item.create_item(@valid_attrs)
      {:ok, item2} = Item.create_item(@valid_attrs)
      assert Item.get_item!(item1.id).text == item1.text

      started = NaiveDateTime.utc_now()

      {:ok, timer1} =
        Timer.start(%{item_id: item1.id, person_id: 1, start: started})
      {:ok, _timer2} =
        Timer.start(%{item_id: item2.id, person_id: 1, start: started})

      assert NaiveDateTime.diff(timer1.start, started) == 0

      # list items with timers:
      item_timers = Item.items_with_timers(1)
      assert length(item_timers) > 0
    end
```

## 5.4 Implement `items_with_timers/1`

Open the 
`lib/app/item.ex`
file and add the following code to the bottom:

```elixir
@doc """
  `items_with_timers/1` Returns a List of items with the latest associated timers.

  ## Examples

  iex> items_with_timers()
  [
    %{text: "hello", person_id: 1, status: 2, start: 2022-07-14 09:35:18},
    %{text: "world", person_id: 2, status: 7, start: 2022-07-15 04:20:42}
  ]
  """
  #
  def items_with_timers(person_id \\ 0) do
    sql = """
    SELECT i.id, i.text, i.status, i.person_id, t.start, t.stop, t.id as timer_id FROM items i
    FULL JOIN timers as t ON t.item_id = i.id
    WHERE i.person_id = $1 AND i.status IS NOT NULL AND i.status != 6
    ORDER BY timer_id ASC;
    """

    Ecto.Adapters.SQL.query!(Repo, sql, [person_id])
    |> map_columns_to_values()
    |> accumulate_item_timers()
  end


  @doc """
  `map_columns_to_values/1` takes an Ecto SQL query result
  which has the List of columns and rows separate
  and returns a List of Maps where the keys are the column names and values the data.

  Sadly, Ecto returns rows without column keys so we have to map them manually:
  ref: https://groups.google.com/g/elixir-ecto/c/0cubhSd3QS0/m/DLdQsFrcBAAJ
  """
  def map_columns_to_values(res) do
    Enum.map(res.rows, fn(row) ->
      Enum.zip(res.columns, row)
      |> Map.new |> AtomicMap.convert()
    end)
  end

  @doc """
  `map_timer_diff/1` transforms a list of items_with_timers
  into a flat map where the key is the timer_id and the value is the difference
  between timer.stop and timer.start
  If there is no active timer return {0, 0}.
  If there is no timer.stop return Now - timer.start

  ## Examples

  iex> list = [
    %{ stop: nil, id: 3, start: nil, timer_id: nil },
    %{ stop: ~N[2022-07-17 11:18:24], id: 1, start: ~N[2022-07-17 11:18:18], timer_id: 1 },
    %{ stop: ~N[2022-07-17 11:18:31], id: 1, start: ~N[2022-07-17 11:18:26], timer_id: 2 },
    %{ stop: ~N[2022-07-17 11:18:24], id: 2, start: ~N[2022-07-17 11:18:00], timer_id: 3 },
    %{ stop: nil, id: 2, start: seven_seconds_ago, timer_id: 4 }
  ]
  iex> map_timer_diff(list)
  %{0 => 0, 1 => 6, 2 => 5, 3 => 24, 4 => 7}
  """
  def map_timer_diff(list) do
    Map.new(list, fn item ->
      if is_nil(item.timer_id) do
        # item without any active timer
        { 0, 0}
      else
        { item.timer_id, timer_diff(item)}
      end
    end)
  end

  @doc """
  `timer_diff/1` calculates the difference between timer.stop and timer.start
  If there is no active timer OR timer has not ended return 0.
  The reasoning is: an *active* timer (no end) does not have to
  be subtracted from the timer.start in the UI ...
  Again, DRAGONS!
  """
  def timer_diff(timer) do
    # ignore timers that have not ended (current timer is factored in the UI!)
    if is_nil(timer.stop) do
      0
    else
      NaiveDateTime.diff(timer.stop, timer.start)
    end
  end
```

Once again, there is quite a lot going on here.
We have broken down the functions into chunks
and added inline comments to clarify the code.
But again, if anything is unclear please let us know!!


# 6. Add Authentication

This section borrows heavily from:
[dwyl/phoenix-liveview-chat-example](https://github.com/dwyl/phoenix-liveview-chat-example#12-authentication)

## 6.1 Add `auth_plug` to `deps`

Open the `mix.exs` file and add `auth_plug` to the `deps` section:

```elixir
{:auth_plug, "~> 1.4.14"},
```

Once the file is saved,
run:

```sh
mix deps.get
```

## 6.2 Get your `AUTH_API_KEY`

Follow the steps in the 
[docs](https://github.com/dwyl/auth_plug#2-get-your-auth_api_key-)
to get your `AUTH_API_KEY` environment variable. (1 minute)


## 6.2 Create Auth Controller

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

# 7. Create `LiveView` Functions

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
