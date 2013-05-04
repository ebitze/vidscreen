# == Schema Information
#
# Table name: vidposts
#
#  id         :integer          not null, primary key
#  vid_id     :string(255)
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Vidpost < ActiveRecord::Base
  attr_accessible :vid_id
  belongs_to :user

  VID_URL_OR_ID_REGEX = /(\A[a-z0-9_-]{11}\z)|(v=[a-z0-9_-]{11})/i

  before_save { |vidpost| 
    if (vidpost.vid_id.match(VID_URL_OR_ID_REGEX))
      vidpost.vid_id = vidpost.vid_id.match(VID_URL_OR_ID_REGEX)[0].split('=').last
    end
  }

  validates :user_id, presence: true
  validates :vid_id, presence: true,
                      format:   { with: VID_URL_OR_ID_REGEX}

  default_scope order: 'vidposts.created_at DESC'

end
