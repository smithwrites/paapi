module Api
  module V1
    class PlanningApplicationsController < ApplicationController
      def index
        if params[:uprn].present?
          @planning_applications = Property.find_by_uprn(params[:uprn]).planning_applications
        else
          @planning_applications = PlanningApplication.all
        end
      end

      def create
        binding.pry
        PlanningApplicationCreation.new(**planning_application_params.merge(local_authority: local_authority))

        PlanningApplicationCreation.new(
          local_authority: local_authority,
          reference: row[:reference],
          area: row[:area],
          proposal_details: row[:proposal_details],
          received_at: row[:received_at],
          officer_name: row[:officer_name],
          decision: row[:decision],
          decision_issued_at: row[:decision_issued_at],
          view_documents: row[:view_documents],
          uprn: row[:uprn],
          property_code: row[:property_code],
          property_type: row[:property_type],
          full: row[:full],
          address: row[:address],
          town: row[:town],
          postcode: row[:postcode],
          map_east: row[:map_east],
          map_north: row[:map_north],
          ward_code: row[:ward_code],
          ward_name: row[:ward_name],
        ).perform
      end

      private

      def planning_application_params
        permitted_keys = [:reference,
                          :area,
                          :proposal_details,
                          :received_at,
                          :officer_name,
                          :decision,
                          :decision_issued_at,
                          :view_documents,
                          :uprn,
                          :property_code,
                          :property_type,
                          :full,
                          :address,
                          :town,
                          :postcode,
                          :map_east,
                          :map_north,
                          :ward_code,
                          :ward_name]

        params.permit permitted_keys
      end
    end
  end
end
