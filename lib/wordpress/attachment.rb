module Refinery
  module WordPress
    class Attachment
      attr_reader :node
      attr_reader :refinery_image
      attr_reader :refinery_resource

      def initialize(node)
        @node = node
      end

      def title
        node.xpath("title").text
      end

      def description
        node.xpath("description").text
      end

      def file_name
        url.split('/').last
      end

      def post_date
        DateTime.parse node.xpath("wp:post_date").text
      end

      def url
        node.xpath("wp:attachment_url").text
      end

      def url_pattern
        url_parts = url.split('.')
        extension = url_parts.pop
        url_without_extension = url_parts.join('.')

        /#{url_without_extension}(-\d+x\d+)?\.#{extension}/
      end

      def image?
        url.match /\.(png|jpg|jpeg|gif)$/ 
      end

      def to_refinery
        if image?
          to_image
        else
          to_resource
        end
      end

      def replace_url
        if image?
          replace_image_url
        else
          replace_resource_url
        end
      end

      private

      def to_image
        image = ::Image.new
        image.created_at = post_date
        image.image_url = url
        image.save!

        @refinery_image = image
        image
      end

      def to_resource
        resource = ::Resource.new
        resource.created_at = post_date
        resource.file_url = url
        resource.save!

        @refinery_resource = resource
        resource
      end

      def replace_image_url
        replace_image_url_in_guides
      end

      def replace_resource_url
        replace_resource_url_in_guides
      end
      
      def replace_image_url_in_guides
        replace_url_in_guides(refinery_image.image.url)
      end
      
      def replace_resource_url_in_guides
        replace_url_in_guides(refinery_resource.file.url)
      end

      def replace_url_in_guides(new_url)
        ResourceGuide.all.each do |guide|
          if (! guide.body.to_s.blank?) && guide.body.include?(url)
            puts "Replacing #{url_pattern} with #{new_url}"
            guide.body = guide.body.gsub(url_pattern, new_url)
            guide.save!
          end
        end
      end

    end
  end
end
