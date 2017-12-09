class QuestionaryResultsController < ApplicationController
  require 'csv'
  before_action :set_questionary_result, only: [:show, :edit, :update, :destroy]

  # GET /questionary_results
  # GET /questionary_results.json
  def index
    @questionaries = Questionary.all
  end

  # GET /questionary_results/1
  # GET /questionary_results/1.json
  def show
    @questionary = Questionary.find params[:id]
    @questionary_items= @questionary.questionary_item
  end

  # GET /questionary_results/new
  def new
    @questionary_result = QuestionaryResult.new
  end

  # GET /questionary_results/1/edit
  def edit
  end

  # POST /questionary_results
  # POST /questionary_results.json
  def create
    @questionary_result = QuestionaryResult.new(questionary_result_params)

    respond_to do |format|
      if @questionary_result.save
        format.html { redirect_to @questionary_result, notice: 'Questionary result was successfully created.' }
        format.json { render :show, status: :created, location: @questionary_result }
      else
        format.html { render :new }
        format.json { render json: @questionary_result.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questionary_results/1
  # PATCH/PUT /questionary_results/1.json
  def update
    respond_to do |format|
      if @questionary_result.update(questionary_result_params)
        format.html { redirect_to @questionary_result, notice: 'Questionary result was successfully updated.' }
        format.json { render :show, status: :ok, location: @questionary_result }
      else
        format.html { render :edit }
        format.json { render json: @questionary_result.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questionary_results/1
  # DELETE /questionary_results/1.json
  def destroy
    @questionary_result.destroy
    respond_to do |format|
      format.html { redirect_to questionary_results_url, notice: 'Questionary result was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def download
    questionary = Questionary.find params[:id]
    questionary_items= questionary.questionary_item

    csv_result = CSV.generate do |csv|
      csv << [questionary.title]
      csv << ['質問', '集計']
      questionary_items.each do |item|
        aggregate = ''
        results = item.aggregate
        results.each do |key, val|
          content = QuestionaryChoice.find(key).content
          aggregate += content + val.to_s + "\n"
        end
        csv << [item.content, aggregate]
      end
    end

    respond_to do |format|
      format.csv do
        send_data csv_result, filename: "question.csv", type: 'text/csv; charset=shift_jis'
      end
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_questionary_result
      @questionary_result = QuestionaryResult.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def questionary_result_params
      params.require(:questionary_result).permit(:questionary_id, :result)
    end
end
