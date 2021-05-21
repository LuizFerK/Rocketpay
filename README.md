<br />

<p align="center">
  <img alt="Logo" src="./.github/logo.png" width="120px" />
</p>

<h1 align="center" style="text-align: center;">Rocketpay</h1>

<p align="center">
	<a href="https://github.com/LuizFerK">
		<img alt="Author" src="https://img.shields.io/badge/author-Luiz%20Fernando-802a44?style=flat" />
	</a>
	<a href="#">
		<img alt="Languages" src="https://img.shields.io/github/languages/count/LuizFerK/Rocketpay?color=802a44&style=flat" />
	</a>
	<a href="hhttps://github.com/LuizFerK/Rocketpay/stargazers">
		<img alt="Stars" src="https://img.shields.io/github/stars/LuizFerK/Rocketpay?color=802a44&style=flat" />
	</a>
	<a href="https://github.com/LuizFerK/Rocketpay/network/members">
		<img alt="Forks" src="https://img.shields.io/github/forks/LuizFerK/Rocketpay?color=802a44&style=flat" />
	</a>
	<a href="https://github.com/LuizFerK/Rocketpay/graphs/contributors">
		<img alt="Contributors" src="https://img.shields.io/github/contributors/LuizFerK/Rocketpay?color=802a44&style=flat" />
	</a>
  <a href="https://codecov.io/gh/LuizFerK/Rocketpay">
  <img src="https://codecov.io/gh/LuizFerK/Rocketpay/branch/main/graph/badge.svg?token=8XFXDOIH5R"/>
</a>
</p>

<p align="center">
	<b>Transfer money to anyone anywhere!</b><br />
	<span>Created with Elixir and Phoenix.</span><br />
	<sub>Made with ❤️</sub>
</p>

<br />

# :pushpin: Contents

- [Features](#rocket-features)
- [Installation](#wrench-installation)
- [Getting started](#bulb-getting-started)
- [Endpoints](#triangular_flag_on_post-endpoints)
- [Techs](#fire-techs)
- [Issues](#bug-issues)
- [License](#book-license)

# :rocket: Features

- Create users
- Deposit or withdraw any amount of money
- Do instant transactions for any user in the app

# :wrench: Installation

### Required :warning:
- Elixir
- Erlang
- Phoenix
- Postgres database

### SSH

SSH URLs provide access to a Git repository via SSH, a secure protocol. If you have an SSH key registered in your GitHub account, clone the project using this command:

```git clone git@github.com:LuizFerK/Rocketpay.git```

### HTTPS

In case you don't have an SSH key on your GitHub account, you can clone the project using the HTTPS URL, run this command:

```git clone https://github.com/LuizFerK/Rocketpay.git```

**Both of these commands will generate a folder called Rocketpay, with all the project**

# :bulb: Getting started

1. Run ```mix deps.get``` to install the dependencies
2. Create a postgres database named ```rocketpay```
3. On the ```config/dev.exs``` and ```config/test.exs``` files, change your postgres **user** and **password**
4. Run ```mix ecto.migrate``` to run the migrations to your database
5. Run ```mix phx.server``` to start the server on port 4000

# :triangular_flag_on_post: Endpoints

> All the endpoints are protected with Basic Auth. You can change the username and password in `config/config.exs` file.

> If you use Insomnia as your HTTP API requester, you can use the [Insomnia Rocketpay Collection](https://github.com/LuizFerK/Rocketpay/blob/main/.github/insomnia.json) to set up your requests as fast as possible!

### Users

* :green_circle: Create - POST `http://localhost:4000/api/users`

	* Request
	
		```json
		{
		  "name": "John Doe",
		  "nickname": "JohnDoe",
		  "age": 18,
		  "email": "johndoe@example.com",
		  "password": "123456"
		}
		```
	* Response - 201 Created
	
		```json
		{
		  "message": "User created",
		  "user": {
		    "account": {
		      "balance": "0.00",
		      "id": "b1fbfb8e-da6a-4fcc-bb67-f8b3a2f1180f"
		    },
		    "id": "428da228-a2e2-461e-82c9-fe7b31d67942",
		    "name": "John Doe",
		    "nickname": "JohnDoe"
		  }
		}
		```

### Operations

* :green_circle: Deposit - POST `http://localhost:4000/api/accounts/<account_id>/deposit`

	* Request
	
		```json
		{
		  "value": "25.00"
		}
		```
	* Response - 201 Created
	
		```json
		{
  		  "account": {
		    "balance": "50.00",
		    "id": "b1fbfb8e-da6a-4fcc-bb67-f8b3a2f1180f"
  		  },
  		  "message": "Ballance changed successfully"
		}
		```

* :red_circle: Withdraw - POST `http://localhost:4000/api/accounts/<account_id>/withdraw`

	* Request:
	
		```json
		{
		  "value": "25.00"
		}
		```
	* Response - 200 Ok
	
		```json
		{
  		  "account": {
		    "balance": "25.00",
		    "id": "b1fbfb8e-da6a-4fcc-bb67-f8b3a2f1180f"
  		  },
  		  "message": "Ballance changed successfully"
		}
		```

* :yellow_circle: Transaction - POST `http://localhost:4000/api/accounts/transaction`

	* Request:
	
		```json
		{
		  "value": "5.00",
		  "from": "b1fbfb8e-da6a-4fcc-bb67-f8b3a2f1180f",
		  "to": "cebe88aa-0daf-44e4-aa69-4cdd13fbadc7"
		}
		```
	* Response - 200 Ok
	
		```json
		{
  		  "message": "Transaction done successfully",
		  "transaction": {
		    "from_account": {
		      "balance": "20.00",
		      "id": "b1fbfb8e-da6a-4fcc-bb67-f8b3a2f1180f"
		    },
		    "to_account": {
		      "balance": "5.00",
		      "id": "cebe88aa-0daf-44e4-aa69-4cdd13fbadc7"
		    }
		  }
		}
		```

# :fire: Techs

### Elixir (language)

### Phoenix (web framework)
- Ecto
- Decimal
- Bcrypt

# :bug: Issues

Find a bug or error on the project? Please, feel free to send me the issue on the [Rocketpay issues area](https://github.com/LuizFerK/Rocketpay/issues), with a title and a description of your found!

If you know the origin of the error and know how to resolve it, please, send me a pull request, I will love to review it!

# :book: License

Released in 2020.

This project is under the [MIT license](https://github.com/LuizFerK/Rocketpay/blob/main/LICENSE).

<p align="center">
	< keep coding /> :rocket: :heart:
</p>
