class Form < ActiveRecord::Base
  attr_accessible :name, :description, :form_pdf, :dealership_id

  belongs_to :dealership

  validates_presence_of :name, :dealership_id, :form_pdf

  has_attached_file :form_pdf
  validates_attachment :form_pdf, content_type: { content_type: ['application/pdf', 'application/msword', 'text/plain'] }, size: { less_than: 20.megabytes }

end