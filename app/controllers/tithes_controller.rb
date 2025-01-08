class TithesController < ApplicationController
  before_action :user_is_allowed_to_access_module?
  before_action :set_tithe, only: %i[ show edit update destroy ]

  # GET /tithes or /tithes.json
  def index
    @tithes = Tithe.all
  end

  # GET /tithes/1 or /tithes/1.json
  def show
  end

  # GET /tithes/new
  def new
    @tithe = Tithe.new
  end

  # GET /tithes/1/edit
  def edit
  end

  # POST /tithes or /tithes.json
  def create
    @tithe = Tithe.new(tithe_params)

    respond_to do |format|
      if @tithe.save
        format.html { redirect_to @tithe, notice: "El diezmo ha sido creado." }
        format.json { render :show, status: :created, location: @tithe }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @tithe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tithes/1 or /tithes/1.json
  def update
    respond_to do |format|
      if @tithe.update(tithe_params)
        format.html { redirect_to @tithe, notice: "El diezmo ha sido actualizado." }
        format.json { render :show, status: :ok, location: @tithe }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @tithe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tithes/1 or /tithes/1.json
  def destroy
  begin
    @tithe.destroy
    respond_to do |format|
      format.html { redirect_to offerings_url, notice: "El diezmo ha sido eliminado." }
      format.json { head :no_content }
    end
  rescue ActiveRecord::InvalidForeignKey => e
    respond_to do |format|
      format.html { redirect_to @tithe, notice: "El diezmo no pudo ser eliminado." }
      format.json { render json: { error: e.message }, status: :unprocessable_entity }
    end
  end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tithe
      @tithe = Tithe.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def tithe_params
      params.expect(tithe: [ :amount, :note, :date, :member_id ])
    end
end
