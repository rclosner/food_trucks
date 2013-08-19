ActiveAdmin.register Location do

  action_item only: :show do
    link_to "All Time Slots", admin_location_time_slots_path(location)
  end

  action_item only: :show do
    link_to "Create Time Slot", new_admin_location_time_slot_path(location)
  end

  show do
    panel "Time Slots" do

      order = ""
      if params[:order]
        order = [ params[:order].gsub(/_(asc|desc)/, ''), params[:order].include?('asc') ? 'asc' : 'desc' ].join(" ")
      end

      table_for(vendor.time_slots.order(order), sortable: true) do |t|
        t.column :start_at, sortable: :start_at
        t.column :finish_at, sortable: :finish_at
        t.column :vendor, sortable: :vendor_id
        t.column(:actions) do |time_slot|
          [ link_to("View", admin_vendor_time_slot_path(vendor_id: vendor.id, id: time_slot)), 
            link_to("Edit", edit_admin_vendor_time_slot_path(vendor_id: vendor.id, id: time_slot)), 
            link_to("Delete", admin_vendor_time_slot_path(vendor_id: vendor.id, id: time_slot.id), method: :delete) ].join(", ").html_safe
        end

      end
    end
    active_admin_comments
  end

  sidebar :location_attributes, only: :show do
    attributes_table_for resource do
      row :name
      row :address
      row :latitude
      row :longitude
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :address
      f.input :meter_id
      f.input :latitude
      f.input :longitude
    end
    f.buttons
  end

end
