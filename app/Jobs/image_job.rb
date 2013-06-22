class ImageJob < Struct.new(:interaction_id)
  def perform
    interaction = Interaction.find interaction_id
    interaction.upload_to_s3
    interaction.local_image.destroy
  end
end