# frozen_string_literal: true

class BlueprintsController < ApplicationController
  before_action :authenticate!

  def index
    @table_params = { search: {}, order: {} }
    @blueprints = current_user.blueprints.ordered.page(params[:page])

    search = params[:search]
    if search.present?
      @table_params[:search] = search.to_unsafe_hash
      @blueprints = @blueprints.search(search[:term]) if search[:term].present?
    end

    order = params[:order]
    if order.present?
      @table_params[:order] = order.to_unsafe_hash
      if order[:column].present? && order[:value].present?
        @blueprints = @blueprints.reorder(order[:column] => order[:value])
      end
    end
  end

  def new
    @blueprint = current_user.blueprints.build
  end

  def show
    @blueprint = current_user.blueprints.find(params[:id])
  end

  def create
    @blueprint = current_user.blueprints.build(blueprint_params)

    if @blueprint.save
      respond_to do |format|
        format.js { render(layout: false) }
        format.html do
          redirect_to(blueprints_path, notice: "Vorlage wurde angelegt")
        end
      end
    else
      render(:new)
    end
  end

  def edit
    @blueprint = current_user.blueprints.find(params[:id])
  end

  def update
    @blueprint = current_user.blueprints.find(params[:id])

    if @blueprint.update(blueprint_params)
      redirect_to(blueprints_path, notice: "Vorlage wurde gespeichert")
    else
      render(:edit)
    end
  end

  def destroy
    blueprint = current_user.blueprints.find(params[:id])
    blueprint.destroy!

    redirect_to(blueprints_path, notice: "Vorlage wurde gelöscht")
  end

  private

  def blueprint_params
    params.require(:blueprint).permit(
      :name,
      :note,
      :flags,
      :tbnr,
      # TODO: (PS) add all flags here, so they can be set via the edit form
      :vehicle_empty,
      :hazard_lights,
      :expired_tuv,
      :expired_eco,
      :over_2_8_tons,
    )
  end
end
