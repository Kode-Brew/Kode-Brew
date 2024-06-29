module VideosHelper
  def formatar_tempo(tempo_formato)
    match = tempo_formato.match(/PT(?<minutos>\d+)M(?<segundos>\d+)S/)

    if match
      minutos = match[:minutos].to_i
      segundos = match[:segundos].to_i

      horas = minutos / 60
      minutos = minutos % 60

      if horas > 0
        tempo_formatado = "%02d:%02d:%02d" % [horas, minutos, segundos]
      else
        tempo_formatado = "%02d:%02d" % [minutos, segundos]
      end

      tempo_formatado.sub(/^00:/, '')
    else
      "Formato de tempo inválido"
    end
  end
end
