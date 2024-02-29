# frozen_string_literal: true

class PeopleController < ApplicationController
  before_action :set_person, only: [:show, :edit, :update, :destroy]

  # GET /people/new
  def new
    @person = Person.new
  end

  # GET /people/:id/edit
  def edit
  end

  # GET /people
  # GET /people.json
  def index
    @people = Person.all

    respond_to do |format|
      format.html # Render the HTML view
      format.json { render json: @people } # Respond with JSON data
    end
  end

  # GET /people/:id
  # GET /people/:id.json
  def show
    @details = @person.details
    respond_to do |format|
      format.html {render partial: 'person_details'}# Render the HTML view
      format.json { render json: @person, include: :details } # Respond with JSON data
    end
  end

  # POST /people
  # POST /people.json
  def create
    @person = Person.new(person_params)

    respond_to do |format|
      if @person.save
        format.html { redirect_to people_path, notice: 'Person was successfully created.' }
        format.json { render json: @person, status: :created }
      else
        format.html { render :new }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /people/:id
  # PATCH/PUT /people/:id.json
  def update
    respond_to do |format|
      if @person.update(person_params)
        format.html { redirect_to people_path, notice: 'Person was successfully updated.' }
        format.json { render json: @person }
      else
        format.html { render :edit }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /people/:id
  # DELETE /people/:id.json
  def destroy
    @person.destroy
    respond_to do |format|
      format.html { redirect_to people_url, notice: 'Person was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def person_params
    params.require(:person).permit(:name, :email)
  end

  def set_person
    @person = Person.find(params[:id])
  end
end
