class OfferingsController < ApplicationController
  before_action :user_is_allowed_to_access_module?
  before_action :set_offering, only: %i[ show edit update destroy ]

  # GET /offerings or /offerings.json
  def index
    @offerings = Offering.all.order(date: :desc)
  end

  # GET /offerings/1 or /offerings/1.json
  def show
  end

  # GET /offerings/new
  def new
    @offering = Offering.new
  end

  # GET /offerings/1/edit
  def edit
  end

  # POST /offerings or /offerings.json
  def create
    @offering = Offering.new(offering_params)

    respond_to do |format|
      if @offering.save
        format.html { redirect_to @offering, notice: "La ofrenda ha sido creada." }
        format.json { render :show, status: :created, location: @offering }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @offering.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /offerings/1 or /offerings/1.json
  def update
    respond_to do |format|
      if @offering.update(offering_params)
        format.html { redirect_to @offering, notice: "La ofrenda ha sido actualizada." }
        format.json { render :show, status: :ok, location: @offering }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @offering.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /offerings/1 or /offerings/1.json
  def destroy
    begin
      @offering.destroy
      respond_to do |format|
        format.html { redirect_to offerings_url, notice: "La ofrenda ha sido eliminada." }
        format.json { head :no_content }
      end
    rescue ActiveRecord::InvalidForeignKey => e
      respond_to do |format|
        format.html { redirect_to @offering, notice: "La ofrenda no pudo ser eliminada." }
        format.json { render json: { error: e.message }, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_offering
      @offering = Offering.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def offering_params
      params.expect(offering: [ :amount, :offering_type, :date, :note, :member_id ])
    end
end
