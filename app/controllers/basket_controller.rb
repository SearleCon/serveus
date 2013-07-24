class BasketController < ApplicationController
  expose(:basket) { current_user.basket }

  def update
      incident = Incident.find(params[:incident][:id])
      interactions = Interaction.find(params[:interaction_ids])
      incident.interactions << interactions
      basket.interactions.delete(interactions)
      redirect_to basket_url
  end
end
