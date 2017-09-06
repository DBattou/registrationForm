class ClientsController < ApplicationController
  before_action :set_client, only: [:show, :edit, :update, :destroy]

  # GET /clients
  # GET /clients.json
  def index
    @clients = Client.all
  end

  # GET /clients/1
  # GET /clients/1.json
  def show
  end

  # GET /clients/new
  def new
    @client = Client.new
  end

  # GET /clients/1/edit
  def edit
  end

  # POST /clients
  # POST /clients.json
  def create
    @client = Client.new(client_params)
    respond_to do |format|
      if FreeNick.count != 0
        if @client.exists?
          # Choose random name from Nickname databa
          c = FreeNick.order("RANDOM()").first
          # Call Create with new name to add new entry in Client database
          @client = Client.create(name: c.name)
          format.html { redirect_to @client, notice: 'This nickname already exists. A new one has been chosen for you : ' + @client.name }
          format.json { render :show, status: :created, location: @client }
        elsif @client.save
          # If save succeed, remove new name from FreeNickname database
          if c = FreeNick.where("name = ?", @client.name).first
            puts 'Deleting ' + c.name + ' from FreeNickname database'
            c.destroy
          end
          format.html { redirect_to @client, notice: 'Client was successfully created.' }
          format.json { render :show, status: :created, location: @client }
        else
          format.html { render :new }
          format.json { render json: @client.errors, status: :unprocessable_entity }
        end
      else
        format.html { redirect_to @client, notice: 'Database is full. All the nicknames have been chosen' }
        format.json { render :show, status: :created, location: @client }
      end
    end
  end

  # PATCH/PUT /clients/1
  # PATCH/PUT /clients/1.json
  def update
    respond_to do |format|
      if @client.update(client_params)
        format.html { redirect_to @client, notice: 'Client was successfully updated.' }
        format.json { render :show, status: :ok, location: @client }
      else
        format.html { render :edit }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clients/1
  # DELETE /clients/1.json
  def destroy
    new_name = @client.name
    @client.destroy
    respond_to do |format|
      # The deleted nickname is added in the FreeNickname database
      FreeNick.create(name: new_name)
      format.html { redirect_to clients_url, notice: 'Client was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client
      @client = Client.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def client_params
      params.require(:client).permit(:name)
    end
end
