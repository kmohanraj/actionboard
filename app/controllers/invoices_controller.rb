class InvoicesController < ApplicationController


   after_action :get_client
  def index
    @invoices = Invoice.all
  end

  def show
    @item = Item.find_by_id(params[:id])
    @invoice = Invoice.find(params[:id])
    respond_to do |format|
     format.html
     format.pdf do
       render pdf: "profile",
       template: "invoices/show.html.erb"
       # layout: 'pdf.html'
     end
    end
  end

  def pending
    @invoice = Invoice.all(params[:id])
  end


  def new
    # @client = Client.find_by_id(params[:id])
    @invoice = Invoice.new
     # @item = Item.new() 
  end


  def edit
    @invoice = Invoice.find(params[:id])
  end

  def create
   @invoice = Invoice.new(invoice_params)
    if @invoice.save
      flash[:notice] = "success"
      redirect_to :controller=>'items', :action=>'new', :id=>@invoice.id
    else
      flash[:notice] = "somthing wrong"
      render 'new'
    end
  end

  def update
    @invoice = Invoice.find(params[:id])
    if @invoice.update_attributes(invoice_params)
      flash[:notice] = "update successfully"
       redirect_to invoices_path
    else
      flash[:notice] = "update not successfully"
      render "edit"
    end
  end

  private
    def set_invoice
      @invoice = Invoice.find(params[:id])
    end

    def invoice_params
      params.require(:invoice).permit(:status, :client_id)
    end
    def item_params
      params.require(:item).permit(:description, :unit_cost,:quantity,:balance,:discount,:invoice_id)
    end

    def get_client
      @invoice = Invoice.find_by_id(params[:id])
    end

end
