class Document < ApplicationRecord
  belongs_to :peer
  belongs_to :candidate
	has_one_attached :document
  #has_attached_file :document, styles: { medium: "300x300>", thumb: "100x100>" }
  validates_presence_of :name
  #validates_attachment_presence :document
  #validates_attachment_content_type :document, :content_type => ["image/gif", "image/jpeg", "image/jpg", "image/png", "application/pdf", "application/msword", "application/vnd.openxmlformats-officedocument.wordprocessingml.document"]

	def document_full
	  document
	end
	def document_thumb
		document.variant(resize: '100x100')
	end
end
