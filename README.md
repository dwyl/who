<div align="center">

# *Who*? 🦄

![who-banner](https://user-images.githubusercontent.com/194400/194710724-0e2de0b1-0b2a-4ee8-83a0-eb07cce74810.png)

The **quick _answer_** 
to the question: 
**_Who_ is in the `@dwyl` community?**

[![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/dwyl/who/ci.yml?label=build&style=flat-square&branch=main)](https://github.com/dwyl/who/actions/workflows/ci.yml)
[![codecov.io](https://img.shields.io/codecov/c/github/dwyl/who/main.svg?style=flat-square)](http://codecov.io/github/dwyl/who?branch=main)
[![Hex.pm](https://img.shields.io/hexpm/v/elixir_auth_google?color=brightgreen&style=flat-square)](https://hex.pm/packages/elixir_auth_google)
[![contributions welcome](https://img.shields.io/badge/feedback-welcome-brightgreen.svg?style=flat-square)](https://github.com/dwyl/who/issues)
[![HitCount](https://hits.dwyl.com/dwyl/app-who.svg)](https://hits.dwyl.com/dwyl/app-who)

</div>

# **`TODO`**: re-generate the "wall of faces" using latest data `#HelpWanted`

![face wall](https://user-images.githubusercontent.com/194400/28011265-a95f52d4-6559-11e7-823e-6133d947921a.jpg)

# *Why*? 

We needed an **easy, fast & reliable _system_**
to **_visualize_ `who`** is joining
the **`@dwyl` community** <br />
and **track growth** over time. 📈

The [**start-here** > ***who***](https://github.com/dwyl/start-here/tree/8bbd28d2ab0c3b5a2a266a1e41fd160fc6ee3038#who)
section ~~is~~ _was_ *woefully* out of date
because we had to update it _manually_. ⏳ <br />
(_this was
[noted](https://github.com/dwyl/start-here/issues/9)
a `while` back...
but sadly was not made
a priority at the time..._)  
This mini-app/project is designed
to scratch our own itch
and save us
[time](https://github.com/dwyl/start-here/issues/255).

# *What*?

There are **_two_ ways**
of discovering
the list of people
contributing to the
**dwyl mission**;

## 1. _Manually_ check *dwyl* Org *People Page* on GitHub

Visit  
[github.com/orgs/dwyl/people](https://github.com/orgs/dwyl/people)
you can see a list of people 
who are _members_ of the Org. 
*Simple. effective. incomplete*. 
This list only scratches the surface!

## 2. List all contributors to dwyl repos on `GitHub`

Read the Commit History for all the dwyl repos on GitHub
and extract the names of people ... <br />
As you can imagine,
this second option
is _painful_ to do _manually_ ... ⏳ <br />
So we _had_ to create a mini-App
to do it for us
via the **`GitHub` API**! 💡

# *How*?

We built this mini-App
using the
[**`PETAL`** Stack](https://github.com/dwyl/technology-stack/#the-petal-stack)
because we feel <br />
it's the _fastest_
and most _effective_ way
to ship a web app.

## Build Log 👷‍♀️

If you want to **understand _every_ step**
of the process of **_building_** the **mini-app**,
read:
[**`BUILDIT.md`**](https://github.com/dwyl/who/blob/main/BUILDIT.md)


## Run the `Who` App on your `localhost` ⬇️

> **Note**: You will need to have
**`Elixir`** and **`Postgres` installed**, <br />
see:
[learn-elixir#installation](https://github.com/dwyl/learn-elixir#installation)
and
[learn-postgresql#installation](https://github.com/dwyl/learn-postgresql#installation)
> respectively. <br />
> **Tip**: check the prerequisites in:
> [**/phoenix-chat-example**](https://github.com/dwyl/phoenix-chat-example#0-pre-requisites-before-you-start)

On your `localhost`,
run the following commands
in your terminal:

```sh
git clone git@github.com:dwyl/who.git && cd who
mix setup
```
That will download the **`code`**, 
install dependencies
and create the necessary database + tables.

_Next_ you need to do **`1 minute`** of setup. ⏱️
### Create `.env` file

Create an `.env` file by copying the sample:

```sh
cp .env_sample .env
```

This file will load the
[environment variables](https://github.com/dwyl/learn-environment-variables)
required to run the App.

### Get your `GitHub` Personal Access Token

To access the **`GitHub` API**,
you will need to generate a
**Personal Access Token**:
[github.com/settings/tokens](https://github.com/settings/tokens/new)

Click on the **`Generate new token`** button.
Name it something memorable so you know what the token is for:

<img width="1126" alt="github-token-name" src="https://github.com/user-attachments/assets/1d10f566-55a5-49f8-affb-6c7661d14ad2">

and make sure the token will have both `repo`

<img width="659" alt="repo-access" src="https://github.com/user-attachments/assets/9143dfb6-06b8-4608-ba38-3cfb741fb52f">

and `user` access:

<img width="662" alt="user-access" src="https://github.com/user-attachments/assets/f89961c5-8daf-4d4f-b86f-e9f9b8bdf09e">

Once you've created the token,
copy it to your clipboard for the next step.

### Add your `GitHub` token to the `.env` file

Add your token after the `=` sign:

```sh
export GH_PERSONAL_ACCESS_TOKEN=
```

Once you've saved your `.env` file,
run:

```sh
source .env
```

Once you have sourced your `.env` file,
you can run the app with:

```sh
mix s
```

Open the App in your web browser
[**`localhost:4000`**](http://localhost:4000/)
and start your tour!

<br />

## Contributing 👩‍💻

All contributions 
from typo fixes
to feature requests
are always welcome! 🙌

Please start by: <br />
a. **Star** the repo on GitHub
  so you have a "bookmark" you can return to. ⭐ <br />
b. **Fork** the repo
  so you have a copy you can "hack" on. 🍴 <br />
c. **Clone** the repo to your `localhost`
  and run it! 👩‍💻 <br />


For more detail on contributing,
please see:
[dwyl/**contributing**](https://github.com/dwyl/contributing)

### More Features? 🔔

If you have feature ideas, that's great! 🎉 <br />
Please _share_:
[**who/issues**](https://github.com/dwyl/who/issues) 🙏

# Features (Todo)

+ List Repos in the Org:
  https://docs.github.com/en/rest/repos/repos?apiVersion=2022-11-28#list-organization-repositories

+ List of people that Star a given repo.
  
+ List of people who have _contributed_ to repo.