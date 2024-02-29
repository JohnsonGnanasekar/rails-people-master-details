# frozen_string_literal: true

class DetailsController < ApplicationController
  before_action :set_person
  before_action :set_detail, only: [:edit, :update, :destroy]

  # GET /people/:person_id/details/new
  def new
    @detail = @person.details.build
    render partial: 'details/new'
  end

  # GET /people/:person_id/details/:id/edit
  def edit
    render partial: 'details/edit'
  end

  # GET /people/:person_id/details
  # GET /people/:person_id/details.json
  def index
    @details = @person.details

    respond_to do |format|
      format.html { render partial: 'details/index'}# Render the HTML view
      format.json { render json: @details } # Respond with JSON data
    end
  end

  # POST /people/:person_id/details
  # POST /people/:person_id/details.json
  def create
    @detail = @person.details.new(detail_params)

    respond_to do |format|
      if @detail.save
        format.html { redirect_to person_details_path(@person), notice: 'Detail was successfully created.' }
        format.json { render json: @detail, status: :created }
      else
        format.html { render :new }
        format.json { render json: @detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /people/:person_id/details/:id
  # PATCH/PUT /people/:person_id/details/:id.json
  def update
    respond_to do |format|
      if @detail.update(detail_params)
        format.html { redirect_to person_details_path(@person), notice: 'Detail was successfully updated.' }
        format.json { render json: @detail }
      else
        format.html { render :edit }
        format.json { render json: @detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /people/:person_id/details/:id
  # DELETE /people/:person_id/details/:id.json
  def destroy
    @detail.destroy
    respond_to do |format|
      format.html { redirect_to person_details_path(@person), notice: 'Detail was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_person
    @person = Person.find(params[:person_id])
  end

  def set_detail
    @detail = @person.details.find(params[:id])
  end

  def detail_params
    params.require(:detail).permit(:detail_type, :detail_value)
  end
end