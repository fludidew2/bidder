class StripeController < ApplicationController
  # before_action :check_stripe_setup, only: [:show, :edit] # Adjust actions as needed

  def connect
    if params[:account].present?
      # The account ID is passed in the `account` parameter
      account_id = params[:account]
  
      # Verify that the account ID matches the user's account ID
      if current_user.stripe_account_id == account_id
        redirect_to root_path, notice: 'Your Stripe account has been connected.'
      else
        redirect_to root_path, alert: 'Failed to connect your Stripe account. Please try again.'
      end
    else
      redirect_to root_path, alert: 'Failed to connect your Stripe account. Please try again.'
    end
  end

  def create_account
    if current_user.stripe_account_id.present?
      # If the user already has a Stripe account, retrieve it
      account = Stripe::Account.retrieve(current_user.stripe_account_id)
    else
      # If the user does not have a Stripe account, create a new one
      account = Stripe::Account.create({
        type: 'express',
        email: current_user.email,
        business_type: 'individual',
        business_profile: {
          mcc: '5818',
          first_name: current_user.profile.first_name,
          last_name: current_user.profile.last_name,
          name: current_user.profile.business_name,
          product_description: current_user.profile.about
          
        },
        individual: {
          email: current_user.email,
        },
        capabilities: {
          card_payments: {requested: true},
          transfers: {requested: true},
        },
        settings: {
          payouts: {
            schedule: {
              interval: 'daily',
            },
          },
        },
      })
    
      # Save the account ID in the user's record
      current_user.update(stripe_account_id: account.id)
    end
  
    # Create an account link for the user to complete the onboarding process
    account_link = Stripe::AccountLink.create({
      account: account.id,
      refresh_url: stripe_callback_url,
      return_url: stripe_callback_url,
      type: 'account_onboarding',
    })
  
    # Redirect the user to the account application
    redirect_to account_link.url, allow_other_host: true
  end
 
    def callback
    # Handle the callback from Stripe after the user completes the onboarding process
    account = Stripe::Account.retrieve(current_user.stripe_account_id)
  
    if account.charges_enabled || account.payouts_enabled
      # Onboarding complete or pending verification
      current_user.update(
        stripe_status: account.requirements.currently_due.empty? ? 'complete' : 'pending_verification'
      )
      redirect_to edit_profile_path(current_user.profile), notice: 'Stripe account successfully connected.'
    else
      # Onboarding incomplete
      redirect_to edit_profile_path(current_user.profile), alert: 'Stripe account connection failed. Please try again.'
    end
  end

  def dashboard
    account = Stripe::Account.retrieve(current_user.stripe_account_id)
    login_links = account.login_links.create

    redirect_to login_links.url, allow_other_host: true 
  end

end