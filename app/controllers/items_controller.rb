class ItemsController < ApplicationController

	before_action :get_client

  def index
  	@items = Item.all
    @client = Client.all
  end

  def new
  	@item = Item.new
  	# @invoice = Invoice.find_by(id: params[:id])
  end


   def create
    # @invoice = Invoice.find_by(params[:id])
    # params[:id] = Invoice.find_by_id(params[:id])
    @item = Item.new(item_params)
    # if @item.save
    if @item.save
       # @item.update_attributes(:invoice_id=>@invoice.id)
      flash[:notice] = 'success'
      redirect_to :controller=>'items', :action=>'index'
    else
      flash[:notice] = 'somthing wrong'
      render 'new'
    end
  end


   def show
    @client = Client.find_by_id(params[:id])
    @item = Item.find(params[:id])
    respond_to do |format|
     format.html
     format.pdf do
       render pdf: "profile",
       # template: "items/show.html.erb"
       template: "items/show.html.erb"
       # layout: 'pdf.html'
     end
    end
  end

  # def show
  #   @item = Item.find(params[:id])
  #   # if stale?(last_modified: @item.updated_at, public: true)
  #     render json: @item
  #   # end
  # end

  def edit
    @item = Item.find(params[:id])
  end

  def profile
    @item = Item.find(params[:id])
    respond_to do |format|
     format.html
     format.pdf do
       render pdf: "profile",
       # template: "items/show.html.erb"
       template: "items/profile.html.erb"
       # layout: 'pdf.html'
     end
    end
  end

  def update
    @item = Item.find(params[:id])
    if @item.update_attributes(item_params)
      flash[:notice] = "update successfully"
      redirect_to items_path
    else
      flash[:notice] = "update not successfully"
      render "edit"
    end
  end

  def bending_bill

  end


   private
    
    def item_params
      params.require(:item).permit(:description, :unit_cost,:quantity,:balance,:tax, :discount,:invoice_id, :status, :client_id)
    end

    def invoice_params
      params.require(:invoice).permit(:status, :client_id)
    end
    
    def get_client
    	@client = Client.find_by(params[:id])
    end

end
