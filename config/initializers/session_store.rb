# Be sure to restart your server when you modify this file.

Rails.application.config.session_store :cookie_store, key: '_starter_bootstrap_session',
                                                      expire_after: 30.days,
                                                      :httponly => true
