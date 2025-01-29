class TithesController < ApplicationController
  before_action :user_is_allowed_to_access_module?
  before_action :set_tithe, only: %i[ show edit update destroy ]
  before_action :find_month, only: :report

  # GET /tithes or /tithes.json
  def index
    @tithes = Tithe.all.order(date: :desc)
  end

  def report
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
      format.html { redirect_to tithes_url, notice: "El diezmo ha sido eliminado." }
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

    def find_month
      @month = report_params[:month]&.to_i || Time.current.month
      @year = report_params[:year]&.to_i || Time.current.year

      start_date = Date.new(@year, @month).beginning_of_month
      end_date = Date.new(@year, @month).end_of_month

      @members_tithes = Member.joins(:tithes)
                              .where(tithes: { date: start_date..end_date })
                              .where.not(tithes: { date: nil })
                              .group("members.id, members.name")
                              .select("members.name, ARRAY_AGG(tithes.date ORDER BY tithes.date ASC) AS dates_list")
                              .order("members.name ASC")
    end

    # Only allow a list of trusted parameters through.
    def tithe_params
      params.expect(tithe: [ :amount, :note, :date, :member_id ])
    end

    def report_params
      params.permit(:month, :year)
    end
end
