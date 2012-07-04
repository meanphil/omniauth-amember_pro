# OmniAuth aMember Pro Strategy

This gem provides a dead simple way to authenticate to aMember Pro using OmniAuth.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'omniauth-amember_pro'
```

## Usage

First, you will need an aMember Pro or two. Once you do that, you can use it like so:

```ruby
use OmniAuth::Builder do
  provider :amember_pro, :auth_url => "https://www.example.org/amember/", :api_key => "xxxxxxxxxxxx"
end                      
```

## Auth Hash Schema

The following information is provided back to you for this provider:

```ruby
{
  uid: '12345',
  info: {
    name: 'Joe Bloggs',
    email: 'someone@example.com',
    nickname: 'login'
    first_name: 'Joe',
    last_name: 'Bloggs',
    location: 'Waikato'
  },
  extra: { raw_info: raw_api_response }
}
```

