class LisImagesController < ApplicationController
	include ListingsHelper
	
	before_filter :load_listing, :correct_user

	def index
		@lis_images = LisImage.where(listing_id: params[:listing_id])
	end

	def new
		@lis_image = LisImage.new
	end
	
	def create
		@lis_image = @listing.lis_images.build(params_image)
		# @lis_thumb_image = @listing.lis_thumb_image.build(params_image)

	    if @lis_image.save
	      redirect_to listing_lis_images_path(@listing), :alert => "Image Added"
	    else
	      render 'new', alert: 'Error image not uploaded'
	    end
	end


	def show
		@lis_image = LisImage.find(params[:id])
	end
		
	def destroy
		@lis_image = LisImage.find(params[:id])
		@lis_image.destroy
		redirect_to listing_lis_images_path(@listing), alert: "Image deleted"
	end


	private

	def params_image
    	params.require(:lis_image).permit(:file, :remote_file_url)
	end

	def load_listing
		@listing = Listing.find(params[:listing_id])
	end

	def correct_user
		redirect_to root_path unless current_user?(@listing.user)
	end


end