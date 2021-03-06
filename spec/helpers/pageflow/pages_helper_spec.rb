require 'spec_helper'

module Pageflow
  describe PagesHelper do
    describe '#page_css_class' do
      it 'contains invert class if invert configuration option is present' do
        page = build(:page, :configuration => {'invert' => true})

        css_classes = helper.page_css_class(page).split(' ')

        expect(css_classes).to include('page')
        expect(css_classes).to include('invert')
      end

      it 'contains invert class if hide_title configuration option is present' do
        page = build(:page, :configuration => {'hide_title' => true})

        css_classes = helper.page_css_class(page).split(' ')

        expect(css_classes).to include('page')
        expect(css_classes).to include('hide_title')
      end

      it 'contains text_position_right class if text_position is right' do
        page = build(:page, :configuration => {'text_position' => 'right'})

        css_classes = helper.page_css_class(page).split(' ')

        expect(css_classes).to include('page')
        expect(css_classes).to include('text_position_right')
      end
    end

    describe '#page_thumbnail_image_class' do
      before { helper.extend(FileThumbnailsHelper) }

      it 'returns file_thumbnail_css_class of thumbnail_file of page' do
        image_file = create(:image_file)
        page = build(:page, template: 'background_image', configuration: {'thumbnail_image_id' => image_file.id})

        css_class = helper.page_thumbnail_image_class(page, false)

        expect(css_class).to eq("pageflow_image_file_link_thumbnail_#{image_file.id}")
      end

      it 'returns large variant for hero' do
        image_file = create(:image_file)
        page = build(:page, template: 'background_image', configuration: {'thumbnail_image_id' => image_file.id})

        css_class = helper.page_thumbnail_image_class(page, true)

        expect(css_class).to eq("pageflow_image_file_link_thumbnail_large_#{image_file.id}")
      end
    end
  end
end
