# *Who*?

The *answer* to ***Who is (working on) dwyl?***

## *Why*?



## *What*?



## *How*?

There are two ways of discovering this list of people.

### 1. Visit the Org's People Page on GitHub

https://github.com/orgs/dwyl/people

### 2. List all Contributors to dwyl repos on GitHub

Read the Commit History for all the dwyl repos on GitHub!


Lets start with 1 and proceed to 2 when we have time.
(*and invite people to add their own bios & links*)

## Record Fields

```js
{
  fullname: 'Ines Teles',
  avatar: 'https://avatars1.githubusercontent.com/u/4185328',
  github: 'iteles',
  twitter: 'iteles',
  instagram: 'isnteles',
  linkedin: 'https://uk.linkedin.com/in/iteles',
  bio: 'Coorganiser @ladieswhocode LDN. Cheerleader @founderscoders. web-focused, productivity fan, paper lover, microfinance buff, proponent of smiles',
  website: 'http://www.dwyl.io/ines',
  loves: 'Origami, Outdoors, Singing, Wall Planners, Colors',
  wantstoimprove: 'discipline, communication, '
}
```

## Rough Sketch (*idea*)

![who mobile first sketch](http://i.imgur.com/qBgMnJQ.jpg)


# tl;dr

The people who contribute to [**dwyl**](https://github.com/dwyl)
expand on a *daily* basis (*this makes us happy!!*)

Scraping the [https://github.com/orgs/dwyl/**people**](https://github.com/orgs/dwyl/people)
page will only give us the people who have made their Org membership ***public***.
![dwyl people public](http://i.imgur.com/phxC512.png)

At the time of writing this, that is 25 people fewer than 40% of contributors.
(there are many out-standing invitations - thanks GitHub notifications! - and
  most people don't realise that they have to *manually* make their membership public...)

## GitHub Scraper Profile Fields

Using [**github-scraper**](https://github.com/nelsonic/github-scraper)
we can fetch the list of people who have made their membership of dwyl ***public***.

```sh
alanshaw,anniva,besarthoxhaj,codepreneur,Danwhy,edwardcodes,
gabrielperales,gregaubs,heron2014,iteles,izaakrogan,Jasonspd,
krosti,Lukars,MIJOTHY,minaorangina,Neats29,nelsonic,nikhilaravi,
nofootnotes,rjmk,rorysedgwick,rub1e,sarahabimay,SimonLab,tunnckoCore
```
With this list we can fetch the list of people and get their basic profile details:

```js
{
  url: 'https://github.com/anniva',
  followercount: 20,
  starred: 11,
  followingcount: 22,
  worksfor: 'London, UK',
  location: 'London, UK',
  fullname: 'Anni Väänänen',
  email: '',
  website: '',
  joined: '2015-02-08T08:33:23Z',
  avatar: 'https://avatars1.githubusercontent.com/u/10906215?v=3&s=460',
  contribs: 360,
  longest: 6,
  current: 0,
  lastupdated: 1440999448299,
  orgs:
   [ '/foundersandcoders https://avatars3.githubusercontent.com/u/9970257?v=3&s=84',
     '/docdis https://avatars0.githubusercontent.com/u/10836426?v=3&s=84',
     '/dwyl https://avatars2.githubusercontent.com/u/11708465?v=3&s=84',
     '/plastic-cup https://avatars3.githubusercontent.com/u/12393451?v=3&s=84',
     '/jmnr https://avatars2.githubusercontent.com/u/12494544?v=3&s=84',
     '/AnalogFolk https://avatars0.githubusercontent.com/u/12859046?v=3&s=84',
     '/ConsHack https://avatars2.githubusercontent.com/u/12977314?v=3&s=84',
     '/Prolifiko https://avatars1.githubusercontent.com/u/13519340?v=3&s=84',
     '/node-girls https://avatars2.githubusercontent.com/u/13981928?v=3&s=84' ] }
```

## Research

+ *Hilarious/insightful* explanation of when to use **Who vs. Whom**:
http://theoatmeal.com/comics/who_vs_whom
