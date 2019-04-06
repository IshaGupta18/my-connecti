class PostSerializer < ActiveModel::Serializer
  attributes :id, :content	#post's table's attributes
  has_many :comments, serializer: CommentMinSerializer #serializers are only for jason
  belongs_to :user
end
