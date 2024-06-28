require 'httparty'
require 'nokogiri'

module LectureHelper
  include HTTParty
  base_uri 'https://www.youtube.com'

  def self.obter_tempo_total_video_youtube(video_id)
    begin
      url = "/watch?v=#{video_id}"
      response = get(url)
      if response.success?
        doc = Nokogiri::HTML(response.body)
        duration_element = doc.at('meta[itemprop="duration"]')
        if duration_element
          duration = duration_element['content']
          return duration
        else
          return "Tempo total não encontrado"
        end
      else
        Rails.logger.error "Erro ao acessar a página do YouTube: #{response.code}"
        return "Erro ao acessar a página"
      end
    rescue StandardError => e
      Rails.logger.error "Erro ao acessar a página do YouTube: #{e.message}"
      return "Erro ao acessar a página"
    end
  end
end
