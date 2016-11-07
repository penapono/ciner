module Admin
  class SetFunctionsController < AdminController
    # exposes
    expose(:set_functions) { SetFunction.order(:name) }
    expose(:set_function, attributes: :set_function_attributes)

    def new
    end

    def create
      if set_function.save
        flash.notice = t('.success')
        redirect_to action: :index
      else
        flash.alert = t('.failure')
        render :new
      end
    end

    def index
      self.set_functions = set_functions.page(params[:page]).per(15)
    end

    def edit
    end

    def update
      if set_function.save
        flash.notice = t('.success')
        redirect_to action: :show
      else
        flash.alert = t('.failure')
        render :edit
      end
    end

    def show
    end

    def destroy
      if set_function.destroy
        flash.notice = t('.success')
      else
        flash.alert = t('.failure')
      end
      redirect_to action: :index
    end

    private

    def set_function_params
      params.require(:set_function).permit(
        :name, :description
      )
    end
  end
end
