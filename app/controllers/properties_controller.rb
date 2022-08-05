# frozen_string_literal: true

class PropertiesController < ApplicationController
  before_action :set_property, only: %i[show edit update destroy]
  before_action :authenticate_account!, only: %i[new create destroy]
  before_action :set_sidebar, except: %i[show]

  # GET /properties
  # GET /properties.json
  def index
    @properties = Property.all
  end

  # GET /properties/1
  # GET /properties/1.json
  def show
    @agent = @property.account
    @agent_properties = Property.where(account_id: @agent.id).where.not(id: @property.id)
  end

  # GET /properties/new
  def new
    @property = Property.new
  end

  # GET /properties/1/edit
  def edit; end

  # POST /properties
  # POST /properties.json
  def create
    @property = Property.new(property_params)
    @property.account_id = current_account.id

    respond_to do |format|
      if @property.save
        format.html { redirect_to @property, notice: 'Property was successfully created.' }
        format.json { render :show, status: :created, location: @property }
      else
        format.html { render :new }
        format.json { render json: @property.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /properties/1
  # PATCH/PUT /properties/1.json
  def update
    respond_to do |format|
      if @property.update(property_params)
        format.html do
          redirect_to @property, notice: 'Property was successfully
          updated.'
        end
        format.json { render :show, status: :ok, location: @property }
      else
        format.html { render :edit }
        format.json do
          render json: @property.errors, status:
          :unprocessable_entity
        end
      end
    end
  end

  # DELETE /properties/1
  # DELETE /properties/1.json
  def destroy
    @property.destroy
    respond_to do |format|
      format.html do
        redirect_to properties_url, notice: 'Property was successfully
        destroyed.'
      end
      format.json { head :no_content }
    end
  end

  def email_agent
    # trigger email send
    agent_id = params[:agent_id]
    first_name = params[:first_name]
    last_name = params[:last_name]
    email = params[:email]
    message = params[:message]

    ContactMailer.email_agent(agent_id, first_name, last_name, email, message).deliver_now

    # response to script
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_property
    @property = Property.find(params[:id])
  end

  def set_sidebar
    @show_sidebar = true
  end

  # Only allow a list of trusted parameters through.
  def property_params
    params.require(:property).permit(:name, :details, :address, :parking_spaces,
                                     :price, :room, :bathroom, :photo,
                                     :photo_cache, :for_sale, :available_date,
                                     :status)
  end
end
